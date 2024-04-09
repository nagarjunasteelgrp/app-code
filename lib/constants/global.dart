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
String? empId;
String? address;

Future<Map<String, String>> getHeaders() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.getString('token');
  print("TOKEN OF CUST :$token");
    return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}

Future personalDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");
  print("TOKEN OF CUSTqq :$token");
  username = prefs.getString("username");
  userId = prefs.getInt("userId");
  print("USERID:------$userId");
  userEmail = prefs.getString("email");
  userPhone = prefs.getString("mobile");
  empId = prefs.getString("empId");
}


getMapData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  latitude = prefs.getDouble("latitude");
  longitude = prefs.getDouble("longitude");
  address = prefs.getString("address");
  print("getMapData Latitude: $latitude, getMapData Longitude: $longitude getMapData Address: $address");
}

Future getCurrentLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    _currentPosition = position;
    print('Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}');
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    Placemark placemark = placemarks[0];
    String addresss = "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.country}";
    print('Address::--- $address');
  address = addresss;
    trackingProvider.autoTrackingInfo(
        _currentPosition.latitude, _currentPosition.longitude, address);
    return address;
  } catch (e) {
    print("Error: $e");
  }
}


