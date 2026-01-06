import 'dart:convert';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/helper/shared_prefs_helper.dart';
import 'package:digital_lync/services/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckInProvider extends ChangeNotifier {
  int? checkInId;
  List checkInList = [];
  bool isLoading = false;
  String? userCheckInTimeStamp;

  final ApiServices apiServices = ApiServices();

  CheckInProvider() {
    loadStatusFromPrefs();
    checkInListAPI();
  }

  Future<void> loadStatusFromPrefs() async {
    checkInStatus.value = SharedPrefsHelper.getBool('checkInStatus') ?? true;
    notifyListeners();
  }

  Future<void> checkInListAPI() async {
    try {
      isLoading = true;

      var response = await apiServices.checkInList();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        checkInList = responseData["attendance"];
        syncStatusWithLatestRecord();
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
        // Update provider state
        checkInStatus.value = false;
        await SharedPrefsHelper.setBool('checkInStatus', false);
        // Update list
        await checkInListAPI();
        // Close dialog
        Get.back();
        // Save ID + timestamp
        await SharedPrefsHelper.setInt('checkInId', data['attendance']['id']);
        await SharedPrefsHelper.setString(
            'userCheckInTimeStamp', data['attendance']['clockIn']);
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
        // Update provider state
        checkInStatus.value = true;
        await SharedPrefsHelper.setBool('checkInStatus', true);
        await checkInListAPI(); // refresh list
        Get.back();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> syncStatusWithLatestRecord() async {
    if (checkInList.isEmpty) {
      checkInStatus.value = true;
    } else {
      final latest = checkInList.first;
      checkInStatus.value = latest['clockOut'] == null ? false : true;
    }

    await SharedPrefsHelper.setBool('checkInStatus', checkInStatus.value);

    notifyListeners();
  }
}
