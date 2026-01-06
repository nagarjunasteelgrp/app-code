import 'dart:async';
import 'package:digital_lync/helper/shared_prefs_helper.dart';
import 'package:digital_lync/services/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationProvider extends ChangeNotifier {
  String? address;
  double? latitude;
  double? longitude;
  GoogleMapController? mapController;
  bool isFetchingLocation = false;
  Completer<void>? locationCompleter;

  final LocationService _locationService = LocationService();

  CurrentLocationProvider() {
    bootstrap();
  }

  /// 🔹 Dialog open lifecycle
  Future<void> bootstrap() async {
    await loadFromPrefs();
    fetchLiveLocation();
  }

  /// 🔹 Load cached data immediately
  Future<void> loadFromPrefs() async {
    latitude = SharedPrefsHelper.getDouble('latitude');
    longitude = SharedPrefsHelper.getDouble('longitude');
    address = SharedPrefsHelper.getString('address');

    notifyListeners();

    if (latitude != null && longitude != null && mapController != null) {
      _moveCamera(latitude!, longitude!);
    }
  }

  /// 🔹 SINGLE-SOURCE live location flow
  Future<void> fetchLiveLocation() async {
    if (locationCompleter != null) {
      debugPrint('⛔ fetchLiveLocation already running');
      return;
    }

    locationCompleter = Completer<void>();
    isFetchingLocation = true;
    notifyListeners();
    debugPrint('🟡 START fetchLiveLocation');
    try { 
      // STEP 1 — permission & service check
      debugPrint('🟡 STEP 1: determinePosition');
      await _locationService.determinePosition();
      debugPrint('🟢 STEP 1 DONE');
      // STEP 2 — get GPS position (timeout safe)
      debugPrint('🟡 STEP 2: getCurrentPosition');
      Position position;
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.best,
            timeLimit: Duration(seconds: 10),
          ),
        );
      } on TimeoutException {
        debugPrint('⚠️ GPS timeout — using last known location');

        final last = await Geolocator.getLastKnownPosition();
        if (last == null) {
          throw Exception('No last known location available');
        }
        position = last;
      }

      debugPrint('🟢 POSITION: ${position.latitude}, ${position.longitude}');

      latitude = position.latitude;
      longitude = position.longitude;
      print(
          "LAT AND LAT : latitude:- $latitude || longitude:- $longitude || position.latitude:- ${position.latitude} || position.longitude:- ${position.longitude}");
      // STEP 3 — reverse geocoding
      debugPrint('🟡 STEP 3: reverse geocoding');

      final placemarks = await placemarkFromCoordinates(latitude!, longitude!);

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        address =
            "${p.thoroughfare ?? ''} ${p.street ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, ${p.country ?? ''}";
      }

      // STEP 4 — save to prefs
      debugPrint('🟡 STEP 4: ${address}');
      debugPrint('🟡 STEP 5: save SharedPreferences');

      await SharedPrefsHelper.setDouble('latitude', latitude!);
      await SharedPrefsHelper.setDouble('longitude', longitude!);
      await SharedPrefsHelper.setString('address', address ?? '');

      // STEP 5 — move camera
      if (mapController != null) {
        debugPrint('🟡 STEP 6: move camera');
        _moveCamera(latitude!, longitude!);
      }

      debugPrint('🟢 LOCATION FLOW SUCCESS');
    } catch (e, s) {
      debugPrint('🔴 LOCATION FLOW FAILED');
      debugPrint('Error: $e');
      debugPrint('Stack: $s');
    } finally {
      debugPrint('🟢 FINALLY: stop loader');
      isFetchingLocation = false;
      locationCompleter?.complete();
      locationCompleter = null;
      notifyListeners();
    }
  }

  void _moveCamera(double lat, double lng) {
    if (mapController == null) return;

    try {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15),
      );
    } catch (e) {
      debugPrint('⚠️ Map controller disposed, camera update skipped');
    }
  }
}
