import 'dart:convert';
import 'dart:io';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/services/api/api_service.dart';
import 'package:digital_lync/services/location_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TrackingProvider extends ChangeNotifier {
  ImagePicker picker = ImagePicker();
  ApiServices apiServices = ApiServices();

  ScrollController scrollController = ScrollController();
  TextEditingController addNotesController = TextEditingController();

  File? image;
  int limit = 5;
  File? filePath;
  List markers = [];
  String? imageType;
  String? dealerName;
  dynamic contactTypeId;
  int trackingInfoId = 0;
  bool isLoading = false;
  DateTime? _selectedDate;
  String? contactTypeName;
  String? selectedFileName;
  List trackingInfoList = [];
  bool isFetchingMore = false;
  bool _geoLocationBtn = false;
  String? contactTypeCompanyName;
  List trackingInfoListStoreData = [];
  bool get geoLocationBtn => _geoLocationBtn;
  DateTime? get selectedDate => _selectedDate;
  TextEditingController noteController = TextEditingController();

  TrackingProvider() {
    initialData();
    contactTypeId = Get.arguments['id'] ?? '';
    contactTypeName = Get.arguments['contactType'] ?? '';
    contactTypeCompanyName = Get.arguments['companyName'] ?? '';
    trackingInfoAPI();
    onScrollForPagination();
    notifyListeners();
  }

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void onScrollForPagination() {
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            !isFetchingMore) {
          loadMoreData();
        }
      },
    );
  }

  initialData() async {
    LocationService locationService = LocationService();
    locationService.determinePosition();
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
        showAppSnackBar(type: 'success', title: responseData['message']);
        isLoading = false;
        Get.back();
        notifyListeners();
      } else {
        var responseData = jsonDecode(response.body);
        showAppSnackBar(title: responseData['message']);
        isLoading = false;
        Get.back();
        notifyListeners();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void openFileExplorer(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc'],
    );
    if (result != null) {
      filePath = File(result.files.single.path!);
      selectedFileName = result.files.single.name;
      if (filePath != null) {
        return trackingImages(context).then((response) {
          if (response.statusCode == 201) {
            var res = jsonDecode(response.body);
            showAppSnackBar(
              type: 'success',
              title: res['message'],
            );
            trackingInfoAPI();
            notifyListeners();
          } else {
            var res = jsonDecode(response.body);
            showAppSnackBar(
              type: 'Error',
              title: res['message'],
            );
            notifyListeners();
          }
        });
      }
    }
  }

  Future getImage(ImageSource source) async {
    try {
      final picked = await picker.pickImage(
        source: source,
        imageQuality: 65,
      );

      if (picked == null) {
        isLoading = false;
        notifyListeners();
        return;
      }

      image = File(picked.path);

      isLoading = true;
      notifyListeners();

      final response = await trackingImages(Get.context!);

      final res = jsonDecode(response.body);

      if (response.statusCode == 201) {
        trackingInfoAPI();

        showAppSnackBar(type: 'success', title: res['message']);
      } else {
        showAppSnackBar(type: 'Error', title: res['message']);
        Get.back();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> trackingMap(
    BuildContext context, {
    required double latitude,
    required double longitude,
    required String addressPlacement,
  }) async {
    isLoading = true;
    notifyListeners();
    FocusScope.of(context).unfocus();
    notifyListeners();
    try {
      var logResponse = await apiServices.trackingInfo(
        latitude: latitude,
        longitude: longitude,
        dealerId: contactTypeId,
        address: addressPlacement,
      );
      if (logResponse.statusCode == 201) {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        trackingInfoId = response['activity']['id'];
        showAppSnackBar(type: 'success', title: response['message']);
        addNotesController.clear();
        trackingInfoAPI();
        notifyListeners();
        if (context.mounted && Navigator.canPop(context)) {
          Get.back();
        }
      } else {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        showAppSnackBar(type: 'Error', title: response['message']);
        if (context.mounted && Navigator.canPop(context)) {
          Get.back();
        }
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showAppSnackBar(title: 'Error', subtitle: e.toString());
      if (context.mounted && Navigator.canPop(context)) {
        Get.back();
      }
    }
  }

  Future<void> trackingAddNotes(BuildContext context) async {
    FocusScope.of(context).unfocus();
    String addNotes = addNotesController.text.trim();

    if (addNotes.isEmpty) {
      showAppSnackBar(title: 'Please enter your notes.');
      return;
    }
    isLoading = true;
    notifyListeners();

    try {
      var logResponse = await apiServices.trackingNotes(
        description: addNotes,
        trackingInfoId: trackingInfoId,
      );

      var response = jsonDecode(logResponse.body);

      if (logResponse.statusCode == 201) {
        showAppSnackBar(type: 'success', title: response['message']);
        addNotesController.clear();
        trackingInfoAPI();
        Get.back();
      } else {
        showAppSnackBar(type: 'Error', title: response['message']);
      }
    } catch (e) {
      showAppSnackBar(
        type: 'Error',
        title: 'Something went wrong',
        subtitle: e.toString(),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future trackingImages(BuildContext context) async {
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
    if (isFetchingMore) return;
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
}
