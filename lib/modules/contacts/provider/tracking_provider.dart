
import 'dart:convert';
import 'dart:io';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/app_token.dart';
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
  double? latitude = 0.0;
  double? longitude = 0.0;
  String token = '';
  bool isLoading = false;
  File? image;
  List<Marker> markers = [];
  String address = '';
  bool _geoLocationBtn = false;

  bool get geoLocationBtn => _geoLocationBtn;

  set geoLocationBtn(bool value) {
    _geoLocationBtn = value;
    notifyListeners();
  }


  TrackingCurrentLocationProvider() {
    getToken().then((value) {
      token = value;
    });
    getMapData();
    notifyListeners();
  }

  void addMarker(LatLng latLng, String address) {
    markers.add(
      Marker(
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

  Future<void> getImage(BuildContext context,ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      await trackingImages(context);
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
      var logResponse = await apiServices.trackingNotes(token: token,description: addNotesController.text);
      if (logResponse.statusCode == 201) {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        showAppSnackBar(type: 'success', context: context, title: response['message']);
        addNotesController.clear();
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
      var logResponse = await apiServices.trackingInfo(token: token, latitude: latitude,longitude: longitude,address: address);
      if (logResponse.statusCode == 201) {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        showAppSnackBar(type: 'success', context: context, title: response['message']);
        addNotesController.clear();
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
          token: token,
          trackingInfoId: 1,
          image: image!,
        );
        if (logResponse.statusCode == 201) {
          var response = jsonDecode(logResponse.body);
          isLoading = false;
          notifyListeners();
          showAppSnackBar(type: 'success', context: context, title: response['message']);
          addNotesController.clear();
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


}
