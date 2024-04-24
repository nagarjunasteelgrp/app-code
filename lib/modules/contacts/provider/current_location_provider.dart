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
    print("GET USER LOCATION...................1");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      print("GET USER LOCATION...................2");
      // userLocation = await locationService.determinePosition();
      BackgroundLocation.getLocationUpdates((location) async {
        print("GET USER LOCATION...................3");
      List<Placemark> placeMarks = await placemarkFromCoordinates(location.latitude!.toDouble(), location.longitude!.toDouble());
      Placemark placeMark = placeMarks[0];
     dynamic address = "${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}";
        print("GET USER LOCATION..................${location.latitude!.toDouble()} ");
        print("GET USER LOCATION.......... :1 ${location.latitude!.toDouble()}");
        print("GET USER LOCATION.......... :2 ${location.longitude!.toDouble()}");
        print("GET USER LOCATION.......... :3 ${address}");
      sharedPreferences.setDouble("latitude", location.latitude!.toDouble());
      sharedPreferences.setDouble("longitude", location.longitude!.toDouble());
      sharedPreferences.setString("address", address);
      latitude = sharedPreferences.getDouble("latitude");
      longitude = sharedPreferences.getDouble("longitude");
      addressPlacement = sharedPreferences.getString("address") ?? '';
      notifyListeners();
      });
    } catch (e) {
      print("GET USER LOCATION.......... ERROR MESSAGE......${e.toString()}");
      if (kDebugMode) {
        print(e);
      }
    }
  }



}
