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
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("Location services are disabled.");
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("Location permissions are denied.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print("Location permissions are permanently denied.");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("GET LOCATION UPDATES :- ${position.latitude} ${position.longitude} ${position.accuracy}");
      List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      notifyListeners();
      Placemark placeMark = placeMarks[0];
      dynamic address = "${placeMark.thoroughfare} ${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}";
      print("address : $address");
      sharedPreferences.setDouble("latitude", position.latitude);
      sharedPreferences.setDouble("longitude", position.longitude);
      sharedPreferences.setString("address", address);
      latitude = sharedPreferences.getDouble("latitude");
      longitude = sharedPreferences.getDouble("longitude");
      addressPlacement = sharedPreferences.getString("address") ?? '';
      await getMapData();
      print("addressPlacement : $addressPlacement");
      notifyListeners();
    } catch (e) {
      print("ERROR ...: ${e.toString()}");
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
