import 'dart:convert';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool checkInStatus = true;

getShardPrefrencesData() async {
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
    getShardPrefrencesData();
    checkInListAPI();
  }

  checkInListAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.checkInList();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        checkInList = responseData["attendance"];
        notifyListeners();
      } else {}
    } finally {
      isLoading = false;
      notifyListeners();
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
        // userCheckInTimeStamp = responseData["attendance"]['clockIn'];
        print(
            "responseData['attendance']['id'] :${responseData['attendance']['id']}");
        print("responseData['attendance']['id'] :${userCheckInTimeStamp}");
        print(
            "responseData['attendance']['id'] :${userCheckInTimeStamp.runtimeType}");
        // checkInId = responseData['attendance']['id'];
        prefs.setBool('checkInStatus', false);
        checkInListAPI();
        getShardPrefrencesData();
        Get.back();
        prefs.setInt('checkInId', responseData['attendance']['id']);
        prefs.setString(
            'userCheckInTimeStamp', responseData['attendance']['clockIn']);
        notifyListeners();
      } else {}
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkOutAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkInId = prefs.getInt('checkInId') ?? 0;
    userCheckInTimeStamp = prefs.getString('userCheckInTimeStamp');
    print("checkInId :1 ${checkInId}");
    print("checkInId :2 ${userCheckInTimeStamp}");

    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.checkOutAPI(
          checkInId: checkInId!,
          userId: userId,
          checkInTime: userCheckInTimeStamp);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        prefs.setBool('checkInStatus', true);
        checkInListAPI();
        getShardPrefrencesData();
        Get.back();
        notifyListeners();
      } else {}
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
