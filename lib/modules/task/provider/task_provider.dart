import 'dart:convert';

import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskProvider extends ChangeNotifier {

  TextEditingController sendMessageController = TextEditingController();
  bool isLoading = false;
  List notificationAPIResponse = [];
  List taskAPIResponse = [];
  String? dateTime;
  String? selectedValue;
  dynamic statusId;
  dynamic status;
  int? currentIndex;
  List filteredTaskAPIResponse = [];
  List messageFetchingAPIResponse = [];
  List followUpsAPIResponse = [];
  int? followUpId;
  String selectedDateFilter = 'today';
  String selectedStatusFilter = 'all';

  TaskProvider (){
    messageFetchingAPIResponse = [];
    taskAPI();
    taskByUserIdAPI();
    messageFetching();
    selectedValue = dropDown.first;
    status = selectedValue!.toLowerCase();
    followUpsFetching();
  }

  List<String> dateFilters = ['today', 'week', 'month', 'year'];
  List<String> statusFilters = ['all', 'pending', 'done'];

  void updateDateFilter(String value) {
    selectedDateFilter = value;
    followUpsFetching();
    notifyListeners();
  }

  void updateStatusFilter(String value) {
    selectedStatusFilter = value;
    followUpsFetching();
    notifyListeners();
  }

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
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

  Future<void> followUpsFetching() async {
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.followUpsByUserId(selectedStatusFilter,selectedDateFilter);
      print("GET FOLLOW UPS USERID STATUS CODE1 : ${response.statusCode}");
      print("GET FOLLOW UPS USERID STATUS CODE2 : ${response.request}");
      print("GET FOLLOW UPS USERID STATUS CODE3 : ${response.body}");
      if (response.statusCode == 200) {
        isLoading = false;
        var responseData = jsonDecode(response.body);
        followUpsAPIResponse = responseData;
        print("RESPONSE DATA:---- $followUpsAPIResponse");
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> followUpsPutUpdateAPI(context) async {
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.followUpsPutApi(followUpId: followUpId);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        showAppSnackBar(type: 'success', context: context, title: responseData['message']);
        followUpId = null;
        followUpsFetching();
        isLoading = false;
        Get.back();
        notifyListeners();
      } else {
        var responseData = jsonDecode(response.body);
        showAppSnackBar(context: context, title: responseData['message']);
        isLoading = false;
        Get.back();
        notifyListeners();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> taskAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.taskAPI();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        notificationAPIResponse = responseData['communications'];
        notifyListeners();
      } else {}
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage() async {
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.sendMessage(message: sendMessageController.text);
      if (response.statusCode == 200) {
        await messageFetching();
        var responseData = jsonDecode(response.body);
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
      final response = await apiServices.taskByUserIdAPI();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData != null) {
          taskAPIResponse = responseData['tasks'];
           filteredTaskAPIResponse = taskAPIResponse;
          isLoading = false;
          notifyListeners();
        } else {
          taskAPIResponse = [];
          filteredTaskAPIResponse = [];
          isLoading = false;
          notifyListeners();
        }
      } else {
        taskAPIResponse = [];
        filteredTaskAPIResponse = [];
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      taskAPIResponse = [];
      filteredTaskAPIResponse = [];
      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> messageFetching() async {
    messageFetchingAPIResponse = [];
    try {
      isLoading = true;
      notifyListeners();
      final response = await apiServices.messageFetchingAPI();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        messageFetchingAPIResponse = responseData['messages'];
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        messageFetchingAPIResponse = [];
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      print("Error updating status: $e");
    } finally {
      isLoading = false;
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

  String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }


}