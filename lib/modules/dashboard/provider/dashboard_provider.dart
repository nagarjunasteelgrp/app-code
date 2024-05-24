import 'dart:convert';
import 'package:digital_lync/constants/global.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DashboardProvider extends ChangeNotifier{

  int _selectedIndex = 0;
  bool isLoading = false;
  dynamic endDate;
  dynamic startDate;
  int get selectedIndex => _selectedIndex;
  List<dynamic> myProgressAPIResponse = [];

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List myProgressList = [
    'TODAY',
    'THIS WEEK',
    'THIS MONTH',
    'THIS YEAR',
  ];


  String? selectedValue;

  DashboardProvider() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    startDate = formatter.format(now);
    endDate = formatter.format(now.add(const Duration(days: 1)));
    myProgressAPI();
    selectedValue = dropDown.first;
  }

  List dropDown = [
    'TODAY',
    'WEEK',
    'MONTH',
    'YEAR',
  ];

  dropDownSelectedValue (newValue) {
    selectedValue = newValue;
    notifyListeners();
  }

  void updateDateRange() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    switch (selectedValue) {
      case 'TODAY':
        startDate = formatter.format(now);
        endDate = formatter.format(now.add(const Duration(days: 1)));
        break;
      case 'WEEK':
        startDate = formatter.format(now.subtract(Duration(days: now.weekday - 1)));
        endDate = formatter.format(now.add(Duration(days: DateTime.daysPerWeek - now.weekday + 1)));
        break;
      case 'MONTH':
        startDate = formatter.format(DateTime(now.year, now.month, 1));
        endDate = formatter.format(DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1)).add(const Duration(days: 1)));
        break;
      case 'YEAR':
        startDate = formatter.format(DateTime(now.year, 1, 1));
        endDate = formatter.format(DateTime(now.year + 1, 1, 1).subtract(Duration(days: 1)).add(const Duration(days: 1)));
        break;
    }
  }


  Future<void> myProgressAPI() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await apiServices.myProgressAPI(startDate: startDate, endDate: endDate);
      print("MY PROGRESS..... $response");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("value.statusCode MY PROGRESS:1 ${response.body}");
        if (responseData != null && responseData is Map) { // Check if responseData is a List
          myProgressAPIResponse = [responseData];
          print("value.statusCode MY PROGRESS:2 ${myProgressAPIResponse}");
        } else {
          print("value.statusCode MY PROGRESS:3 ${responseData}");
          myProgressAPIResponse = [];
        }
      } else {
        myProgressAPIResponse = [];
        print("value.statusCode MY PROGRESS: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching progress data: =1 $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}