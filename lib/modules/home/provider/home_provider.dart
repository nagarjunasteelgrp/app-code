import 'dart:convert';
import 'dart:io';
import 'package:background_location_2/background_location.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/check%20In/provider/checkIn_provider.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/cupertino.dart';
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
    matchUserToken();
    if (selectedIndex == 2) {
      taskProvider = TaskProvider();
    }
    notifyListeners();
  }

  void setReachedOut(bool value) {
    isReachedOut = value;
    notifyListeners();
  }

  HomeProvider() {
    // print("HomeProvider initialized........0");
    userRemainingNotifications();
    // print("HomeProvider initialized........1");
    getShardPreferencesData();
    // print("HomeProvider initialized........2");
    permissionAccessPhone();
    // print("HomeProvider initialized........3");
    personalDetails();
    // print("HomeProvider initialized........4");
    getHeaders();
    // print("HomeProvider initialized........5");
    initState();
    // print("HomeProvider initialized........6");
    getProfilePicture();
    // print("HomeProvider initialized........7");
  }

  Future<void> userRemainingNotifications() async {
    await followUpsForNotificationFetching();

    if (followUpsDateList != null && followUpsDateList!.isNotEmpty) {
      await showNotification(
        'Remainder',
        'The followups scheduled with ${followUpsDateList![0]['dealerName']} will be reminded today',
      );
    }
  }

  Future<void> matchUserToken() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    int userId = prefs.getInt('userId') ?? 0;

    final response = await apiServices.matchUserToken(userId);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String? currentToken = responseData['currentToken'];

      if (currentToken != token) {
        print('== Token not match — logging out user ==');
        prefsClear(Get.context!);
        showAppSnackBar(
          type: 'Logged out',
          context: Get.context!,
          title: 'Your account active on another device.',
        );
      } else {
        print('== Token match ==');
      }
    } else {
      // print('API Error: ${response.statusCode}');
      // print('Response body: ${response.body}');
    }
  }

  void updateProfilePicture(String newProfilePicture) async {
    profilePicture = newProfilePicture;
    try {
      notifyListeners();
      final response = await apiServices.updateDisplayPicture(
        userId!,
        File(newProfilePicture),
      );
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var responseData = jsonDecode(response.body);
        prefs.setString('profilePicture', responseData['profilePicture']);
        showAppSnackBar(
          type: 'success',
          context: Get.context!,
          title: responseData['message'],
        );
      } else {
        var responseData = jsonDecode(response.body);
        showAppSnackBar(
          type: 'Error',
          context: Get.context!,
          title: responseData['message'],
        );
      }
    } catch (e) {
      showAppSnackBar(
        type: 'Error',
        title: e.toString(),
        context: Get.context!,
      );
    } finally {
      notifyListeners();
    }
  }

  getProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profilePicture = prefs.getString("profilePicture");
    notifyListeners();
  }

  permissionAccessPhone() async {
    if (await Permission.location.request().isGranted) {
      CurrentLocationProvider currentLocationProvider =
          CurrentLocationProvider();
      await currentLocationProvider.getUserLocation().then(
        (value) async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          latitude = sharedPreferences.getDouble("latitude");
          longitude = sharedPreferences.getDouble("longitude");
          addressPlacement = sharedPreferences.getString("address") ?? '';
          getCurrentLocation();
          notifyListeners();
        },
      );
    }
  }

  void initState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (token != '') {
      await initializeService(sharedPreferences.setBool('isService', true));
      await WakelockPlus.enable();
      await FlutterBackground.hasPermissions;
      notifyListeners();
    }
  }

  void prefsClear(BuildContext context) async {
    Get.offNamed(RoutesName.LOGIN);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove sensitive keys
    await prefs.remove("token");
    await prefs.remove("username");
    await prefs.remove("userId");
    await prefs.remove("email");
    await prefs.remove("mobile");
    await prefs.remove("empId");

    followUpsDateList = [];
    await prefs.setBool('isLogin', false);

    // Stop background service
    serviceInitialize.invoke("stopService");
    await initializeService(prefs.setBool('isService', false));

    // Clear location callback and stop service
    BackgroundLocation.getLocationUpdates((_) {});
    await BackgroundLocation.stopLocationService();
    await Future.delayed(const Duration(milliseconds: 300));

    // Now clear everything
    await prefs.clear();

    notifyListeners();
  }
}
