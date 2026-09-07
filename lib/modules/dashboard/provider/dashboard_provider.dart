import 'dart:convert';
import 'dart:math' as math; // Math import kiya distance ke liye
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DashboardProvider extends ChangeNotifier {
  bool isLoading = false;
  GoogleMapController? mapController;

  num dealerSum = 0;
  num masonsSum = 0;
  num customerSum = 0;
  num engineersSum = 0;
  int _selectedIndex = 0;
  num fabricatorsSum = 0;
  num overallDistance = 0;
  num overallEnrollmentSum = 0;

  dynamic endDate;
  dynamic startDate;
  dynamic _selectedData;
  dynamic estimationAndQty;
  dynamic _estimationAndQty;
  dynamic monthlyReportResponse;
  dynamic myProgressAPIResponse;
  dynamic monthlySalesQtyResponse;
  dynamic endTimeForActivityLocation;
  dynamic dateSelectedActivityLocation;
  dynamic startTimeForActivityLocation;
  dynamic totalLocationActivityLocation;
  dynamic startTimeSelectedActivityLocation;
  dynamic get selectedData => _selectedData;
  dynamic totalDistanceCoveredActivityLocation;

  String _selectedValue = 'Amount';
  String? selectedValueNewEnrollment;
  String filterNewEnrollment = 'week';
  String? selectedValueOverallDistance;
  String filterOverallDistance = 'week';
  int get selectedIndex => _selectedIndex;
  String get selectedValue => _selectedValue;

  List<LatLng> points = [];
  List<LatLng> movementPoints = [];
  List<String> addresses = [];
  List<LatLng> routePoints = [];
  List? newEnrollmentAPIResponse;
  final List<String> items = ['Amount', 'Quantity'];
  List dropDownNewEnrollment = ['TODAY', 'WEEK', 'MONTH', 'YEAR'];
  List dropDownOverallDistance = ['TODAY', 'WEEK', 'MONTH', 'YEAR'];
  List myProgressList = ['TODAY', 'THIS WEEK', 'THIS MONTH', 'THIS YEAR'];

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

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

  void setSelectedValue(String value) {
    _selectedValue = value;
    _updateSelectedData();
    notifyListeners();
  }

  void setEstimationAndQty(dynamic data) {
    _estimationAndQty = data;
    _updateSelectedData();
    notifyListeners();
  }

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
            DateTime(now.year - 1, now.month, previousYearLastDay.day),
          );
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
          myProgressAPIResponse = {};
        }
      } else {
        myProgressAPIResponse = {};
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
    await activityLocation(
        startTimeForActivityLocation, endTimeForActivityLocation);
    notifyListeners();
  }

  // --- CHANGED: Activity Location Logic (Sorting added) ---
  Future<void> activityLocation(
      startTimeForActivityLocation, endTimeForActivityLocation) async {
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();

      var response = await apiServices.activities(
          startTimeForActivityLocation, endTimeForActivityLocation);

      if (response.statusCode == 200) {
        isLoading = false;
        final decodedResponse = jsonDecode(response.body);
        List<dynamic> activities = decodedResponse['activity'] as List<dynamic>;

        points.clear();
        movementPoints.clear();
        addresses.clear();
        routePoints.clear();

        if (activities.isNotEmpty) {
          // STEP 1: Sort by 'createdAt' (Oldest -> Newest)
          // Isse ensure hoga ki line waise bane jaise employee travel kiya
          activities.sort((a, b) {
            DateTime timeA = DateTime.parse(a['createdAt']);
            DateTime timeB = DateTime.parse(b['createdAt']);
            return timeA.compareTo(timeB); // Ascending Order
          });

          for (int i = 0; i < activities.length; i++) {
            final item = activities[i];
            final point = LatLng(item['latitude'], item['longitude']);
            points.add(point);
            addresses.add(item['address']);
            final distance = (item['distance'] as num?)?.toDouble() ?? 0;
            if (i == 0 || distance > 0) {
              movementPoints.add(point);
            }
          }

          // Route draw karna
          await loadRouteWithWaypoints();

          // 1. Date from First activity
          final date = DateTime.parse(activities.first['createdAt']);
          dateSelectedActivityLocation =
              DateFormat('MMMM d, yyyy').format(date);

          // Start time is the first activity after chronological sorting.
          final time = DateTime.parse(activities.first['createdAt']);
          startTimeSelectedActivityLocation =
              DateFormat('h:mm a').format(time.toLocal());

          // 3. Total distance
          double totalDistance = 0.0;
          for (var activity in activities) {
            totalDistance += (activity['distance'] ?? 0).toDouble();
          }
          totalDistanceCoveredActivityLocation =
              "${totalDistance.toStringAsFixed(2)} km";

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
    }
  }

  // --- CHANGED: Optimized Tracking Route Function ---
  Future<List<LatLng>> fetchRouteCoordinatesWithWaypoints(
      {required List<LatLng> waypoints}) async {
    if (waypoints.length < 2) return [];

    // 1. FILTER: Noise Removal (40 Meters)
    // Ye unnecessary zig-zag ko hatayega
    List<LatLng> filteredWaypoints = [];
    filteredWaypoints.add(waypoints.first); // Start point

    for (int i = 1; i < waypoints.length; i++) {
      LatLng currentPoint = waypoints[i];
      LatLng prevPoint = filteredWaypoints.last;

      double distanceInMeters =
          calculateDistanceInMeters(prevPoint, currentPoint);

      if (distanceInMeters > 40) {
        filteredWaypoints.add(currentPoint);
      }
    }

    // Ensure last point is added (Latest Location)
    if (filteredWaypoints.last != waypoints.last) {
      filteredWaypoints.add(waypoints.last);
    }

    // 2. GOOGLE API LIMIT CHECK (Max 25 Waypoints)
    List<LatLng> finalWaypointsToSend = [];
    finalWaypointsToSend.add(filteredWaypoints.first);

    List<LatLng> intermediates = [];
    if (filteredWaypoints.length > 2) {
      intermediates =
          filteredWaypoints.sublist(1, filteredWaypoints.length - 1);
    }

    // Downsampling logic
    if (intermediates.length > 23) {
      int step = (intermediates.length / 23).ceil();
      for (int i = 0; i < intermediates.length; i += step) {
        finalWaypointsToSend.add(intermediates[i]);
      }
    } else {
      finalWaypointsToSend.addAll(intermediates);
    }

    // Ensure Destination is added
    if (finalWaypointsToSend.last != filteredWaypoints.last) {
      finalWaypointsToSend.add(filteredWaypoints.last);
    }

    final origin = finalWaypointsToSend.first;
    final destination = finalWaypointsToSend.last;

    // Intermediate points string with 'via:'
    String waypointString = "";

    if (finalWaypointsToSend.length > 2) {
      final pointsToMap =
          finalWaypointsToSend.sublist(1, finalWaypointsToSend.length - 1);

      // 'via:' prefix snaps points to the road without adding stop markers
      waypointString = pointsToMap
          .map((point) => 'via:${point.latitude},${point.longitude}')
          .join('|');
    }
    final mode = "two_wheeler";
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
      '?origin=${origin.latitude},${origin.longitude}'
      '&destination=${destination.latitude},${destination.longitude}'
      '${waypointString.isNotEmpty ? '&waypoints=$waypointString' : ''}'
      '&mode=$mode'
      '&key=${Constants.GoogleMapApiKey}',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (data['status'] != 'OK') {
        print('Directions API Error: ${data['status']}');
        return [];
      }

      final polylinePoints = <LatLng>[];
      if (data['routes'] != null && data['routes'].isNotEmpty) {
        for (var leg in data['routes'][0]['legs']) {
          for (var step in leg['steps']) {
            final points =
                PolylinePoints.decodePolyline(step['polyline']['points']);
            polylinePoints
                .addAll(points.map((e) => LatLng(e.latitude, e.longitude)));
          }
        }
      }
      return polylinePoints;
    } catch (e) {
      print("API Exception: $e");
      return [];
    }
  }

  double calculateDistanceInMeters(LatLng p1, LatLng p2) {
    var p = 0.017453292519943295;
    var c = math.cos;
    var a = 0.5 -
        c((p2.latitude - p1.latitude) * p) / 2 +
        c(p1.latitude * p) *
            c(p2.latitude * p) *
            (1 - c((p2.longitude - p1.longitude) * p)) /
            2;
    return 12742 * math.asin(math.sqrt(a)) * 1000;
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
      currentYear = now.year - 1;
      nextYear = now.year;
    }

    String fy =
        'FY${currentYear.toString().substring(2)}${nextYear.toString().substring(2)}';
    return fy;
  }

  Future<void> loadRouteWithWaypoints() async {
    try {
      if (movementPoints.length < 2) {
        routePoints = [];
        return;
      }

      notifyListeners();

      final decodedRoute = await fetchRouteCoordinatesWithWaypoints(
        waypoints: movementPoints,
      );

      routePoints = decodedRoute;
    } catch (e) {
      routePoints = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
