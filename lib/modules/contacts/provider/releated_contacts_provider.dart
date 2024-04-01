import 'dart:convert';

import 'package:digital_lync/constants/app_token.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class RelatedContactProvider extends ChangeNotifier{

  String token = '';
  bool isLoading = false;
  List relatedContactList = [];
  ApiServices apiServices = ApiServices();

  RelatedContactProvider() {
    getToken().then((value) {
      token = value;
      listOfRelatedContacts(token);
    });
  }


  Future<void> listOfRelatedContacts(token) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.listOfRelatedContact(token: token);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("LIST OF RELATED CONTACTS : ${responseData}");
        List contacts = responseData;
        relatedContactList = contacts;
        notifyListeners();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }

}