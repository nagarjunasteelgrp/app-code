import 'dart:convert';
import 'package:digital_lync/constants/app_token.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ContactDetailsProvider extends ChangeNotifier{

  ApiServices apiServices = ApiServices();
  bool isLoading = false;
  dynamic contactId;
  List contactDetails = [];
  String? companyName;
  String? personName;
  String? contactType;
  String? phoneNumber;
  String? email;
  String? address;
  String? taxId;
  String? description;


  ContactDetailsProvider() {
    contactId = Get.arguments['id'] ?? '';
    print("CONTACTS DETAILS: $contactId");
    notifyListeners();
      contactDetailsAPI();
  }

  Future<void> contactDetailsAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.contactDetails(id: contactId!);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("CONTACTS List DETAILS: $responseData");
        if (responseData is Map && responseData.isNotEmpty) {
          companyName = responseData['companyName'];
          personName = responseData['personName'];
          contactType = responseData['contactType'];
          phoneNumber = responseData['phone'];
          email = responseData['email'];
          address = responseData['address'];
          taxId = responseData['taxId'];
          description = responseData['description'];
        } else {
          print("Empty or invalid response data.");
        }
        notifyListeners();
      } else {
        print("CONTACTS DETAILS Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}