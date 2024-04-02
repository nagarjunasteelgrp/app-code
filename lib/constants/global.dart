import 'package:shared_preferences/shared_preferences.dart';

String? token;

Future<Map<String, String>> getHeaders() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.getString('token');
  print("TOKEN OF CUST :$token");
    return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}