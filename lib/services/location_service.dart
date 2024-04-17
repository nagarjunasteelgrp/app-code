import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> determinePosition() async {
    print("=========== determinePosition 1 ==========");
    bool serviceEnabled;
    LocationPermission permission;
    print("=========== determinePosition 2 ==========");
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("=========== determinePosition 3 ==========");
    if (!serviceEnabled) {
      print("=========== determinePosition 4 ==========");
      await Geolocator.openLocationSettings();
      print("=========== determinePosition 5 ==========");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    print("=========== determinePosition 6 ==========");
    if (permission == LocationPermission.denied) {
      print("=========== determinePosition 7 ==========");
      permission = await Geolocator.requestPermission();
      print("=========== determinePosition 8 ==========");
      if (permission == LocationPermission.denied) {
        print("=========== determinePosition 9 ==========");
        permission = await Geolocator.requestPermission();
        print("=========== determinePosition 10 ==========");
        return Future.error('Location permissions are denied');
      }
      print("=========== determinePosition 11 ==========");
    }

    if (permission == LocationPermission.deniedForever) {
      print("=========== determinePosition 12 ==========");
      permission = await Geolocator.requestPermission();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    print("=========== determinePosition 13 ==========");

    return await Geolocator.getCurrentPosition(timeLimit: Duration(seconds: 10));
  }
}
