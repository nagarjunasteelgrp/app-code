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
  bool isLocationValid = false;
  Completer<void>? locationCompleter;

  final LocationService _locationService = LocationService();

  CurrentLocationProvider() {
    bootstrap();
  }

  /// 🔹 Dialog open lifecycle
  Future<void> bootstrap() async {
    await loadFromPrefs();
  }

  void startLocationFetching() {
    if (!isFetchingLocation) {
      fetchLiveLocation();
    }
  }

  /// 🔹 Load cached data immediately
  Future<void> loadFromPrefs() async {
    address = SharedPrefsHelper.getString('address');
    latitude = SharedPrefsHelper.getDouble('latitude');
    longitude = SharedPrefsHelper.getDouble('longitude');
    notifyListeners();
    if (latitude != null && longitude != null && mapController != null) {
      _moveCamera(latitude!, longitude!);
    }
  }

  /// 🔹 Validate if location data is proper for API
  bool validateLocationData() {
    if (latitude == null || longitude == null) return false;
    if (latitude == 0.0 || longitude == 0.0) return false;
    if (address == null || address!.trim().isEmpty) return false;
    if (address!.length < 5) return false;
    return true;
  }

  Future<void> fetchLiveLocation() async {
    if (isFetchingLocation) return;

    // Check if GPS service is enabled before proceeding
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('🔴 GPS service is disabled, trying to enable...');
      bool opened = await Geolocator.openLocationSettings();
      if (!opened) {
        debugPrint('🔴 Failed to open GPS settings');
        return;
      }
      // Check again after opening settings
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('🔴 GPS service still disabled');
        return;
      }
      debugPrint('🟢 GPS service enabled successfully');
    }

    locationCompleter = Completer<void>();
    isFetchingLocation = true;
    isLocationValid = false;
    notifyListeners();
    debugPrint('🟡 START fetchLiveLocation');

    try {
      // STEP 1 — permission & service check
      debugPrint('🟡 STEP 1: checkLocationPermission');
      bool hasPermission = await _locationService.checkLocationPermission();
      if (!hasPermission) {
        debugPrint('🔴 Permission denied');
        return;
      }
      debugPrint('🟢 STEP 1 DONE');

      // STEP 2 — Get Last Known Position for INSTANT feedback
      debugPrint('🟡 STEP 2: getLastKnownPosition');
      Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
      if (lastKnownPosition != null) {
        latitude = lastKnownPosition.latitude;
        longitude = lastKnownPosition.longitude;
        debugPrint('🟢 Got Last Known Position: $latitude, $longitude');
        await updateLocationOnUI(latitude!, longitude!);
      }

      // STEP 3 — get FRESH GPS position with SHORT timeout (5 seconds)
      debugPrint('🟡 STEP 3: getCurrentPosition');
      Position freshPosition;
      try {
        freshPosition = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 5),
          ),
        );
      } on TimeoutException {
        debugPrint('⚠️ GPS timeout — using last known/cached');
        if (lastKnownPosition == null) {
          try {
            freshPosition = await Geolocator.getCurrentPosition(
              locationSettings: LocationSettings(
                timeLimit: Duration(seconds: 3),
                accuracy: LocationAccuracy.best,
              ),
            );
          } catch (e) {
            throw Exception('No location available');
          }
        } else {
          freshPosition = lastKnownPosition;
        }
      }

      debugPrint(
          '🟢 FRESH POSITION: ${freshPosition.latitude}, ${freshPosition.longitude}');

      latitude = freshPosition.latitude;
      longitude = freshPosition.longitude;
      await updateLocationOnUI(latitude!, longitude!);

      // Validate location data after update
      isLocationValid = validateLocationData();

      debugPrint('🟢 Location Valid: $isLocationValid');

      debugPrint('🟢 LOCATION FLOW SUCCESS');
    } catch (e, s) {
      debugPrint('🔴 LOCATION FLOW FAILED');
      debugPrint('Stack: $s');
      isLocationValid = false;
    } finally {
      debugPrint('🟢 FINALLY: stop loader');
      isFetchingLocation = false;
      locationCompleter?.complete();
      locationCompleter = null;
      notifyListeners();
    }
  }

  Future<void> updateLocationOnUI(double lat, double lng) async {
    // Reverse Geocoding
    try {
      final placemark = await placemarkFromCoordinates(lat, lng);
      if (placemark.isNotEmpty) {
        final p = placemark.first;
        address =
            "${p.thoroughfare ?? ''} ${p.street ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, ${p.country ?? ''}";
      }
    } catch (e) {
      debugPrint('⚠️ Geocoding failed: $e');
    }

    // Save to prefs
    await SharedPrefsHelper.setDouble('latitude', lat);
    await SharedPrefsHelper.setDouble('longitude', lng);
    await SharedPrefsHelper.setString('address', address ?? '');

    // Move camera
    if (mapController != null) {
      _moveCamera(lat, lng);
    }
    notifyListeners();
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
