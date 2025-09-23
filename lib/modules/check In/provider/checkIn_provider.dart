import 'dart:convert';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool checkInStatus = true;

getShardPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  checkInStatus = prefs.getBool('checkInStatus') ?? true;
}

class CheckInProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  bool isLoading = false;
  List checkInList = [];
  String? userCheckInTimeStamp;
  int? checkInId;

  CheckInProvider() {
    getShardPreferencesData();
    checkInListAPI();
  }

  Future checkInListAPI() async {
    try {
      isLoading = true;

      var response = await apiServices.checkInList();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        checkInList = responseData["attendance"];
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> checkInAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.checkInAPI(userId: userId);
      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        prefs.setBool('checkInStatus', false);
        checkInListAPI();
        getShardPreferencesData();
        Get.back();
        prefs.setInt('checkInId', responseData['attendance']['id']);
        prefs.setString(
            'userCheckInTimeStamp', responseData['attendance']['clockIn']);
        notifyListeners();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkOutAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkInId = prefs.getInt('checkInId') ?? 0;
    userCheckInTimeStamp = prefs.getString('userCheckInTimeStamp');

    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.checkOutAPI(
          checkInId: checkInId!,
          userId: userId,
          checkInTime: userCheckInTimeStamp);
      if (response.statusCode == 200) {
        prefs.setBool('checkInStatus', true);
        checkInListAPI();
        getShardPreferencesData();
        Get.back();
        notifyListeners();
      } else {}
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
