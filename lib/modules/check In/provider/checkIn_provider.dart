import 'dart:convert';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/helper/shared_prefs_helper.dart';
import 'package:digital_lync/services/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class CheckInProvider extends ChangeNotifier {
  int? checkInId;
  List checkInList = [];
  bool isLoading = false;
  String? userCheckInTimeStamp;

  final apiServices = ApiServices();

  CheckInProvider() {
    loadStatusFromPrefs();
    checkInListAPI();
  }

  Future<void> loadStatusFromPrefs() async {
    checkInStatus.value = SharedPrefsHelper.getBool('checkInStatus') ?? true;
    notifyListeners();
    await syncServiceStatus();
  }

  Future<void> checkInListAPI() async {
    try {
      isLoading = true;

      var response = await apiServices.checkInList();

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        checkInList = responseData["attendance"];
        syncStatusWithLatestRecord();
        await syncServiceStatus();
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> checkInAPI() async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await apiServices.checkInAPI(userId: userId);

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        checkInStatus.value = false;
        await SharedPrefsHelper.setBool('checkInStatus', false);
        // Update list
        await checkInListAPI();
        Get.back();
        await SharedPrefsHelper.setInt('checkInId', data['attendance']['id']);
        await SharedPrefsHelper.setString(
          'userCheckInTimeStamp',
          data['attendance']['clockIn'],
        );

        // --- START AUTO TRACKING ---
        await WakelockPlus.enable();
        await FlutterBackground.hasPermissions;
        // 1. Set Flag
        await SharedPrefsHelper.setBool('isService', true);
        // 2. Initialize and Start Service
        await initializeService(isService: Future.value());
        // 3. Force start service to show notification immediately
        final service = FlutterBackgroundService();
        if (!await service.isRunning()) {
          await service.startService();
        }
        notifyListeners();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkOutAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      if (checkInList.isEmpty) return;
      final latest = checkInList.first;
      checkInId = latest['id'];
      userCheckInTimeStamp = latest['clockIn'];
      var response = await apiServices.checkOutAPI(
        userId: userId,
        checkInId: checkInId!,
        checkInTime: userCheckInTimeStamp,
      );

      if (response.statusCode == 200) {
        checkInStatus.value = true;
        await SharedPrefsHelper.setBool('checkInStatus', true);
        await checkInListAPI();
        Get.back();

        // --- STOP AUTO TRACKING ---
        await SharedPrefsHelper.setBool('isService', false);
        final service = FlutterBackgroundService();
        if (await service.isRunning()) {
          service.invoke('stopService');
        }
        await WakelockPlus.disable();
        notifyListeners();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> syncStatusWithLatestRecord() async {
    if (checkInList.isEmpty) {
      checkInStatus.value = true;
      await SharedPrefsHelper.setBool('checkInStatus', true);
      return;
    }
    final latest = checkInList.first;
    if (latest['clockOut'] == null) {
      checkInStatus.value = false;
      await SharedPrefsHelper.setBool('checkInStatus', false);
    } else {
      checkInStatus.value = true;
      await SharedPrefsHelper.setBool('checkInStatus', true);
    }
  }

  Future<void> syncServiceStatus() async {
    bool isServiceEnabled = SharedPrefsHelper.getBool('isService') ?? false;
    bool isCheckedIn = !checkInStatus.value;

    if (isServiceEnabled && !isCheckedIn) {
      // Service is enabled but user is not checked in, stop service
      await SharedPrefsHelper.setBool('isService', false);
      final service = FlutterBackgroundService();
      if (await service.isRunning()) {
        service.invoke('stopService');
      }
      await WakelockPlus.disable();
    } else if (!isServiceEnabled && isCheckedIn) {
      // User is checked in but service is not enabled, start service
      await WakelockPlus.enable();
      await FlutterBackground.hasPermissions;
      await SharedPrefsHelper.setBool('isService', true);
      await initializeService(isService: Future.value());
      // Force start service to show notification immediately
      final service = FlutterBackgroundService();
      if (!await service.isRunning()) {
        await service.startService();
      }
    }
  }
}
