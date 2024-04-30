import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:digital_lync/main.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<Map<String, String>> getHeaders() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
 token = sharedPreferences.getString("token") ?? '';
  userId = sharedPreferences.getInt("userId") ?? 0;
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
    print(e);
  }
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  Timer.periodic(const Duration(minutes: 5), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        CurrentLocationProvider locationProvider = CurrentLocationProvider();
        await locationProvider.getUserLocation();
        await getMapData();
        await getCurrentLocation();
      }
    }
  });
}

getMapData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  latitude = prefs.getDouble("latitude");
  longitude = prefs.getDouble("longitude");
  addressPlacement = prefs.getString("address");
}

Future<void> initializeService(Future<void> isService) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isService = prefs.getBool("isService") ?? false;
  await DisableBatteryOptimization.isAutoStartEnabled;
  final service = FlutterBackgroundService();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'MY FOREGROUND SERVICE',
    description:
    'App is up and running',
    importance: Importance.low,
  );
  if(isService == true){
    service.isRunning();
  }

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
 await service.configure(
   iosConfiguration: IosConfiguration(
      autoStart: isService,
      onForeground: onStart
 ),
    androidConfiguration: AndroidConfiguration(
      autoStart: isService,
      isForegroundMode: isService,
      onStart: onStart,
      initialNotificationTitle: 'Nagarjuna Steel',
      initialNotificationContent: 'App is up and running',
      notificationChannelId: notificationChannelId,
      foregroundServiceNotificationId: notificationId,
    ),
  );
}







