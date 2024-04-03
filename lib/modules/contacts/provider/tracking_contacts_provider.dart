import 'dart:convert';
import 'dart:io';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class TrackingCurrentLocationProvider extends ChangeNotifier {

  ApiServices apiServices = ApiServices();
  TextEditingController addNotesController = TextEditingController();
  GoogleMapController? mapController;
  double? latitude ;
  double? longitude ;
  bool isLoading = false;
  List markers = [];
  String address = '';
  int? trackingInfoId;
  List trackingInfoNotesList = [];
  List trackingInfoImagesList = [];
  LatLng? initialPosition;



  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void animateCamera(double lat, double lng) {
    print("lat: $lat");
    print("lng: $lng");
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15),
      );
      notifyListeners();
    }
  }

  TrackingCurrentLocationProvider() {
      trackingInfoAPI();

    getMapData();
    notifyListeners();
  }

  void addMarker(LatLng latLng, String address) {
    print("address: $address");
    print("latLng: $latLng");
    markers.add(
      Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId(latLng.toString()),
        position: latLng,

        onTap: () {
          print(address);
        },
      ),
    );
    notifyListeners();
  }

  getMapData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble("latitude");
    longitude = prefs.getDouble("longitude");
    notifyListeners();
  }

  Future trackingInfoAPI() async {
    try {
        isLoading = true;
      notifyListeners();
      var response = await apiServices.trackingInfoList(id: // trackingInfoId!
        3
      );
      if (response.statusCode == 200) {
        markers.clear();
        var responseData = jsonDecode(response.body);

        trackingInfoNotesList = responseData['trackingInfo']['trackingNotes'];
        trackingInfoImagesList = responseData['trackingInfo']['trackingImages'];

        latitude = responseData['trackingInfo']['latitude'] ?? 0.0;
        longitude = responseData['trackingInfo']['longitude'] ?? 0.0;
        initialPosition = LatLng(latitude ?? 0.0, longitude ?? 0.0);

        address = responseData['trackingInfo']['address'];
        markers.add({
          'marker_id' : markers.length+1,
          'latitude': double.parse(responseData['trackingInfo']['latitude'].toString()),
          'longitude': double.parse(responseData['trackingInfo']['longitude'].toString()),
        });
        animateCamera(double.parse(responseData['trackingInfo']['latitude'].toString()), double.parse(responseData['trackingInfo']['longitude'].toString()));
        notifyListeners();
      } else {
        print("CONTACTS DETAILS Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }  finally {
      isLoading = false;
      notifyListeners();
    }
  }


}
