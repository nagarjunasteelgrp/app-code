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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      // userLocation = await locationService.determinePosition();
      BackgroundLocation.getLocationUpdates((location) async {
      List<Placemark> placeMarks = await placemarkFromCoordinates(location.latitude!.toDouble(), location.longitude!.toDouble());
      Placemark placeMark = placeMarks[0];
     dynamic address = "${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}";
      sharedPreferences.setDouble("latitude", location.latitude!.toDouble());
      sharedPreferences.setDouble("longitude", location.longitude!.toDouble());
      sharedPreferences.setString("address", address);
      latitude = sharedPreferences.getDouble("latitude");
      longitude = sharedPreferences.getDouble("longitude");
      addressPlacement = sharedPreferences.getString("address") ?? '';
      notifyListeners();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
