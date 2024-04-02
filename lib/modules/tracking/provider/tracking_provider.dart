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

class TrackingProvider extends ChangeNotifier {

  ApiServices apiServices = ApiServices();
  TextEditingController addNotesController = TextEditingController();
  GoogleMapController? mapController;
  double? latitude ;
  double? longitude ;
  bool isLoading = false;
  File? image;
  List markers = [];
  String address = '';
  bool _geoLocationBtn = false;
  int trackingInfoId = 0;
  List trackingInfoNotesList = [];
  List trackingInfoImagesList = [];
  LatLng? initialPosition;
  int? userId;

  bool get geoLocationBtn => _geoLocationBtn;

  set geoLocationBtn(bool value) {
    _geoLocationBtn = value;
    notifyListeners();
  }

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

  TrackingProvider() {
    getUserId();
    trackingInfoAPI();
    getMapData();
    notifyListeners();
  }

  getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getInt('user_id')!;
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

  Future getImage(BuildContext context,ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      await trackingImages(context);
      notifyListeners();
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  Future<void> trackingAddNotes(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    FocusScope.of(context).unfocus();
    String addNotes = addNotesController.text.trim();
    if (addNotes.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your notes.');
      return;
    }
    notifyListeners();
    try {
      var logResponse = await apiServices.trackingNotes(description: addNotesController.text, trackingInfoId: trackingInfoId);
      if (logResponse.statusCode == 201) {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        showAppSnackBar(type: 'success', context: context, title: response['message']);
        print("TRACKING NOTES RESPONSE :----------------1");
        print("TRACKING NOTES RESPONSE :----------------2");
        addNotesController.clear();
        print("TRACKING NOTES RESPONSE :----------------3");
        trackingInfoAPI();
        Get.back();
      } else {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        print("TRACKING NOTES ERROR : ${response['message']}");
        showAppSnackBar(type: 'Error', context: context, title: response['message']);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
      print("TRACKING NOTES E : $e");
    }
  }


  Future<void> trackingMap(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    FocusScope.of(context).unfocus();
    notifyListeners();
    try {
      print("TRACKING MAP ADDRESS 1: $latitude");
      print("TRACKING MAP ADDRESS 2: $longitude");
      print("TRACKING MAP ADDRESS 3: $address");
      print("TRACKING MAP ADDRESS 4: $userId");
      var logResponse = await apiServices.trackingInfo(latitude: latitude,longitude: longitude,address: address,userId: userId);
      if (logResponse.statusCode == 201) {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        print("TRACKING MAP RESPONSE : $response");
        trackingInfoId = response['trackingInfo']['id'];
        showAppSnackBar(type: 'success', context: context, title: response['message']);
        addNotesController.clear();
        trackingInfoAPI();
        notifyListeners();
        Get.back();
      } else {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        print("TRACKING MAP ERROR : ${response['message']}");
        showAppSnackBar(type: 'Error', context: context, title: response['message']);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
      print("TRACKING MAP E : $e");
    }
  }


  Future<void> trackingImages(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    FocusScope.of(context).unfocus();
    notifyListeners();
    try {
      if (image != null) {
        var logResponse = await apiServices.trackingImages(
          trackingInfoId: trackingInfoId!,
          image: image!,
        );
        if (logResponse.statusCode == 201) {
          var response = jsonDecode(logResponse.body);
          showAppSnackBar(type: 'success', context: context, title: response['message']);
          isLoading = false;
          trackingInfoAPI();
          notifyListeners();
        } else {
          var response = jsonDecode(logResponse.body);
          isLoading = false;
          notifyListeners();
          print("TRACKING IMAGES ERROR : ${logResponse.body}");
          showAppSnackBar(type: 'Error', context: context, title: response['message']);
        }
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
      print("TRACKING IMAGES E : $e");
    }
  }


  Future trackingInfoAPI() async {
    print("ITS WORKING AFTER NOTES:--------");
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.trackingInfoList(id:
      trackingInfoId
      // 18
      );
      if (response.statusCode == 200) {
        markers.clear();
        var responseData = jsonDecode(response.body);
        print("responseData:---------------1 ${responseData}");
        trackingInfoNotesList = responseData['trackingInfo']['trackingNotes'];
        trackingInfoImagesList = responseData['trackingInfo']['trackingImages'];
        print("responseData:---------------2 ${responseData}");
        latitude = responseData['trackingInfo']['latitude'] ?? 0.0;
        longitude = responseData['trackingInfo']['longitude'] ?? 0.0;
        initialPosition = LatLng(latitude ?? 0.0, longitude ?? 0.0);
        print("responseData:---------------3 ${responseData}");
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
