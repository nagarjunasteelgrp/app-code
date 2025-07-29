import 'dart:convert';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationProvider extends ChangeNotifier {

  bool isLoading = false;
  List notificationList = [];

  NotificationProvider() {
    notification();
  }

  Future<void> notification() async {
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.followUpsNotification();
      if (response.statusCode == 200) {
        isLoading = false;
        var decodedResponse = jsonDecode(response.body);

        for (var notification in decodedResponse) {
          String formattedDate = formatDate(notification['followUpDate']);
          notification['formattedFollowUpDate'] = formattedDate;
        }

        notificationList = decodedResponse;
        print("notificationList : ${notificationList}");
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

  Future<void> deleteAllNotification(context) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.deleteAllNotificationAPIURL();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        showAppSnackBar(
            type: 'success', context: context, title: responseData['message']);
        notification();
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

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
