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
    print("CHECK IN LIST API:---4");
    checkInListAPI();
  }


   checkInListAPI() async {
    print("CHECK IN LIST API:---1");
    try {
      isLoading = true;
      print("CHECK IN LIST API:---2");
      notifyListeners();
      var response = await apiServices.checkInList();
      print("CHECK IN LIST API:---3");
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        checkInList = responseData["attendance"];
        print("CHECK IN INFO List DETAILS: $checkInList");
        notifyListeners();
      } else {
        print("CHECK IN DETAILS Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exceptionss.....: $e");
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
        print("CHECK IN DETAILS: $responseData");
        notifyListeners();
      } else {
        print("CHECK IN Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkOutAPI() async {
    print("checkInId :- $checkInId");
    print("userId :- $userId");
    print("userCheckInTimeStamp :- $userCheckInTimeStamp");
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.checkOutAPI(checkInId: checkInId,userId: userId,checkInTime: userCheckInTimeStamp);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        checkInListAPI();
        checkInStatus = true;
        Get.back();
        print("CHECK OUT DETAILS: $responseData");
        notifyListeners();
      } else {
        print("CHECK IN Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}