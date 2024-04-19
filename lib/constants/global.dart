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
bool isService = false;

Future<Map<String, String>> getHeaders() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
 token = sharedPreferences.getString("token") ?? '';
    print("TOKEN...1 $token");
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
        print("AUTO TRACKING MAP ERROR : ${response['message']}");
      }
      return addressPlacement;
  } catch (e) {
    print("Error-----: $e");
  }
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DartPluginRegistrant.ensureInitialized();
  Timer.periodic(const Duration(hours: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        print("service is running.......................");
        print("............");
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

Future<void> initializeService(isService) async {
  print("here...................................................................... $isService");
  await DisableBatteryOptimization.isAutoStartEnabled;
  final service = FlutterBackgroundService();
  if(isService == true){
  service.isRunning();
  }
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
      autoStart: isService,
      onForeground: onStart),
    androidConfiguration: AndroidConfiguration(
      autoStart: isService,
      isForegroundMode: isService,
      onStart: onStart,
      notificationChannelId: notificationChannelId,
      initialNotificationTitle: 'Nagarjuna Steel',
      initialNotificationContent: 'App is up and running',
      foregroundServiceNotificationId: notificationId,
    ),
  );
}







