import 'package:background_location/background_location.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
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
    print("REQUESTING PERMISSION...................1");
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      if (await Permission.location.request().isGranted) {
        CurrentLocationProvider currentLocationProvider = CurrentLocationProvider();
       await currentLocationProvider.getUserLocation().then((value) async {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          latitude = await sharedPreferences.getDouble("latitude");
          print("CHECKING.......................1 $latitude");
          longitude = await sharedPreferences.getDouble("longitude");
          print("CHECKING.......................2 $longitude");
          addressPlacement = await sharedPreferences.getString("address") ?? '';
          print("CHECKING.......................3 $addressPlacement");
          getCurrentLocation();
          notifyListeners();
          print("REQUESTING PERMISSION...................2");
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    await initializeService(sharedPreferences.setBool('isService', false));
    print("SharedPreferences Cleared........................${sharedPreferences.getString('token')}");
    notifyListeners();
  }


}