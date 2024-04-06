import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;
double? latitude;
double? longitude;
late Position _currentPosition;
String? username;
int? userId;
String? userEmail;
dynamic userPhone;

Future<Map<String, String>> getHeaders() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.getString('token');
  print("TOKEN OF CUST :$token");
    return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}

personalDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  username = prefs.getString("user_username");
  userId = prefs.getInt("user_id");
  userEmail = prefs.getString("user_email");
  userPhone = prefs.getString("user_phoneNo");
}


getMapData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  latitude = prefs.getDouble("latitude");
  longitude = prefs.getDouble("longitude");
  print("getMapData Latitude: $latitude, getMapData Longitude: $longitude");
}

void getCurrentLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    _currentPosition = position;
    print('Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}');

    List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);

    Placemark placemark = placemarks[0];
    String address = "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.country}";

    print('Address: $address');

    trackingProvider.autoTrackingInfo(
        _currentPosition.latitude, _currentPosition.longitude, address);
  } catch (e) {
    print("Error: $e");
  }
}


