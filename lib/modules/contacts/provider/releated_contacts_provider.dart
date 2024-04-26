import 'dart:convert';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class RelatedContactProvider extends ChangeNotifier{

  bool isLoading = false;
  List relatedContactList = [];
  ApiServices apiServices = ApiServices();

  RelatedContactProvider() {
      listOfRelatedContacts();
  }

  Future<void> listOfRelatedContacts() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.listOfRelatedContact();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        List contacts = responseData;
        relatedContactList = contacts;
        notifyListeners();
      } else {
      }
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }
}