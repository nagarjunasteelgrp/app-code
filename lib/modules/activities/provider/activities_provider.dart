import 'dart:convert';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivitiesProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  bool isLoading = false;
  var userId;
  List taskList = [];

  ActivitiesProvider() {
    getUserId();
  }

  getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getInt('user_id')!;
    getTaskAPI(userId);
  }

  Future getTaskAPI(userId) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.getTaskList(id: userId);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        taskList = responseData["tasks"];
        notifyListeners();
      }
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
