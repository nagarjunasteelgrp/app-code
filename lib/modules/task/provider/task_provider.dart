import 'dart:convert';

import 'package:digital_lync/constants/global.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {

  bool isLoading = false;
  List taskAPIResponse = [];

  TaskProvider (){
    taskAPI();
  }

  Future<void> taskAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.taskAPI();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        taskAPIResponse = responseData['communications'];
        print("taskAPI responseData : ${taskAPIResponse}");
        notifyListeners();
      } else {}
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}