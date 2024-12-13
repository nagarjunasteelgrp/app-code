import 'dart:convert';
import 'package:digital_lync/constants/global.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DashboardProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  bool isLoading = false;
  dynamic endDate;
  dynamic startDate;

  int get selectedIndex => _selectedIndex;
  dynamic myProgressAPIResponse;
  List? newEnrollmentAPIResponse;
  String filterNewEnrollment = 'week';
  String filterOverallDistance = 'week';
  num fabricatorsSum = 0;
  num dealerSum = 0;
  num customerSum = 0;
  num engineersSum = 0;
  num masonsSum = 0;
  num overallEnrollmentSum = 0;
  num overallDistance = 0;

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

  String? selectedValueNewEnrollment;
  String? selectedValueOverallDistance;

  DashboardProvider() {
    overallEnrollmentAPI('today');
    overallDistanceAPI('today');
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    startDate = formatter.format(now);
    endDate = formatter.format(now.subtract(const Duration(days: 1)));
    myProgressAPI();
    selectedValueNewEnrollment = dropDownNewEnrollment.first;
    selectedValueOverallDistance = dropDownOverallDistance.first;
  }

  List dropDownNewEnrollment = [
    'TODAY',
    'WEEK',
    'MONTH',
    'YEAR',
  ];

  List dropDownOverallDistance = [
    'TODAY',
    'WEEK',
    'MONTH',
    'YEAR',
  ];

  dropDownSelectedValueNewEnrollment(newValue) {
    dealerSum = 0;
    customerSum = 0;
    fabricatorsSum = 0;
    engineersSum = 0;
    masonsSum = 0;
    overallEnrollmentSum = 0;
    selectedValueNewEnrollment = newValue;
    filterNewEnrollment = newValue.toLowerCase();
    overallEnrollmentAPI(filterNewEnrollment);
    notifyListeners();
  }

  dropDownSelectedValueOverallDistance(newValue) {
    overallDistance = 0;
    selectedValueOverallDistance = newValue;
    filterOverallDistance = newValue.toLowerCase();
    overallDistanceAPI(filterOverallDistance);
    notifyListeners();
  }

  void updateDateRange() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    switch (_selectedIndex) {
      case 0:
        startDate = formatter.format(now);
        endDate = formatter.format(now.subtract(const Duration(days: 1)));
        break;
      case 1:
        startDate = formatter.format(now);
        endDate = formatter.format(now.subtract(Duration(days: 7)));
        break;
      case 2:
        startDate = formatter.format(now);
        final previousMonthDate = DateTime(now.year, now.month - 1, now.day);
        if (previousMonthDate.month == now.month) {
          final previousMonthLastDay = DateTime(now.year, now.month, 0);
          endDate = formatter.format(
              DateTime(now.year, now.month - 1, previousMonthLastDay.day));
        } else {
          endDate = formatter.format(previousMonthDate);
        }
        break;
      case 3:
        startDate = formatter.format(now);
        final previousYearDate = DateTime(now.year - 1, now.month, now.day);
        if (previousYearDate.month == now.month &&
            previousYearDate.day != now.day) {
          final previousYearLastDay = DateTime(now.year - 1, now.month + 1, 0);
          endDate = formatter.format(
              DateTime(now.year - 1, now.month, previousYearLastDay.day));
        } else {
          endDate = formatter.format(previousYearDate);
        }
        break;
    }
  }

  Future<void> myProgressAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await apiServices.myProgressAPI(
          startDate: startDate, endDate: endDate);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData != null && responseData is Map) {
          myProgressAPIResponse = responseData;
          print("My progress:--- $myProgressAPIResponse");
          isLoading = false;
        } else {
          myProgressAPIResponse = [];
        }
      } else {
        myProgressAPIResponse = [];
      }
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> overallEnrollmentAPI(period) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await apiServices.overallEnrollmentAPI(filter: period);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData != null) {
          isLoading = false;
          newEnrollmentAPIResponse = responseData;
          for (var data in newEnrollmentAPIResponse!) {
            if (data['fabricatorCount'] != null &&
                double.tryParse(data['fabricatorCount'].toString()) != null) {
              fabricatorsSum +=
                  double.parse(data['fabricatorCount'].toString());
            }
            if (data['dealerCount'] != null &&
                double.tryParse(data['dealerCount'].toString()) != null) {
              dealerSum += double.parse(data['dealerCount'].toString());
            }
            if (data['customerCount'] != null &&
                double.tryParse(data['customerCount'].toString()) != null) {
              customerSum += double.parse(data['customerCount'].toString());
            }
            if (data['engineersCount'] != null &&
                double.tryParse(data['engineersCount'].toString()) != null) {
              engineersSum += double.parse(data['engineersCount'].toString());
            }
            if (data['masonsCount'] != null &&
                double.tryParse(data['masonsCount'].toString()) != null) {
              masonsSum += double.parse(data['masonsCount'].toString());
            }
          }
          overallEnrollmentSum = fabricatorsSum +
              dealerSum +
              customerSum +
              engineersSum +
              masonsSum;
          notifyListeners();
        } else {
          isLoading = false;
          newEnrollmentAPIResponse = [];
        }
      } else {
        isLoading = false;
        newEnrollmentAPIResponse = [];
      }
    } catch (e) {
      isLoading = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> overallDistanceAPI(period) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await apiServices.overallDistanceAPI(filter: period);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData != null) {
          isLoading = false;
          overallDistance = responseData[0]['totalDistance'];
          notifyListeners();
        } else {
          overallDistance = 0;
          isLoading = false;
        }
      } else {
        overallDistance = 0;
        isLoading = false;
      }
    } catch (e) {
      overallDistance = 0;
      isLoading = false;
    } finally {
      notifyListeners();
    }
  }
}
