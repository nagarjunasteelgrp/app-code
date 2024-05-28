import 'dart:convert';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/dashboard/components/lineChart.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DashboardProvider extends ChangeNotifier{

  int _selectedIndex = 0;
  bool isLoading = false;
  dynamic endDate;
  dynamic startDate;
  int get selectedIndex => _selectedIndex;
  List<dynamic> myProgressAPIResponse = [];
  List? newEnrollmentAPIResponse;
  String filter = 'week';
  List<SalesData> fabricatorsChartData = [];
  List<SalesData> dealerChartData = [];
  List<SalesData> customerChartData = [];
  String? dayName;

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
    newEnrollmentAPI(filter);
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    startDate = formatter.format(now);
    endDate = formatter.format(now.subtract(const Duration(days: 1)));
    print("RANGE DATE:------------------------  $startDate && $endDate");
    myProgressAPI();
    selectedValue = dropDown.first;
  }

  List dropDown = [
    'WEEK',
    'MONTH',
    'YEAR',
  ];

  dropDownSelectedValue (newValue) {
    selectedValue = newValue;
    print("SELECTED VALUE:- $selectedValue");
    filter = newValue.toLowerCase();
    newEnrollmentAPI(filter);
    notifyListeners();
  }

  void updateDateRange() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    print("UPDATE RANGE SELECTED VALUE:---- $selectedValue");
    switch (_selectedIndex) {
      case 0:
        startDate = formatter.format(now);
        endDate = formatter.format(now.subtract(const Duration(days: 1)));
        print("UPDATE RANGE TODAY:---- $startDate && $endDate");
        break;
      case 1:
         startDate = formatter.format(now);
         endDate = formatter.format(now.subtract(Duration(days: 7)));
        print("UPDATE RANGE WEEK:---- $startDate && $endDate");
        break;
      case 2:
        startDate = formatter.format(now);
        final previousMonthDate = DateTime(now.year, now.month - 1, now.day);
        if (previousMonthDate.month == now.month) {
          final previousMonthLastDay = DateTime(now.year, now.month, 0);
          endDate = formatter.format(DateTime(now.year, now.month - 1, previousMonthLastDay.day));
        } else {
          endDate = formatter.format(previousMonthDate);
        }
        print("UPDATE RANGE MONTH:---- $startDate && $endDate");
        break;
      case 3:
        startDate = formatter.format(now);
        final previousYearDate = DateTime(now.year - 1, now.month, now.day);
        if (previousYearDate.month == now.month && previousYearDate.day != now.day) {
          final previousYearLastDay = DateTime(now.year - 1, now.month + 1, 0);
          endDate = formatter.format(DateTime(now.year - 1, now.month, previousYearLastDay.day));
        } else {
          endDate = formatter.format(previousYearDate);
        }
        print("UPDATE RANGE YEAR:---- $startDate && $endDate");
        break;
    }
  }

  Future<void> myProgressAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await apiServices.myProgressAPI(startDate: startDate, endDate: endDate);
      print("MY PROGRESS..... $startDate && $endDate");
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("value.statusCode MY PROGRESS:1 ${response.body}");
        if (responseData != null && responseData is Map) {
          myProgressAPIResponse = [responseData];
          isLoading = false;
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

  Future<void> newEnrollmentAPI(filter) async {
    try {
      notifyListeners();
      dayName = "";
      final response = await apiServices.newEnrollmentAPI(filter: filter);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData != null) {
          newEnrollmentAPIResponse = responseData;
          fabricatorsChartData.clear();
          dealerChartData.clear();
          customerChartData.clear();
          print("value.statusCode newEnrollmentAPI:2 $newEnrollmentAPIResponse");
          for (int i = 0; i < newEnrollmentAPIResponse!.length; i++) {
            var dataPoint = newEnrollmentAPIResponse![i];
            dayName = filter == "week" ? dataPoint['dayName'] : filter == "month" ? dataPoint['type'] : filter == "year" ? dataPoint['monthName'] != null ? dataPoint['monthName'] : dataPoint['type'] : '';
            print("CHART DATA:---------------$dayName");
            int fabricatorsCount = int.parse(dataPoint['fabricatorsCount'].toString());
            int customersCount = int.parse(dataPoint['customersCount'].toString());
            int dealersCount = int.parse(dataPoint['dealersCount'].toString());
            fabricatorsChartData.add(SalesData(dayName!, fabricatorsCount.toDouble()));
            dealerChartData.add(SalesData(dayName!, dealersCount.toDouble()));
            customerChartData.add(SalesData(dayName!, customersCount.toDouble()));
            print("CHART DATA1:---------------$fabricatorsChartData");
            print("CHART DATA2:---------------$dealerChartData");
            print("CHART DATA3:---------------$customerChartData");
          }
        } else {
          print("value.statusCode newEnrollmentAPI:3 $responseData");
          newEnrollmentAPIResponse = [];
        }
      } else {
        newEnrollmentAPIResponse = [];
        print("value.statusCode newEnrollmentAPI: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching progress data newEnrollmentAPI: =1 $e");
    } finally {
      notifyListeners();
    }
  }

}