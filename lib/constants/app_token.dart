import 'package:digital_lync/common/shared_prefs.dart';

Future getToken() async {
  SharedPrefers sharedPrefers = SharedPrefers();
  String? token = await sharedPrefers.getTokenFromPrefs();
  if (token != null) {
    return token;
  } else {
    print("Token not found in shared preferences.");
  }
}