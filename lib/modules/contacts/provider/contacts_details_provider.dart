import 'dart:convert';
import 'package:digital_lync/constants/app_token.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/material.dart';

class ContactDetailsProvider extends ChangeNotifier{

  ApiServices apiServices = ApiServices();
  bool isLoading = false;
  int? contactId;
  String? token;
  List contactDetails = [];
  String? companyName;
  String? personName;
  String? contactType;
  String? phoneNumber;
  String? email;




  ContactDetailsProvider() {
    getToken().then((value) {
      token = value;
      contactDetailsAPI(token);
    });
  }

  Future<void> contactDetailsAPI(context) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.contactDetails(token: token, id: contactId!);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("CONTACTS List DETAILS: $responseData");
        if (responseData is Map && responseData.isNotEmpty) {
          companyName = responseData['companyName'];
          personName = responseData['personName'];
          contactType = responseData['contactType'];
          phoneNumber = responseData['phone'];
          email = responseData['email'];
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