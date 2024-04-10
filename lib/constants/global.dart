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
late Position _currentPosition;
String? username;
int? userId;
String? userEmail;
dynamic userPhone;
String? empId;
String? address;

Future<Map<String, String>> getHeaders() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.getString('token');
  print("TOKEN OF CUST :$token");
    return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}

Future personalDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");
  print("TOKEN OF CUSTqq :$token");
  username = prefs.getString("username");
  userId = prefs.getInt("userId");
  print("USERID:------$userId");
  userEmail = prefs.getString("email");
  userPhone = prefs.getString("mobile");
  empId = prefs.getString("empId");
}


getMapData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  latitude = prefs.getDouble("latitude");
  longitude = prefs.getDouble("longitude");
  address = prefs.getString("address");
  print("getMapData Latitude: $latitude, getMapData Longitude: $longitude getMapData Address: $address");
}

Future<dynamic> getCurrentLocation() async {
  try {
    await getHeaders();
    if (userId != null) {
      ApiServices apiServices = ApiServices();
      print("GET CURRENT LOCATION.................2");
      var logResponse = await apiServices.autoTrackingAPI(
          latitude: latitude, longitude: longitude, address: address);
      if (logResponse.statusCode == 201) {
        var response = jsonDecode(logResponse.body);
        latitude = response['trackingInfo']['latitude'] ?? 0.0;
        longitude = response['trackingInfo']['longitude'] ?? 0.0;
        print("AUTO TRACKING MAP RESPONSE : $response");
      } else {
        var response = jsonDecode(logResponse.body);
        print("AUTO TRACKING MAP ERROR : ${response['message']}");
      }
      return address;
    }
    print("USERID:------$userId");
  } catch (e) {
    print("Error-----: $e");
  }
}

