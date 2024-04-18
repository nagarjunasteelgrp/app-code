import 'package:background_location/background_location.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:digital_lync/services/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentLocationProvider extends ChangeNotifier {
  Position? userLocation;
  final LocationService locationService = LocationService();
  ApiServices apiServices = ApiServices();

  CurrentLocationProvider() {
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    print("GET USER LOCATION CALLED....1");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      print("GET USER LOCATION CALLED....2");
      // userLocation = await locationService.determinePosition();
      print("GET USER LOCATION CALLED....3");
      BackgroundLocation.getLocationUpdates((location) async {
        print("GET UPDATE LOCATION.........${location.latitude} ${location.longitude}");
      List<Placemark> placeMarks = await placemarkFromCoordinates(location.latitude!.toDouble(), location.longitude!.toDouble());
      print("GET USER LOCATION CALLED....4");
      Placemark placeMark = placeMarks[0];
     dynamic address = "${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}";
        print("userLocation :1 ${location.latitude!.toDouble()}");
        print("userLocation :2 ${location.longitude!.toDouble()}");
        print("userLocation :3 ${address}");
      sharedPreferences.setDouble("latitude", location.latitude!.toDouble());
      sharedPreferences.setDouble("longitude", location.longitude!.toDouble());
      sharedPreferences.setString("address", address);

      latitude = sharedPreferences.getDouble("latitude");
      longitude = sharedPreferences.getDouble("longitude");
      addressPlacement = sharedPreferences.getString("address") ?? '';
      print("ADRESSS $addressPlacement");

      notifyListeners();
      });
    } catch (e) {
      print("getUserLocation ERROR : $e");
      if (kDebugMode) {
        print(e);
      }
    }
  }


}
