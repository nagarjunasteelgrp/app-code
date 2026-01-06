import 'dart:convert';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskProvider extends ChangeNotifier {
  dynamic status;
  int? followUpId;
  dynamic statusId;
  String? dateTime;
  int? currentIndex;
  String? selectedValue;
  bool isLoading = false;
  List taskAPIResponse = [];
  List followUpsAPIResponse = [];
  List notificationAPIResponse = [];
  List filteredTaskAPIResponse = [];
  String selectedStatusFilter = 'all';
  String selectedDateFilter = 'today';
  List messageFetchingAPIResponse = [];
  List dropDown = ['Completed', 'InProgress', 'Assigned'];
  List<String> statusFilters = ['all', 'pending', 'done'];
  List<String> dateFilters = ['today', 'week', 'month', 'premonth'];
  TextEditingController sendMessageController = TextEditingController();

  TaskProvider() {
    messageFetchingAPIResponse = [];
    taskAPI();
    taskByUserIdAPI();
    messageFetching();
    selectedValue = dropDown.first;
    status = selectedValue!.toLowerCase();
    followUpsFetching();
  }

  changeIndex(int index) {
    currentIndex = index;
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

  String formatDateWithTime(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date).toLocal();
      return DateFormat('dd-MM-yyyy hh:mm a').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }

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

  dropDownSelectedValue(String newValue) {
    selectedValue = newValue;
    status = newValue.toLowerCase();
    notifyListeners();
  }

  Future<void> followUpsFetching() async {
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.followUpsByUserId(
          selectedStatusFilter, selectedDateFilter);
      if (response.statusCode == 200) {
        isLoading = false;
        var responseData = jsonDecode(response.body);
        followUpsAPIResponse = responseData;
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
        showAppSnackBar(type: 'success', title: responseData['message']);
        followUpId = null;
        followUpsFetching();
        isLoading = false;
        Get.back();
        notifyListeners();
      } else {
        var responseData = jsonDecode(response.body);
        showAppSnackBar(title: responseData['message']);
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
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(BuildContext context) async {
    String message = sendMessageController.text.trim();
    if (message.isEmpty) {
      showAppSnackBar(
        title: 'Please enter a message before sending.',
      );
      return;
    }
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.sendMessage(message: message);

      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);

        showAppSnackBar(
          type: 'success',
          title: responseData['message'] ?? 'Message sent successfully.',
        );
        sendMessageController.clear();
        Get.back();
        await messageFetching();
        notifyListeners();
      } else {
        var responseData = jsonDecode(response.body);
        showAppSnackBar(
          title: responseData['message'] ??
              'Failed to send message. Please try again.',
        );
      }
    } catch (e) {
      print('Error sending message: $e');
      showAppSnackBar(
        title: 'Something went wrong. Please try again.',
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> statusUpdateAPI(statusId) async {
    try {
      isLoading = true;
      notifyListeners();
      Get.back();
      final response = await apiServices.statusUpdateAPI(
        status: status,
        statusId: statusId,
      );
      if (response.statusCode == 200) {
        taskByUserIdAPI();
        showAppSnackBar(type: 'success', title: 'Status updated successfully');
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
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
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterTasks(String status) {
    if (status == 'all') {
      filteredTaskAPIResponse = taskAPIResponse;
    } else {
      filteredTaskAPIResponse =
          taskAPIResponse.where((task) => task['status'] == status).toList();
    }
    notifyListeners();
  }
}
