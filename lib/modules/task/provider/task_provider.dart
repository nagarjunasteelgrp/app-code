import 'dart:convert';

import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskProvider extends ChangeNotifier {

  TextEditingController sendMessageController = TextEditingController();
  bool isLoading = false;
  List notificationAPIResponse = [];
  List taskAPIResponse = [];
  String? dateTime;
  String? selectedValue;
  dynamic statusId;
  dynamic status;
  int _currentIndex = 0;
  List filteredTaskAPIResponse = [];
  List messageFetchingAPIResponse = [];
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  TaskProvider (){
    messageFetchingAPIResponse = [];
    taskAPI();
    taskByUserIdAPI();
    messageFetching();
    selectedValue = dropDown.first;
    print("SelectValue:--- $selectedValue");
    status = selectedValue!.toLowerCase();
  }

  List dropDown = [
    'Completed',
    'InProgress',
    'Assigned',
  ];

  dropDownSelectedValue (newValue) {
    selectedValue = newValue;
    status = newValue.toLowerCase();
    print("status : $status");
    notifyListeners();
  }

  Future<void> taskAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.taskAPI();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        notificationAPIResponse = responseData['communications'];
        print("taskAPI responseData : ${notificationAPIResponse}");
        notifyListeners();
      } else {}
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage() async {
    notifyListeners();
    print("SEND MESSAGE---------------------- ${sendMessageController.text} && ${userId}");
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.sendMessage(message: sendMessageController.text);
      if (response.statusCode == 200) {
        await messageFetching();
        var responseData = jsonDecode(response.body);
        print("RESPONSE DATA:---- $responseData");
        notifyListeners();
      } else {}
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> statusUpdateAPI(statusId) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await apiServices.statusUpdateAPI(status: status,statusId: statusId);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        taskByUserIdAPI();
          isLoading = false;
        notifyListeners();
          print("Status updated successfully");
      } else {
        isLoading = false;
        print("Failed to update status. Status code: ${response.statusCode}");
      }
    } catch (e) {
      isLoading = false;
      print("Error updating status: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> taskByUserIdAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await apiServices.taskByUserIdAPI();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("TASK BY USERID:--------------$responseData");
        if (responseData != null) {
          taskAPIResponse = responseData['tasks'];
           filteredTaskAPIResponse = taskAPIResponse;
           print("FILTERED TASK API RESPONSE:- $filteredTaskAPIResponse");
          isLoading = false;
          notifyListeners();
        } else {
          taskAPIResponse = [];
          filteredTaskAPIResponse = [];
          isLoading = false;
        }
      } else {
        taskAPIResponse = [];
        filteredTaskAPIResponse = [];
        isLoading = false;
      }
    } catch (e) {
      taskAPIResponse = [];
      filteredTaskAPIResponse = [];
      isLoading = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> messageFetching() async {
    print("HELLO PRINTED...........1");
    messageFetchingAPIResponse = [];
    try {
      isLoading = true;
      notifyListeners();
      final response = await apiServices.messageFetchingAPI();
      if (response.statusCode == 200) {
        print("HELLO PRINTED...........2");
        var responseData = jsonDecode(response.body);
        messageFetchingAPIResponse = responseData['messages'];
        notifyListeners();
        print("Message updated successfully $messageFetchingAPIResponse");
        isLoading = false;
        notifyListeners();
      } else {
        print("HELLO PRINTED...........3");
        isLoading = false;
        messageFetchingAPIResponse = [];
        notifyListeners();
        print("Failed to update status. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("HELLO PRINTED...........4");
      isLoading = false;
      print("Error updating status: $e");
    } finally {
      isLoading = false;
      print("HELLO PRINTED...........5");
      notifyListeners();
    }
  }


  void filterTasks(String status) {
    if (status == 'all') {
      filteredTaskAPIResponse = taskAPIResponse;
    } else {
      filteredTaskAPIResponse = taskAPIResponse.where((task) => task['status'] == status).toList();
    }
    print("FILTERED TASK API RESPONSE:- $filteredTaskAPIResponse");
    notifyListeners();
  }


}