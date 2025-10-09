import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:background_location_2/background_location.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/main.dart';
import 'package:digital_lync/modules/auth/screen/login_screen.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:disable_battery_optimizations_latest/disable_battery_optimizations_latest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? userId;
String? empId;
String? token;
String? empmId;
String? slpCode;
double? latitude;
String? username;
String? userEmail;
dynamic userPhone;
double? longitude;
String? profilePicture;
List? followUpsDateList;
String? addressPlacement;
bool isReachedOut = false;
TaskProvider? taskProvider;
ApiServices apiServices = ApiServices();
final serviceInitialize = FlutterBackgroundService();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'notificationChannelId',
  'Nagarjuna Steel',
  importance: Importance.high,
  description: 'App is up and running',
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<Map<String, String>> getHeaders() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.getString("token") ?? '';
  userId = sharedPreferences.getInt("userId") ?? 0;

  if (token!.isNotEmpty && JwtDecoder.isExpired(token!)) {
    sharedPreferences.remove("token");
    sharedPreferences.remove("userId");
    token = '';

    Navigator.pushAndRemoveUntil(
      Get.context!,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}

personalDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userId = prefs.getInt("userId") ?? 0;
  empId = prefs.getString("empId") ?? "";
  token = prefs.getString("token") ?? "";
  empmId = prefs.getString("empmId") ?? "";
  slpCode = prefs.getString("slpCode") ?? "";
  userEmail = prefs.getString("email") ?? "";
  userPhone = prefs.getString("mobile") ?? "";
  username = prefs.getString("username") ?? "";
  profilePicture = prefs.getString("profilePicture") ?? "";
  await getMapData();
}

Future<dynamic> getCurrentLocation() async {
  try {
    var logResponse = await apiServices.autoTrackingAPI(
      latitude: latitude,
      longitude: longitude,
      address: addressPlacement,
    );
    if (logResponse.statusCode == 201) {
      var response = jsonDecode(logResponse.body);

      latitude = response['activity']['latitude'] ?? 0.0;
      longitude = response['activity']['longitude'] ?? 0.0;
    }
    return addressPlacement;
  } catch (e) {
    showAppSnackBar(
      title: 'Error',
      context: Get.context!,
      subtitle: e.toString(),
    );
  }
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  if (service is AndroidServiceInstance) {
    // Set as foreground service
    if (!await service.isForegroundService()) {
      await service.setAsForegroundService();
    }
    // Show persistent notification
    if (await service.isForegroundService()) {
      flutterLocalNotificationsPlugin.show(
        notificationId,
        'Nagarjuna Steel',
        'Location tracking active in background',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            ongoing: true,
            'my_foreground',
            'MY FOREGROUND SERVICE',
            icon: '@mipmap/ic_launcher',
            playSound: false,
            autoCancel: false,
            enableVibration: false,
            priority: Priority.low,
            importance: Importance.low,
            // Make notification sticky
            category: AndroidNotificationCategory.service,
            channelDescription: 'Background location tracking service',
          ),
        ),
      );
    }
    service.setAutoStartOnBootMode(true);
  }
  // Start background location service
  BackgroundLocation.startLocationService();

  // Initialize location provider
  CurrentLocationProvider locationProvider = CurrentLocationProvider();

  Timer.periodic(
    const Duration(minutes: 5),
    (timer) async {
      try {
        if (service is AndroidServiceInstance) {
          if (await service.isForegroundService()) {
            flutterLocalNotificationsPlugin.show(
              notificationId,
              'Nagarjuna Steel',
              'Getting location... ${DateTime.now().toString().substring(11, 16)}',
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'my_foreground',
                  'MY FOREGROUND SERVICE',
                  icon: '@mipmap/ic_launcher',
                  ongoing: true,
                  playSound: false,
                  autoCancel: false,
                  enableVibration: false,
                  priority: Priority.low,
                  importance: Importance.low,
                  category: AndroidNotificationCategory.service,
                  channelDescription: 'Background location tracking service',
                ),
              ),
            );
            await locationProvider.getUserLocation().then((value) async {
              await getCurrentLocation();
              flutterLocalNotificationsPlugin.show(
                notificationId,
                'Nagarjuna Steel',
                'Location updated at ${DateTime.now().toString().substring(11, 16)}',
                const NotificationDetails(
                  android: AndroidNotificationDetails(
                    'my_foreground',
                    'MY FOREGROUND SERVICE',
                    ongoing: true,
                    autoCancel: false,
                    priority: Priority.low,
                    importance: Importance.low,
                    icon: '@mipmap/ic_launcher',
                    category: AndroidNotificationCategory.service,
                    channelDescription: 'Background location tracking service',
                  ),
                ),
              );
            }).catchError((error) {
              print('Location error: $error');
            });
          } else {
            await service.setAsForegroundService();
          }
        }
      } catch (e) {
        print('Timer error: $e');
      }
    },
  );
}

getMapData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  latitude = prefs.getDouble("latitude");
  longitude = prefs.getDouble("longitude");
  addressPlacement = prefs.getString("address");
}

Future<void> initializeService(Future<void> isService) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isService = prefs.getBool("isService") ?? false;

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  // ✅ Android 14 & 15 (API 34+)
  if (Platform.isAndroid && androidInfo.version.sdkInt >= 34) {
    try {
      // 🔔 Notification Permission
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }

      // 📍 Location Permissions
      if (await Permission.locationWhenInUse.isDenied) {
        await Permission.locationWhenInUse.request();
      }
      if (await Permission.locationAlways.isDenied) {
        await Permission.locationAlways.request();
      }

      // 🔋 Ignore Battery Optimization
      if (await Permission.ignoreBatteryOptimizations.isDenied) {
        await Permission.ignoreBatteryOptimizations.request();
      }

      // 🚀 Autostart check
      await DisableBatteryOptimizationLatest.isAutoStartEnabled;
    } catch (e) {
      debugPrint("Permission request error: $e");
    }
  }

  await DisableBatteryOptimizationLatest.isAutoStartEnabled;

  // 🔄 Service check
  if (isService) {
    if (isService == true) {
      serviceInitialize.isRunning();
      // serviceInitialize.isRunning();
    }
  }

  // 🔔 Notification Channel create
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // ⚙️ Background Service Config
  await serviceInitialize.configure(
    iosConfiguration: IosConfiguration(
      autoStart: isService,
      onForeground: onStart,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: isService,
      isForegroundMode: isService,
      notificationChannelId: channel.id,
      initialNotificationTitle: channel.name,
      initialNotificationContent: channel.description!,
      foregroundServiceNotificationId: notificationId,
    ),
  );
}

Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'reminder_channel',
    'Reminders',
    channelDescription: 'Channel for reminders',
    importance: Importance.high,
    priority: Priority.high,
    icon: '@drawable/ic_notification_icon',
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
  );
}

void initializeNotifications() async {
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
