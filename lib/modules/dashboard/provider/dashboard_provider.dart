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
    print("RANGE DATE:------------------------  $startDate && $endDate");
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

  dropDownSelectedValueNewEnrollment (newValue) {
    dealerSum = 0;
    customerSum = 0;
    fabricatorsSum = 0;
    engineersSum = 0;
    masonsSum = 0;
    overallEnrollmentSum = 0;
    selectedValueNewEnrollment = newValue;
    filterNewEnrollment = newValue.toLowerCase();
    print("Filter: $filterNewEnrollment");
    overallEnrollmentAPI(filterNewEnrollment);
    notifyListeners();
  } 
  
  dropDownSelectedValueOverallDistance (newValue) {
    overallDistance = 0;
    selectedValueOverallDistance = newValue;
    filterOverallDistance = newValue.toLowerCase();
    print("Filter: $filterOverallDistance");
    overallDistanceAPI(filterOverallDistance);
    notifyListeners();
  }
  
  

  void updateDateRange() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    print("UPDATE RANGE SELECTED VALUE:---- $selectedValueNewEnrollment");
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
          myProgressAPIResponse = responseData;
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
          print("value.statusCode newEnrollmentAPI:2 $newEnrollmentAPIResponse");
          for (var data in newEnrollmentAPIResponse!) {
            if (data['fabricatorCount'] != null && double.tryParse(data['fabricatorCount'].toString()) != null) {
              fabricatorsSum += double.parse(data['fabricatorCount'].toString());
            }
            if (data['dealerCount'] != null && double.tryParse(data['dealerCount'].toString()) != null) {
              dealerSum += double.parse(data['dealerCount'].toString());
            }
            if (data['customerCount'] != null && double.tryParse(data['customerCount'].toString()) != null) {
              customerSum += double.parse(data['customerCount'].toString());
            }
            if (data['engineersCount'] != null && double.tryParse(data['engineersCount'].toString()) != null) {
              engineersSum += double.parse(data['engineersCount'].toString());
            }
            if (data['masonsCount'] != null && double.tryParse(data['masonsCount'].toString()) != null) {
              masonsSum += double.parse(data['masonsCount'].toString());
            }
          }
          overallEnrollmentSum = fabricatorsSum + dealerSum + customerSum + engineersSum + masonsSum;
          print("Overall Enrollment Sum: $overallEnrollmentSum");
          print("Fabricators Sum: $fabricatorsSum");
          print("Dealers Sum: $dealerSum");
          print("Customers Sum: $customerSum");
          print("Engineers Sum: $engineersSum");
          print("Masons Sum: $masonsSum");
          notifyListeners();
        } else {
          isLoading = false;
          print("value.statusCode newEnrollmentAPI:3 $responseData");
          newEnrollmentAPIResponse = [];
        }
      } else {
        isLoading = false;
        newEnrollmentAPIResponse = [];
        print("value.statusCode newEnrollmentAPI: ${response.statusCode}");
      }
    } catch (e) {
      isLoading = false;
      print("Error fetching progress data newEnrollmentAPI: =1 $e");
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
        print("overallDistanceAPI.....: $responseData");
        if (responseData != null) {
          isLoading = false;
          overallDistance = responseData[0]['totalDistance'];
          print("overallDistanceAPI.....1: $overallDistance");
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