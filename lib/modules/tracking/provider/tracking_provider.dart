import 'dart:convert';
import 'dart:io';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackingProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  CurrentLocationProvider currentLocationProvider;
  ScrollController scrollController = ScrollController();
  TextEditingController addNotesController = TextEditingController();

  File? image;
  int? userId;
  int limit = 5;
  int pager = 0;
  File? filePath;
  List markers = [];
  String? imageType;
  String? dealerName;
  dynamic contactTypeId;
  int trackingInfoId = 0;
  bool isLoading = false;
  LatLng? initialPosition;
  DateTime? _selectedDate;
  String? contactTypeName;
  String? selectedFileName;
  List trackingInfoList = [];
  bool isFetchingMore = false;
  bool _geoLocationBtn = false;
  String? contactTypeCompanyName;
  List trackingInfoListStoreData = [];

  bool get geoLocationBtn => _geoLocationBtn;

  TextEditingController noteController = TextEditingController();

  DateTime? get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  set geoLocationBtn(bool value) {
    _geoLocationBtn = value;
    notifyListeners();
  }

  TrackingProvider(this.currentLocationProvider) {
    initialData();
    contactTypeId = Get.arguments['id'] ?? '';
    contactTypeCompanyName = Get.arguments['companyName'] ?? '';
    contactTypeName = Get.arguments['contactType'] ?? '';
    trackingInfoAPI();
    onScrollForPagination();
    notifyListeners();
  }

  initialData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    latitude = sharedPreferences.getDouble("latitude");
    longitude = sharedPreferences.getDouble("longitude");
    addressPlacement = sharedPreferences.getString("address") ?? '';
    notifyListeners();
  }

  Future<void> followUpsAPI(context) async {
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.followUpsApi(
          dealerId: contactTypeId,
          notes: noteController.text,
          selectDate: _selectedDate!.toIso8601String());
      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        noteController.clear();
        _selectedDate = null;
        showAppSnackBar(
            type: 'success', context: context, title: responseData['message']);
        isLoading = false;
        Get.back();
        notifyListeners();
      } else {
        var responseData = jsonDecode(response.body);
        showAppSnackBar(context: context, title: responseData['message']);
        isLoading = false;
        Get.back();
        notifyListeners();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addMarker(LatLng latLng, String address) {
    markers.add(
      Marker(
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {},
        position: latLng,
        markerId: MarkerId(latLng.toString()),
      ),
    );
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
      if (filePath != null) {
        return trackingImages(context).then((response) {
          if (response.statusCode == 201) {
            var res = jsonDecode(response.body);
            showAppSnackBar(
                type: 'success', context: context, title: res['message']);
            trackingInfoAPI();
            notifyListeners();
          } else {
            var res = jsonDecode(response.body);
            showAppSnackBar(
                type: 'Error', context: context, title: res['message']);
            notifyListeners();
          }
        });
      }
    }
  }

  Future getImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    await picker.pickImage(source: source).then((value) {
      if (value != null) {
        image = File(value.path);
        if (image != null) {
          isLoading = true;
          notifyListeners();
          trackingImages(context).then((response) {
            if (response.statusCode == 201) {
              var res = jsonDecode(response.body);
              trackingInfoAPI();
              showAppSnackBar(
                  type: 'success', context: context, title: res['message']);
              notifyListeners();
              isLoading = false;
              notifyListeners();
            } else {
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
        isLoading = false;
        notifyListeners();
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
      var logResponse = await apiServices.trackingInfo(
          latitude: latitude,
          longitude: longitude,
          address: addressPlacement,
          dealerId: contactTypeId);
      if (logResponse.statusCode == 201) {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        trackingInfoId = response['activity']['id'];
        showAppSnackBar(
          type: 'success',
          context: context,
          title: response['message'],
        );
        addNotesController.clear();
        trackingInfoAPI();
        notifyListeners();
        Get.back();
      } else {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        showAppSnackBar(
            type: 'Error', context: context, title: response['message']);
        Get.back();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
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
      var logResponse = await apiServices.trackingNotes(
          description: addNotesController.text, trackingInfoId: trackingInfoId);
      if (logResponse.statusCode == 201) {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        showAppSnackBar(
            type: 'success', context: context, title: response['message']);
        addNotesController.clear();
        trackingInfoAPI();
        Get.back();
      } else {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        showAppSnackBar(
            type: 'Error', context: context, title: response['message']);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
    }
  }

  trackingImages(BuildContext context) async {
    return await apiServices.trackingImages(
      trackingInfoId: trackingInfoId,
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
        trackingInfoList.clear();
        var responseData = jsonDecode(response.body);
        trackingInfoListStoreData = responseData['activity'];
        dealerName = trackingInfoListStoreData[0]['dealer']['personName'];
        if (trackingInfoListStoreData.length > limit) {
          trackingInfoList = trackingInfoListStoreData.sublist(0, limit);
        } else {
          trackingInfoList = trackingInfoListStoreData;
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreData() async {
    if (isFetchingMore) return; // Avoid multiple requests
    isFetchingMore = true;
    notifyListeners();
    int currentLength = trackingInfoList.length;
    int endIndex = currentLength + limit;

    if (endIndex < trackingInfoListStoreData.length) {
      trackingInfoList
          .addAll(trackingInfoListStoreData.sublist(currentLength, endIndex));
    } else {
      trackingInfoList.addAll(trackingInfoListStoreData.sublist(currentLength));
    }
    isFetchingMore = false;
    notifyListeners();
  }

  void onScrollForPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isFetchingMore) {
        loadMoreData();
      }
    });
  }
}
