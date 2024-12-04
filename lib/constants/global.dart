import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:digital_lync/main.dart';
import 'package:digital_lync/modules/auth/screen/login_screen.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;
double? latitude;
double? longitude;
String? username;
int? userId;
String? userEmail;
dynamic userPhone;
String? empId;
String? addressPlacement;
ApiServices apiServices = ApiServices();
final serviceInitialize = FlutterBackgroundService();
TaskProvider? taskProvider;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'notificationChannelId',
  'Nagarjuna Steel',
  description: 'App is up and running',
  importance: Importance.low,
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
    Navigator.push(
        Get.context!, MaterialPageRoute(builder: (context) =>  LoginScreen()));
  }
  return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}

personalDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token") ?? "";
  username = prefs.getString("username") ?? "";
  userId = prefs.getInt("userId") ?? 0;
  userEmail = prefs.getString("email") ?? "";
  userPhone = prefs.getString("mobile") ?? "";
  empId = prefs.getString("empId") ?? "";
  await getMapData();
}

Future<dynamic> getCurrentLocation() async {
  print("GET CURRENT LOCATION CALLED..............1");
  print(
      "GET CURRENT LOCATION CALLED..............2  ${latitude} ${longitude} ${addressPlacement}");
  try {
    var logResponse = await apiServices.autoTrackingAPI(
        latitude: latitude, longitude: longitude, address: addressPlacement);
    if (logResponse.statusCode == 201) {
      var response = jsonDecode(logResponse.body);
      latitude = response['activity']['latitude'] ?? 0.0;
      longitude = response['activity']['longitude'] ?? 0.0;
    } else {
      var response = jsonDecode(logResponse.body);
    }
    return addressPlacement;
  } catch (e) {
    print("GET CURRENT LOCATION CALLED..............3 ${e.toString()}");
    print(e);
  }
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  print("SERVICE STARTED..........................1");
  service.on('stopService').listen((event) {
    print("SERVICE STARTED..........................2");
    service.stopSelf();
  });

  if (service is AndroidServiceInstance) {
    print("SERVICE STARTED..........................3");
    if (await service.isForegroundService()) {
      flutterLocalNotificationsPlugin.show(
        notificationId,
        'Nagarjuna Steel',
        'App is up and running',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'my_foreground',
            'MY FOREGROUND SERVICE',
            icon: '@mipmap/ic_launcher',
            ongoing: true,
          ),
        ),
      );
    }
  }
  CurrentLocationProvider locationProvider = CurrentLocationProvider();
  Timer.periodic(const Duration(minutes: 5), (timer) async {
    print("SERVICE STARTED..........................4");
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        await locationProvider.getUserLocation();
        // await getMapData();
        await getCurrentLocation();
      }
    }
  });
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
  await DisableBatteryOptimization.isAutoStartEnabled;

  if (isService == true) {
    // serviceInitialize.startService();
    serviceInitialize.isRunning();
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await serviceInitialize.configure(
    iosConfiguration: IosConfiguration(
      autoStart: isService,
      onForeground: onStart,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: isService,
      isForegroundMode: isService,
      onStart: onStart,
      initialNotificationTitle: channel.name,
      initialNotificationContent: channel.description!,
      notificationChannelId: channel.id,
      foregroundServiceNotificationId: notificationId,
    ),
  );
}
