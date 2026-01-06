import 'dart:convert';
import 'dart:io';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/helper/shared_prefs_helper.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HomeProvider extends ChangeNotifier {
  int selectedIndex = 4;
  String? profilePicture;

  HomeProvider() {
    userRemainingNotifications();
    personalDetails();
    getHeaders();
    initState();
    getProfilePicture();
  }

  void initState() async {
    String? token = SharedPrefsHelper.getString("token");
    bool isService = SharedPrefsHelper.getBool("isService") ?? false;

    if (token != null && token.isNotEmpty) {
      await WakelockPlus.enable();
      await FlutterBackground.hasPermissions;
      await initializeService(isService: Future.value());
      final service = FlutterBackgroundService();
      if (isService && !await service.isRunning()) {
        service.startService();
      }
      notifyListeners();
    }
  }

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

  getProfilePicture() async {
    profilePicture = SharedPrefsHelper.getString("profilePicture");
    notifyListeners();
  }

  void refreshProfilePicture() {
    getProfilePicture();
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
    String? token = SharedPrefsHelper.getString('token');
    int userId = SharedPrefsHelper.getInt('userId') ?? 0;
    final response = await apiServices.matchUserToken(userId);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String? currentToken = responseData['currentToken'];
      if (currentToken != token) {
        appLogout();
        showAppSnackBar(
          type: 'Logged out',
          title: 'Your account active on another device.',
        );
      }
    }
  }

  void updateProfilePicture(String newProfilePicture) async {
    profilePicture = newProfilePicture;
    try {
      final response = await apiServices.updateDisplayPicture(
        userId!,
        File(newProfilePicture),
      );
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await SharedPrefsHelper.setString(
            'profilePicture', responseData['profilePicture']);
        showAppSnackBar(type: 'success', title: responseData['message']);
      } else {
        showAppSnackBar(type: 'Error', title: responseData['message']);
      }
    } catch (e) {
      showAppSnackBar(type: 'Error', title: e.toString());
    }
    notifyListeners();
  }
}
