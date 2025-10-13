import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Step 1: Check if service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    // Step 2: Check current permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Ask again if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, direct user to settings
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // ✅ Step 3: Handle "While in use" vs "Always"
    if (permission == LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always) {
        return Future.error(
          'Background location permission not granted. Please enable "Allow all the time".',
        );
      }
    }

    // Step 4: Get current position
    return await Geolocator.getCurrentPosition(
      timeLimit: const Duration(seconds: 10),
    );
  }
}
