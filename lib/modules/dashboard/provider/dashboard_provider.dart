import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DashboardProvider extends ChangeNotifier {
  final List<String> items = ['Amount', 'Quantity'];
  String _selectedValue = 'Amount';

  dynamic _estimationAndQty;
  dynamic _selectedData;

  String get selectedValue => _selectedValue;
  dynamic get selectedData => _selectedData;

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
  dynamic estimationAndQty;
  dynamic monthlyReportResponse;
  dynamic monthlySalesQtyResponse;
  dynamic startTimeForActivityLocation;
  dynamic endTimeForActivityLocation;
  dynamic dateSelectedActivityLocation;
  dynamic startTimeSelectedActivityLocation;
  dynamic totalDistanceCoveredActivityLocation;
  dynamic totalLocationActivityLocation;
  List<LatLng> points = [];
  List<String> addresses = [];
  List<LatLng> routePoints = [];

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

    startTimeForActivityLocation = now.subtract(const Duration(days: 1));

    endTimeForActivityLocation = now;

    dateSelectedActivityLocation =
        DateFormat('MMMM d, yyyy').format(startTimeForActivityLocation);

    myProgressAPI();

    monthlyAmountAndQuantity();

    monthlyReport();

    activityLocation(startTimeForActivityLocation, endTimeForActivityLocation);

    selectedValueNewEnrollment = dropDownNewEnrollment.first;

    selectedValueOverallDistance = dropDownOverallDistance.first;
  }

  List dropDownNewEnrollment = ['TODAY', 'WEEK', 'MONTH', 'YEAR'];

  List dropDownOverallDistance = ['TODAY', 'WEEK', 'MONTH', 'YEAR'];
  // Update dropdown selection
  void setSelectedValue(String value) {
    _selectedValue = value;
    _updateSelectedData();
    notifyListeners();
  }

  // Set API response data
  void setEstimationAndQty(dynamic data) {
    _estimationAndQty = data;
    _updateSelectedData();
    notifyListeners();
  }

  // Compute selected data based on dropdown
  void _updateSelectedData() {
    if (_selectedValue == 'Amount') {
      _selectedData = (_estimationAndQty != null &&
              _estimationAndQty['estimation'] != null &&
              _estimationAndQty['estimation'].isNotEmpty)
          ? _estimationAndQty['estimation'][0]
          : null;
    } else if (_selectedValue == 'Quantity') {
      double totalAchieved = 0.0;
      double totalBalance = 0.0;

      if (_estimationAndQty != null && _estimationAndQty['quantity'] != null) {
        for (var item in _estimationAndQty['quantity']) {
          totalAchieved += (item['Achieved Qty (MT)'] ?? 0).toDouble();
          totalBalance += (item['Balance Qty (MT)'] ?? 0).toDouble();
        }
      }

      _selectedData = {
        'Achieved Qty (MT)': totalAchieved,
        'Balance Qty (MT)': totalBalance,
        'Target Qty (MT)': totalAchieved + totalBalance,
      };
    } else {
      _selectedData = null;
    }
  }

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
        endDate = formatter.format(now.subtract(const Duration(days: 7)));
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
          isLoading = false;
        } else {
          myProgressAPIResponse = [];
        }
      } else {
        myProgressAPIResponse = [];
      }
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

  Future<void> updateActivityLocationForSelectedDate(
      DateTime selectedDate) async {
    startTimeForActivityLocation = selectedDate;
    endTimeForActivityLocation = selectedDate.add(const Duration(days: 1));
    dateSelectedActivityLocation =
        DateFormat('MMMM d, yyyy').format(startTimeForActivityLocation);
    await activityLocation(startTimeForActivityLocation,
        endTimeForActivityLocation); // Your API function
    notifyListeners(); // Refresh UI
  }

  GoogleMapController? mapController;

  Future<void> activityLocation(
      startTimeForActivityLocation, endTimeForActivityLocation) async {
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();

      var response = await apiServices.activities(
          startTimeForActivityLocation, endTimeForActivityLocation);
      // var response = await apiServices.activities("2025-04-05", "2025-04-06");

      if (response.statusCode == 200) {
        isLoading = false;
        final decodedResponse = jsonDecode(response.body);
        final activities = decodedResponse['activity'] as List<dynamic>;
        points.clear();
        addresses.clear();
        routePoints.clear();
        if (activities.isNotEmpty) {
          for (int i = 0; i < activities.length; i++) {
            final item = activities[i];
            points.add(LatLng(item['latitude'], item['longitude']));
            addresses.add(item['address']);
          }
          await loadRouteWithWaypoints();

          // 1. Yesterday's date
          final date = DateTime.parse(activities.first['createdAt']);
          dateSelectedActivityLocation =
              DateFormat('MMMM d, yyyy').format(date);
          /* print(
              "Date Selected Activity Location: $dateSelectedActivityLocation"); */

          // 2. Last index time
          final lastItem = activities.last;
          final time = DateTime.parse(lastItem['createdAt']);
          startTimeSelectedActivityLocation =
              DateFormat('h:mm a').format(time.toLocal());
          /*   print(
              "Start Time Selected Activity Location: $startTimeSelectedActivityLocation"); */

          // 3. Total distance
          double totalDistance = 0.0;
          for (var activity in activities) {
            totalDistance += (activity['distance'] ?? 0).toDouble();
          }
          totalDistanceCoveredActivityLocation =
              "${totalDistance.toStringAsFixed(2)} km";
          /* print(
              "Total Distance Covered Activity Location: $totalDistanceCoveredActivityLocation"); */

          // 4. Total locations
          totalLocationActivityLocation = activities.length;
        } else {
          startTimeSelectedActivityLocation = null;
          totalDistanceCoveredActivityLocation = null;
          totalLocationActivityLocation = null;
        }
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      // print("Error in activityLocation: $e");
    }
  }

  Future<List<LatLng>> fetchRouteCoordinatesWithWaypoints({
    required List<LatLng> waypoints,
  }) async {
    if (waypoints.length < 2) return [];

    final origin = waypoints.first;
    final destination = waypoints.last;

    // Exclude origin and destination from waypoints
    final intermediateWaypoints = waypoints.sublist(1, waypoints.length - 1);

    final waypointString = intermediateWaypoints
        .map((point) => '${point.latitude},${point.longitude}')
        .join('|');

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
      '?origin=${origin.latitude},${origin.longitude}'
      '&destination=${destination.latitude},${destination.longitude}'
      '&waypoints=$waypointString'
      '&key=${Constants.GoogleMapApiKey}',
    );

    final response = await http.get(url);
    final data = json.decode(response.body);

    if (data['status'] != 'OK') {
      throw Exception('Directions API error: ${data['status']}');
    }

    final polylinePoints = <LatLng>[];
    for (var leg in data['routes'][0]['legs']) {
      for (var step in leg['steps']) {
        final points =
            PolylinePoints.decodePolyline(step['polyline']['points']);
        polylinePoints
            .addAll(points.map((e) => LatLng(e.latitude, e.longitude)));
      }
    }

    return polylinePoints;
  }

  Future<void> monthlyReport() async {
    String currentMonth = DateFormat('MM').format(DateTime.now());
    String currentFY = getFinancialYearString();

    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();

      var response = await apiServices.monthlyReport(
        "MUTYAMSTEEL_LIVE",
        empmId,
        currentMonth,
        currentFY,
      );

      if (response.statusCode == 200) {
        isLoading = false;
        monthlyReportResponse = jsonDecode(response.body);
        monthlySalesQty(currentMonth: currentMonth, currentFY: currentFY);
        // print("Monthly Report Response: $monthlyReportResponse");
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Error in monthlyResponse: $e");
    }
  }

  Future<void> monthlyAmountAndQuantity() async {
    String currentMonth = DateFormat('MM').format(DateTime.now());
    String currentFY = getFinancialYearString();

    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();

      var response =
          await apiServices.estimationAndQty(currentMonth, currentFY, slpCode);

      if (response.statusCode == 200) {
        isLoading = false;
        estimationAndQty = jsonDecode(response.body);

        setEstimationAndQty(estimationAndQty);

        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Error in estAndQty: $e");
    }
  }

  Future<void> monthlySalesQty({currentMonth, currentFY}) async {
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();

      var response = await apiServices.monthlySalesQty(currentMonth, currentFY);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        List filteredList = (decoded['responseObject'] as List)
            .where((item) => item['SlpCode'].toString() == slpCode.toString())
            .toList();

        monthlySalesQtyResponse = {
          ...decoded,
          'responseObject': filteredList,
        };

        isLoading = false;

        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Error in monthlySalesQtyResponse: $e");
    }
  }

  String getFinancialYearString() {
    final now = DateTime.now();
    int currentYear = now.year;
    int nextYear = now.year + 1;

    if (now.month < 4) {
      // Before April → belongs to previous financial year
      currentYear = now.year - 1;
      nextYear = now.year;
    }

    String fy =
        'FY${currentYear.toString().substring(2)}${nextYear.toString().substring(2)}';
    return fy; // e.g., "FY2526"
  }

  Future<void> loadRouteWithWaypoints() async {
    try {
      if (points.length < 2) return;

      // isLoading = true;
      notifyListeners();

      final decodedRoute = await fetchRouteCoordinatesWithWaypoints(
        waypoints: points,
      );

      routePoints = decodedRoute;
    } catch (e) {
      routePoints = [];
      print('Route error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
