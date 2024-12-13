import 'dart:convert';
import 'dart:io';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/check%20In/provider/checkIn_provider.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HomeProvider extends ChangeNotifier {
  int selectedIndex = 4;

  String? profilePicture;

  void setSelectedIndex(int index, {bool tabIndex = false}) {
    selectedIndex = index;
    if (selectedIndex == 2) {
      taskProvider = TaskProvider();
    }
    notifyListeners();
  }

  HomeProvider() {
    getShardPrefrencesData();
    permissionAcessPhone();
    personalDetails();
    getHeaders();
    initState();
    getProfilePicture();
    notifyListeners();
  }

  void updateProfilePicture(String newProfilePicture) async {
    profilePicture = newProfilePicture;
    try {
      notifyListeners();
      final response = await apiServices.updateDisplayPicture(
          userId!, File(newProfilePicture));
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var responseData = jsonDecode(response.body);
        prefs.setString('profilePicture', responseData['profilePicture']);
        showAppSnackBar(
            type: 'success',
            context: Get.context!,
            title: responseData['message']);
      } else {
        var responseData = jsonDecode(response.body);
        showAppSnackBar(
            type: 'Error',
            context: Get.context!,
            title: responseData['message']);
      }
    } catch (e) {
      showAppSnackBar(
          type: 'Error', context: Get.context!, title: e.toString());
    } finally {
      notifyListeners();
    }
  }

  getProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profilePicture = prefs.getString("profilePicture");
    notifyListeners();
  }

  permissionAcessPhone() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    if (await Permission.location.request().isGranted) {
      CurrentLocationProvider currentLocationProvider =
          CurrentLocationProvider();
      await currentLocationProvider.getUserLocation().then((value) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        latitude = await sharedPreferences.getDouble("latitude");
        longitude = await sharedPreferences.getDouble("longitude");
        addressPlacement = await sharedPreferences.getString("address") ?? '';
        notifyListeners();
        getCurrentLocation();
        notifyListeners();
      });
    }
  }

  initState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (token != '') {
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
    followUpsDateList = [];
    prefs.setBool('isLogin', false);
    serviceInitialize.invoke("stopService");
    await initializeService(prefs.setBool('isService', false));
    // BackgroundLocation.stopLocationService();
    // await prefs.clear();
    notifyListeners();
  }
}
