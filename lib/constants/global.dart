import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:background_location/background_location.dart';
import 'package:digital_lync/main.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;
double? latitude;
double? longitude;
String? username;
int? userId;
String? userEmail;
dynamic userPhone;
String? empId;
String? address;

Future<Map<String, String>> getHeaders() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.getString('token');
  print("TOKEN :$token");
    return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}

Future personalDetails() async {
  print("PERSONAL DETAILS PREF CALLED....");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");
  username = prefs.getString("username");
  userId = prefs.getInt("userId");
  userEmail = prefs.getString("email");
  userPhone = prefs.getString("mobile");
  empId = prefs.getString("empId");
  await getMapData();
  if(token != null){
    print("TOKEN:-----------------$token");
  await getCurrentLocation();
  }
}

Future personalDetailsPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");
  username = prefs.getString("username");
  userId = prefs.getInt("userId");
  userEmail = prefs.getString("email");
  userPhone = prefs.getString("mobile");
  empId = prefs.getString("empId");
}

getMapData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  latitude = prefs.getDouble("latitude");
  longitude = prefs.getDouble("longitude");
  address = prefs.getString("address");
}

Future<dynamic> getCurrentLocation() async {
  print("GET USER LOCATION CALLED. API CALLING........${latitude} : ${longitude} : ${address}");
  try {
    getHeaders();
      ApiServices apiServices = ApiServices();
      var logResponse = await apiServices.autoTrackingAPI(
          latitude: latitude, longitude: longitude, address: address);
      if (logResponse.statusCode == 201) {
        var response = jsonDecode(logResponse.body);
        latitude = response['activity']['latitude'] ?? 0.0;
        longitude = response['activity']['longitude'] ?? 0.0;
      } else {
        var response = jsonDecode(logResponse.body);
        print("AUTO TRACKING MAP ERROR : ${response['message']}");
      }
      return address;
  } catch (e) {
    print("Error-----: $e");
  }
}


Future<void> initializeService() async {
  await DisableBatteryOptimization.isAutoStartEnabled;
  final service = FlutterBackgroundService();
  service.isRunning();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'MY FOREGROUND SERVICE',
    description:
    'App is up and running',
    importance: Importance.low,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await service.configure(iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      isForegroundMode: true,
      onStart: onStart,
      notificationChannelId: notificationChannelId,
      initialNotificationTitle: 'Nagarjuna Steel',
      initialNotificationContent: 'App is up and running',
      foregroundServiceNotificationId: notificationId,
    ),
  );
}


@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  DartPluginRegistrant.ensureInitialized();
  Timer.periodic(const Duration(hours: 2), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        print("service is running.......................");
        CurrentLocationProvider locationProvider = CurrentLocationProvider();
        await locationProvider.getUserLocation();
        getHeaders();
        personalDetails();
      }
    }
  });
}




