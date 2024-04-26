import 'dart:convert';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckInProvider extends ChangeNotifier{

  ApiServices apiServices = ApiServices();
  bool isLoading = false;
  List checkInList = [];
  var userCheckInTimeStamp;
  bool checkInStatus = true;
  var checkInId;

  set checkInStatusBtn(bool value) {
    checkInStatus = value;
    notifyListeners();
  }

  CheckInProvider(){
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
      } else {
      }
    }  finally {
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> checkInAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.checkInAPI(userId: userId);
      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        userCheckInTimeStamp = responseData["attendance"]['clockIn'];
        checkInId = responseData['attendance']['id'];
        checkInListAPI();
        Get.back();
        notifyListeners();
      } else {
      }
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkOutAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.checkOutAPI(checkInId: checkInId,userId: userId,checkInTime: userCheckInTimeStamp);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        checkInListAPI();
        checkInStatus = true;
        Get.back();
        notifyListeners();
      } else {
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}