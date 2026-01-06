import 'dart:convert';
import 'package:digital_lync/helper/shared_prefs_helper.dart';
import 'package:digital_lync/services/api/api_service.dart';
import 'package:flutter/material.dart';

class ActivitiesProvider extends ChangeNotifier {
  var userId;
  List taskList = [];
  bool isLoading = false;
  ApiServices apiServices = ApiServices();

  ActivitiesProvider() {
    getUserId();
  }

  getUserId() async {
    userId = SharedPrefsHelper.getInt('user_id')!;
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
      print("Error fetching catch: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
