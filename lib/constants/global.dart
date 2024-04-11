import 'dart:convert';

import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:digital_lync/services/api_service.dart';
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
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");
  username = prefs.getString("username");
  userId = prefs.getInt("userId");
  userEmail = prefs.getString("email");
  userPhone = prefs.getString("mobile");
  empId = prefs.getString("empId");
  await getMapData();
  await getCurrentLocation();
}

getMapData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  latitude = prefs.getDouble("latitude");
  longitude = prefs.getDouble("longitude");
  address = prefs.getString("address");
}

Future<dynamic> getCurrentLocation() async {
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

