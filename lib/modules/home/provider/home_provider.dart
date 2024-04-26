import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HomeProvider extends ChangeNotifier{

  int selectedIndex = 3;

   void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  HomeProvider(){
    permissionAcessPhone();
    initState();
    personalDetails();
    getHeaders();
    notifyListeners();
  }

  permissionAcessPhone() async {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      if (await Permission.location.request().isGranted) {
        CurrentLocationProvider currentLocationProvider = CurrentLocationProvider();
       await currentLocationProvider.getUserLocation().then((value) async {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          latitude = await sharedPreferences.getDouble("latitude");
          longitude = await sharedPreferences.getDouble("longitude");
          addressPlacement = await sharedPreferences.getString("address") ?? '';
          getCurrentLocation();
          notifyListeners();
        });
      }
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
     await  prefs.remove("token");
    await  prefs.remove("username");
    await  prefs.remove("userId");
    await  prefs.remove("email");
    await  prefs.remove("mobile");
    await prefs.remove("empId");
    print("SharedPreferences Cleared........................${prefs.getString('token')}");
    print("SharedPreferences Cleared........................${prefs.getDouble('latitude')}");
    notifyListeners();
  }


}