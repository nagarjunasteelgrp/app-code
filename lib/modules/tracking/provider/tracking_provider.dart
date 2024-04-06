import 'dart:convert';
import 'dart:io';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:file_picker/file_picker.dart';
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
  LatLng? initialPosition;
  int? userId;
  dynamic contactTypeId;
  String? contactTypeCompanyName;
  String? contactTypeName;
  List trackingInfoList = [];
  String? imageType;
  String? selectedFileName;
  File? filePath;

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
    notifyListeners();
    contactTypeId = Get.arguments['id'] ?? '';
    print("TRACKING ID: $contactTypeId");
    contactTypeCompanyName = Get.arguments['companyName'] ?? '';
    print("TRACKING COMPANY NAME: $contactTypeCompanyName");
    contactTypeName = Get.arguments['contactType'] ?? '';
    print("TRACKING TYPE NAME: $contactTypeName");
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

   openFileExplorer(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      filePath = File(result.files.single.path!);
      selectedFileName = result.files.single.name;
      if(filePath != null){
        return trackingImages(context).then((response) {
          if(response.statusCode == 201){
            print("RESPONSE :++++++ 1");
            var res = jsonDecode(response.body);
            print("RESPONSE :++++++ 2 $res");
            showAppSnackBar(type: 'success', context: context, title: res['message']);
            trackingInfoAPI();
            notifyListeners();
          }else{
            var res = jsonDecode(response.body);
            showAppSnackBar(
                type: 'Error', context: context, title: res['message']);
            notifyListeners();
          }
          });
      }
    }
  }

  Future getImage(BuildContext context,ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source).then((value) {
      if (value != null) {
        image = File(value.path);
        if(image != null){
          isLoading = true;
          notifyListeners();
           trackingImages(context).then((response) {
             if(response.statusCode == 201){
               var res = jsonDecode(response.body);
               showAppSnackBar(
                   type: 'success', context: context, title: res['message']);
               trackingInfoAPI();
               notifyListeners();
               Get.back();
               isLoading = false;
               notifyListeners();
             }else{
               var res = jsonDecode(response.body);
               showAppSnackBar(
                   type: 'Error', context: context, title: res['message']);
               isLoading = false;
               notifyListeners();
               Get.back();
             }
           });
        }
        notifyListeners();
      } else {
        print('No image selected.');
      }
    });
    notifyListeners();
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
      print("TRACKING MAP ADDRESS 4: $contactTypeId");
      var logResponse = await apiServices.trackingInfo(latitude: latitude,longitude: longitude,address: address,dealerId: contactTypeId);
      if (logResponse.statusCode == 201) {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        print("TRACKING MAP RESPONSE : $response");
        trackingInfoId = response['activity']['id'];
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

   trackingImages(BuildContext context) async {
      return await apiServices.trackingImages(
          trackingInfoId: trackingInfoId!,
          image: (imageType == "image") ? image! : filePath!,
          imageType: imageType!,
        );
  }


  Future trackingInfoAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.trackingInfoList(id: contactTypeId!);
      if (response.statusCode == 200) {
        markers.clear();
        var responseData = jsonDecode(response.body);
        trackingInfoList = responseData['activity'];
      } else {
        // var responseData = jsonDecode(response.body);
        // return responseData;
        print("CONTACTS DETAILS Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception:------- $e");
      return false;
    }  finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> autoTrackingInfo(latitude,longitude,address) async {
    notifyListeners();
    try {
      print("AUTO TRACKING INFO MAP ADDRESS 1: $latitude");
      print("AUTO TRACKING INFO MAP ADDRESS 2: $longitude");
      print("AUTO TRACKING INFO MAP ADDRESS 3: $address");
      print("AUTO TRACKING INFO MAP ADDRESS 4: $userId");
      var logResponse = await apiServices.autoTrackingAPI(latitude: latitude,longitude: longitude,address: address);
      if (logResponse.statusCode == 201) {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        latitude = response['trackingInfo']['latitude'] ?? 0.0;
        longitude = response['trackingInfo']['longitude'] ?? 0.0;
        print("AUTO TRACKING MAP RESPONSE : $response");
        notifyListeners();
        Get.back();
      } else {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        print("AUTO TRACKING MAP ERROR : ${response['message']}");
        // showAppSnackBar(type: 'Error', context: context, title: response['message']);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      // showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
      print("TRACKING MAP E : $e");
    }
  }


}
