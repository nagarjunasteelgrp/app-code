import 'package:background_location/background_location.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
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
     print("Home Provider............");
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
          print('yes.................');
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
    await FlutterBackground.hasPermissions;
    // await FlutterBackground.enableBackgroundExecution();
    notifyListeners();
     }
  }

  prefsClear(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("token");
      prefs.remove("username");
      prefs.remove("userId");
      prefs.remove("email");
      prefs.remove("mobile");
      prefs.remove("empId");
    prefs.setBool('isLogin', false);
    serviceInitialize.invoke("stopService");
    await initializeService(prefs.setBool('isService', false));
    await BackgroundLocation.stopLocationService();
    // await prefs.clear();
    print("SharedPreferences Cleared........................${prefs.getString('token')}");
    print("SharedPreferences Cleared........................${prefs.getDouble('latitude')}");
    notifyListeners();
  }


}