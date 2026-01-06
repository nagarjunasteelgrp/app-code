import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/helper/shared_prefs_helper.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/api/api_service.dart';
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
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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

  Timer.periodic(
    const Duration(minutes: 2),
    (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService() == false) {
          timer.cancel();
          return;
        }
      }

      try {
        // Data Fetching
        int? bgUserId = SharedPrefsHelper.getInt("userId");
        String? bgToken = SharedPrefsHelper.getString("token");
        if (bgUserId == null || bgToken == null || bgToken.isEmpty) {
          return;
        }
        // GPS Check
        bool isLocationServiceEnabled =
            await Geolocator.isLocationServiceEnabled();
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
        try {
          position = await Geolocator.getCurrentPosition(
            locationSettings: AndroidSettings(
              forceLocationManager: true,
              timeLimit: const Duration(seconds: 45),
              accuracy: LocationAccuracy.bestForNavigation,
            ),
          );
        } catch (e) {
          position = await Geolocator.getLastKnownPosition();
        }

        if (position == null) {
          await updateNotification("Weak GPS Signal");
          return;
        }

        // --- 🚨 SECURITY CHECK: FAKE GPS 🚨 ---
        if (position.isMocked) {
          print("🚨 FAKE GPS DETECTED! Triggering Logout.");

          // 1. Notification show karna
          await showNotification(
            "Security Warning ⚠️",
            "Your mobile is sending fake location. Turn off fake location otherwise user will be blocked.",
          );
          // 2. Shared Prefs Clear karna (Backup agar app background me kill ho gayi ho)
          await SharedPrefsHelper.remove("token");
          await SharedPrefsHelper.setBool('isLogin', false);
          // 3. UI ko Signal bhejna ki "Bhai, User ko Logout kar do"
          service.invoke("force_logout_event");
          // 4. Service Stop karna
          service.stopSelf();
          timer.cancel();
          return;
        }
        // --- SECURITY END ---
        List<Placemark> placeMarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        Placemark placeMark = placeMarks[0];

        String addressValue =
            "${placeMark.thoroughfare} ${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}";

        var logResponse = await apiServices.autoTrackingAPI(
          userId: bgUserId,
          address: addressValue,
          latitude: position.latitude,
          longitude: position.longitude,
        );

        if (logResponse.statusCode == 200 || logResponse.statusCode == 201) {
          final response = jsonDecode(logResponse.body);
          print('Location Updated📍 ${DateTime.now()}   response:--$response');
          await updateNotification(
            "Location Updated: ${DateTime.now().toString().substring(11, 16)}",
          );
        }
      } catch (e) {
        print('Main Timer Loop Error: $e');
      }
    },
  );
}

// --- INITIALIZE SERVICE ---
Future<void> initializeService({required Future<void> isService}) async {
  final service = FlutterBackgroundService();
  // Ye check karega agar background service ne "force_logout_event" bheja hai
  service.on('force_logout_event').listen((event) {
    print("Received Logout Signal from Background Service");
    // UI Thread par Logout Call karein
    appLogout();
  });

  // Notification Channel Setup (CRITICAL to prevent "Bad notification" crash)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    Constants.notificationChannelId,
    'Nagarjuna Steel',
    playSound: true,
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
    visibility: NotificationVisibility.public,
    channelDescription: 'Channel for reminders',
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
      0, title, body, notificationDetails);
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
    // Remove sensitive keys
    await SharedPrefsHelper.remove("token");
    await SharedPrefsHelper.remove("username");
    await SharedPrefsHelper.remove("userId");
    await SharedPrefsHelper.remove("email");
    await SharedPrefsHelper.remove("mobile");
    await SharedPrefsHelper.remove("empId");
    await SharedPrefsHelper.setBool('isLogin', false);
    // Update local flags
    await SharedPrefsHelper.setBool('isService', false);
    // Final wipe
    await SharedPrefsHelper.clear();
    Get.offNamed(RoutesName.LOGIN);
  } catch (e) {
    debugPrint("prefsClear Error: $e");
  }
}
