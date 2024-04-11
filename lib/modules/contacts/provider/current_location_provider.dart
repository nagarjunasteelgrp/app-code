import 'dart:convert';

import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:digital_lync/services/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/global.dart';

class CurrentLocationProvider extends ChangeNotifier {
  Position? userLocation;
  final LocationService locationService = LocationService();
  ApiServices apiServices = ApiServices();

  CurrentLocationProvider() {
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userLocation = await locationService.determinePosition();
      List<Placemark> placeMarks = await placemarkFromCoordinates(userLocation!.latitude, userLocation!.longitude);
      Placemark placeMark = placeMarks[0];
       address = "${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}";
      if (kDebugMode) {
        print("userLocation :1 ${userLocation!.latitude}");
      }
      if (kDebugMode) {
        print("userLocation :2 ${userLocation!.longitude}");
      }
      sharedPreferences.setDouble("latitude", userLocation!.latitude);
      sharedPreferences.setDouble("longitude", userLocation!.longitude);
      sharedPreferences.setString("address", address!);

      latitude = sharedPreferences.getDouble("latitude");
      longitude = sharedPreferences.getDouble("longitude");
      address = sharedPreferences.getString("address") ?? '';

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }


}
