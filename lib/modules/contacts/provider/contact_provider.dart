import 'dart:convert';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/constants/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digital_lync/services/api_service.dart';

class ContactProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController contactTypeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  bool isSelected = true;
  List contactList = [];
  bool isLoading = false;
  bool isAddContactButton = false;
  String? selectedValue;
  bool isExpanded = false;
  var resMessage;
  List<dynamic> filteredContactList = [];
  List<dynamic> displayList = [];

  List dropDown = [
    "dealer",
    "customer",
    "fabricator",
  ];

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void updateSearchQuery(String newQuery) {
    _searchQuery = newQuery;
    print("_SearchQuery: $_searchQuery");
    notifyListeners();
  }

  void searchContacts(String query) {
    updateSearchQuery(query);
    filteredContactList = contactList.where((contact) {
      print("filteredContactList: $filteredContactList");
      // print("")
      return contact['companyName'].toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }

  bool _isListReversed = false;
  bool get isListReversed => _isListReversed;

  void toggleListOrder() {
    _isListReversed = !_isListReversed;
    notifyListeners();
  }

  toggleSelected(bool value) {
    isSelected = value;
    notifyListeners();
  }

  ContactProvider() {
    selectedValue = dropDown.first;
    listOfContacts();
  }

  dropDownSelectedValue (newValue) {
    selectedValue = newValue;
    notifyListeners();
  }


  Future<void> listOfContacts() async {
    print("SELECTED VALUE:-- $selectedValue");
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.contactListAPI(type: selectedValue.toString());
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("LIST OF RELATED CONTACTS : ${responseData}");
        contactList = responseData['contacts'];
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

  Future<void> createContact(BuildContext context) async {
    FocusScope.of(context).unfocus();
    String companyName = companyNameController.text.trim();
    String personName = personNameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String emailId = emailController.text.trim();
    String contactType = contactTypeController.text.trim();
    String address = addressController.text.trim();
    String description = descriptionController.text.trim();

    if (companyName.isEmpty) {
      resMessage = "Please enter your companyName.";
      return;
    }
    if (personName.isEmpty) {
      resMessage = "Please enter your personName.";
      return;
    }
    if (phoneNumber.isEmpty) {
      resMessage = "Please enter your phoneNumber.";
      return;
    } else if (phoneNumber.length != 10) {
      resMessage = "Please enter a valid 10-digit phoneNumber.";
      return;
    }
    if (emailId.isEmpty) {
      resMessage = "Please enter your email.";
      return;
    } else if (!Validation.isValidEmail(emailController.text.trim())) {
      resMessage = "Please enter a valid email address.";
      return;
    }
    if (address.isEmpty) {
      resMessage = "Please enter your address.";
      return;
    }
    if (description.isEmpty) {
      resMessage = "Please enter your description.";
      return;
    }
    isAddContactButton = true;
    notifyListeners();
    try {
      var logResponse = await apiServices.createContact(
        personName: personName,
        companyName: companyName,
        email: emailId,
        phone: phoneNumber,
        contactType: contactType.isNotEmpty ? contactType : 'dealer',
        address: address,
        description: description,
      );
      if (logResponse.statusCode == 201) {
        isAddContactButton = false;
        notifyListeners();
        var responseBody = jsonDecode(logResponse.body);
        showAppSnackBar(
            type: 'success', context: context, title: responseBody['message']);
        resMessage = '';
        companyNameController.clear();
        personNameController.clear();
        contactTypeController.clear();
        phoneNumberController.clear();
        emailController.clear();
        addressController.clear();
        descriptionController.clear();
        Get.back();
        listOfContacts();
        notifyListeners();
      } else {
        isAddContactButton = false;
        notifyListeners();
        var responseBody = jsonDecode(logResponse.body);
        print("LOGIN ERROR : ${responseBody['message']}");
        // showAppSnackBar(
        //     type: 'Error', context: context, title: responseBody['message']);
        resMessage = responseBody['message'];
        Get.back();
      }
    } catch (e) {
      isAddContactButton = false;
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
      print("LOGIN E : $e");
    }
  }

}
