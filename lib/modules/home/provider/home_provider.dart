import 'package:digital_lync/constants/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HomeProvider extends ChangeNotifier{

  int selectedIndex = 3;

   void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  HomeProvider(){
    initState();
    personalDetails();
    getHeaders();
    getAddress();
    notifyListeners();
  }


  getAddress()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    latitude = sharedPreferences.getDouble("latitude");
    longitude = sharedPreferences.getDouble("longitude");
    addressPlacement = sharedPreferences.getString("address") ?? '';
    Future.delayed(Duration(seconds: 2),() async {
      await getCurrentLocation();
    });
  }

  initState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     if(token != '') {
    await initializeService(sharedPreferences.setBool('isService', true));
    await WakelockPlus.enable();
    FlutterBackground.initialize(
      androidConfig: FlutterBackgroundAndroidConfig()
    );
    await FlutterBackground.hasPermissions;
    // await FlutterBackground.enableBackgroundExecution();
    notifyListeners();
     }
  }

  prefsClear(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    await initializeService(sharedPreferences.setBool('isService', false));
    print("SharedPreferences Cleared........................${sharedPreferences.getString('token')}");
    notifyListeners();
  }


}