import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/helper/shared_prefs_helper.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/api/api_service.dart';
import 'package:digital_lync/services/tracking_queue_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

int? userId;
String? empId;
String? token;
String? empmId;
String? slpCode;
String? username;
String? userEmail;
dynamic userPhone;
String? profilePicture;
List? followUpsDateList;
bool isReachedOut = false;
TaskProvider? taskProvider;
ApiServices apiServices = ApiServices();
final serviceInitialize = FlutterBackgroundService();
ValueNotifier<bool> checkInStatus = ValueNotifier<bool>(true);
final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
bool _trackingRequestInProgress = false;

Future<Map<String, String>> getHeaders() async {
  token = SharedPrefsHelper.getString("token");

  final bool isTokenInvalid =
      token == null || token!.isEmpty || JwtDecoder.isExpired(token!);
  if (isTokenInvalid) {
    appLogout();
    return {};
  }
  return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}

Future personalDetails() async {
  userId = SharedPrefsHelper.getInt("userId") ?? 0;
  token = SharedPrefsHelper.getString("token") ?? "";
  empId = SharedPrefsHelper.getString("empId") ?? "";
  empmId = SharedPrefsHelper.getString("empmId") ?? "";
  slpCode = SharedPrefsHelper.getString("slpCode") ?? "";
  userEmail = SharedPrefsHelper.getString("email") ?? "";
  userPhone = SharedPrefsHelper.getString("mobile") ?? "";
  username = SharedPrefsHelper.getString("username") ?? "";
  profilePicture = SharedPrefsHelper.getString("profilePicture") ?? "";
}

// --- BACKGROUND SERVICE ENTRY POINT ---
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  await SharedPrefsHelper.init();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('stopService').listen((event) {
      service.stopSelf();
    });
  }

  // Immediate first tracking on service start
  await performTracking(service);

  Timer.periodic(const Duration(minutes: 2), (timer) async {
    bool isServiceEnabled = SharedPrefsHelper.getBool('isService') ?? false;
    if (!isServiceEnabled) {
      timer.cancel();
      service.stopSelf();
      return;
    }
    await performTracking(service);
  });
}

class TrackingSyncResult {
  const TrackingSyncResult({required this.pending, this.rejectionReason});

  final int pending;
  final String? rejectionReason;
}

bool _needsReadableAddress(String address) =>
    address.trimLeft().startsWith('Location:');

String _formatPlacemark(Placemark placemark) {
  final parts = <String?>[
    placemark.name,
    placemark.thoroughfare,
    placemark.street,
    placemark.subLocality,
    placemark.locality,
    placemark.administrativeArea,
    placemark.postalCode,
    placemark.country,
  ]
      .whereType<String>()
      .map((part) => part.trim())
      .where((part) => part.isNotEmpty)
      .toSet();
  return parts.join(', ');
}

Future<void> _enrichPendingTrackingAddresses({
  required int authenticatedUserId,
}) async {
  final queue = TrackingQueueService.instance;
  final pending = await queue.pendingPoints(
    userId: authenticatedUserId,
    limit: 10,
  );

  for (final point in pending.where(
    (point) => _needsReadableAddress(point.address),
  )) {
    try {
      final placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      ).timeout(const Duration(seconds: 15));
      if (placemarks.isEmpty) break;

      final readableAddress = _formatPlacemark(placemarks.first);
      if (readableAddress.isEmpty) break;
      await queue.updateAddress(
        pointId: point.pointId,
        address: readableAddress,
      );
    } catch (error) {
      print('Reverse geocoding deferred for offline point: $error');
      break;
    }
  }
}

Future<TrackingSyncResult> syncPendingTrackingPoints({
  required int authenticatedUserId,
  required String authToken,
}) async {
  final queue = TrackingQueueService.instance;
  await _enrichPendingTrackingAddresses(
    authenticatedUserId: authenticatedUserId,
  );
  final points = (await queue.pendingPoints(userId: authenticatedUserId))
      .where((point) => !_needsReadableAddress(point.address))
      .toList();
  if (points.isEmpty) {
    return TrackingSyncResult(
      pending: await queue.pendingCount(userId: authenticatedUserId),
    );
  }

  final pointIds = points.map((point) => point.pointId).toList();
  String? rejectionReason;
  try {
    final response = await apiServices.autoTrackingBatch(
      points: points.map((point) => point.toApiJson()).toList(),
      authToken: authToken,
    );
    if (response.statusCode != 200) {
      await queue.markRetry(pointIds, 'HTTP ${response.statusCode}');
      return TrackingSyncResult(
        pending: await queue.pendingCount(userId: authenticatedUserId),
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final results = body['results'] as List<dynamic>? ?? const [];
    final acknowledged = <String>[];
    for (final rawResult in results) {
      final result = rawResult as Map<String, dynamic>;
      final pointId = result['pointId']?.toString();
      final status = result['status']?.toString();
      if (pointId == null) continue;
      if (status == 'accepted' || status == 'duplicate') {
        acknowledged.add(pointId);
      } else if (status == 'rejected') {
        rejectionReason = result['reason']?.toString() ?? 'rejected_by_server';
        await queue.markRejected(
          pointId,
          rejectionReason,
        );
      }
    }
    await queue.deleteAcknowledged(acknowledged);
  } catch (error) {
    await queue.markRetry(pointIds, error.toString());
  }
  return TrackingSyncResult(
    pending: await queue.pendingCount(userId: authenticatedUserId),
    rejectionReason: rejectionReason,
  );
}

Future<void> performTracking(ServiceInstance service, {Timer? timer}) async {
  Future<void> updateNotification(String text) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          content: text,
          title: "Nagarjuna Steel",
        );
      }
    }
  }

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService() == false) {
      timer?.cancel();
      return;
    }
  }

  if (_trackingRequestInProgress) {
    return;
  }
  _trackingRequestInProgress = true;

  try {
    // Data Fetching
    int? bgUserId = SharedPrefsHelper.getInt("userId");

    String? bgToken = SharedPrefsHelper.getString("token");

    if (bgUserId == null || bgToken == null || bgToken.isEmpty) {
      return;
    }
    // GPS Check
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      await updateNotification("⚠️ GPS is OFF");
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await updateNotification("⚠️ Permission Denied");
      return;
    }
    await updateNotification("Getting location...");

    Position? position;
    /*  try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          forceLocationManager: true,
          timeLimit: const Duration(seconds: 45),
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      );
    } catch (e) {
      position = await Geolocator.getLastKnownPosition();
    } */

    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          timeLimit: const Duration(seconds: 30),
        ),
      );
    } catch (e) {
      print(
        "⚠️ Live GPS fetch failed ($e). Skipping update to ensure 100% fresh location.",
      );
      await updateNotification("Weak GPS Signal");
      return;
    }

    // --- 🚨 SECURITY CHECK: FAKE GPS 🚨 ---
    if (position.isMocked) {
      print("🚨 FAKE GPS DETECTED! Triggering Logout.");
      // 1. Notification show
      await showNotification(
        "Security Warning ⚠️",
        "Your mobile is sending fake location. Turn off fake location otherwise user will be blocked.",
      );
      await SharedPrefsHelper.remove("token");
      await SharedPrefsHelper.setBool('isLogin', false);
      service.invoke("force_logout_event");
      service.stopSelf();
      timer?.cancel();
      return;
    }
    // --- SECURITY END ---
    // Round raw GPS to 6 decimal places to prevent floating point representation noise
    double rawLat = double.parse(position.latitude.toStringAsFixed(6));
    double rawLng = double.parse(position.longitude.toStringAsFixed(6));

    final useOfflineQueue =
        SharedPrefsHelper.getBool('professionalTrackingQueue') ?? true;
    if (useOfflineQueue) {
      final queue = TrackingQueueService.instance;
      await queue.enqueue(
        userId: bgUserId,
        latitude: rawLat,
        longitude: rawLng,
        address: 'Location: $rawLat, $rawLng',
        accuracy: position.accuracy,
        speed: position.speed,
        heading: position.heading,
        capturedAt: position.timestamp,
      );
      final syncResult = await syncPendingTrackingPoints(
        authenticatedUserId: bgUserId,
        authToken: bgToken,
      );
      await queue.cleanupRejected();
      if (syncResult.pending > 0) {
        await updateNotification(
          'Saved offline: ${syncResult.pending} waiting to sync',
        );
      } else if (syncResult.rejectionReason != null) {
        await updateNotification(
          'Point not counted: ${syncResult.rejectionReason}',
        );
      } else {
        await updateNotification('All locations synced');
      }
      return;
    }

    if (position.accuracy > 100) {
      await updateNotification("Waiting for accurate GPS");
      return;
    }

    double sendLat = rawLat;
    double sendLng = rawLng;

    // --- 📌 GPS JITTER / NOISE FILTER 📌 ---
    final lastLatitudeKey = "lastTrackingLat_$bgUserId";
    final lastLongitudeKey = "lastTrackingLng_$bgUserId";
    double? lastSavedLat = SharedPrefsHelper.getDouble(lastLatitudeKey);
    double? lastSavedLng = SharedPrefsHelper.getDouble(lastLongitudeKey);

    if (lastSavedLat != null && lastSavedLng != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        lastSavedLat,
        lastSavedLng,
        rawLat,
        rawLng,
      );

      // Two-minute CRM tracking can safely use a wider dead zone. Genuine
      // movement accumulates from the last confirmed coordinate.
      final stationaryRadiusMeters =
          position.accuracy > 75 ? position.accuracy : 75.0;
      final poorAccuracy = position.accuracy > 100;

      if (poorAccuracy || distanceInMeters < stationaryRadiusMeters) {
        sendLat = lastSavedLat;
        sendLng = lastSavedLng;
        print("Stationary/noisy GPS reading pinned to confirmed location");
      } else {
        // Meaningful movement: send fresh coordinates.
        sendLat = rawLat;
        sendLng = rawLng;
      }
    } else {
      // Initial base coordinate save
      sendLat = rawLat;
      sendLng = rawLng;
    }

    String addressValue = "Location: $sendLat, $sendLng";
    try {
      final placeMarks = await placemarkFromCoordinates(sendLat, sendLng);
      if (placeMarks.isNotEmpty) {
        final placeMark = placeMarks.first;
        addressValue =
            "${placeMark.thoroughfare} ${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}";
      }
    } catch (error) {
      print("Reverse geocoding failed; uploading coordinates: $error");
    }

    var logResponse = await apiServices.autoTrackingAPI(
      userId: bgUserId,
      address: addressValue,
      latitude: sendLat,
      longitude: sendLng,
      accuracy: position.accuracy,
      speed: position.speed,
      capturedAt: position.timestamp,
    );

    if (logResponse.statusCode == 201) {
      await SharedPrefsHelper.setDouble(lastLatitudeKey, sendLat);
      await SharedPrefsHelper.setDouble(lastLongitudeKey, sendLng);
      final response = jsonDecode(logResponse.body);
      print('Location Updated📍 ${DateTime.now()}   response:--$response');
      await updateNotification(
        "Location Updated: ${DateTime.now().toString().substring(11, 16)}",
      );
    } else {
      String failureDetail = "HTTP ${logResponse.statusCode}";
      try {
        final errorResponse = jsonDecode(logResponse.body);
        failureDetail = errorResponse['reason'] ??
            errorResponse['message'] ??
            failureDetail;
      } catch (_) {
        // Keep the HTTP status when the server response is not JSON.
      }
      await updateNotification("Location not saved: $failureDetail");
    }
  } catch (e) {
    print('Main Timer Loop Error: $e');
  } finally {
    _trackingRequestInProgress = false;
  }
}

// --- INITIALIZE SERVICE ---
Future<void> initializeService({required Future<void> isService}) async {
  final service = FlutterBackgroundService();
  service.on('force_logout_event').listen((event) {
    appLogout();
  });

  const channel = AndroidNotificationChannel(
    Constants.notificationChannelId,
    'Nagarjuna Steel',
    importance: Importance.defaultImportance,
    description: 'Background location tracking service',
  );

  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      notificationChannelId: Constants.notificationChannelId,
      initialNotificationTitle: 'Nagarjuna Steel',
      initialNotificationContent: 'Initializing...',
      foregroundServiceNotificationId: Constants.notificationId,
    ),
    iosConfiguration: IosConfiguration(autoStart: false, onForeground: onStart),
  );
}

Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'Reminders',
    'reminder_channel',
    priority: Priority.high,
    importance: Importance.high,
    channelDescription: 'Channel for reminders',
    visibility: NotificationVisibility.public,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
  );
}

Future<void> followUpsForNotificationFetching() async {
  try {
    var response = await apiServices.followUpsByUserIdForNotification();
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      followUpsDateList = responseData;
    }
  } catch (error) {
    print("Error fetching follow-ups: $error");
  }
}

void appLogout() async {
  try {
    followUpsDateList = [];
    final service = FlutterBackgroundService();
    if (await service.isRunning()) {
      service.invoke("stopService");
    }
    await SharedPrefsHelper.remove("token");
    await SharedPrefsHelper.remove("username");
    await SharedPrefsHelper.remove("userId");
    await SharedPrefsHelper.remove("email");
    await SharedPrefsHelper.remove("mobile");
    await SharedPrefsHelper.remove("empId");
    await SharedPrefsHelper.setBool('isLogin', false);
    await SharedPrefsHelper.setBool('checkInStatus', true);
    await SharedPrefsHelper.setBool('isService', false);
    await SharedPrefsHelper.clear();
    Get.offNamed(RoutesName.LOGIN);
  } catch (e) {
    debugPrint("prefsClear Error: $e");
  }
}
