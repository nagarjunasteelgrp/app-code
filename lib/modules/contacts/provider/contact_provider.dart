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
  TextEditingController phoneNumber2Controller = TextEditingController();
  TextEditingController landlineController = TextEditingController();
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
  int? contactId;

  int? selectedContactIndex;

  void selectContactIndex(int index) {
    selectedContactIndex = index;
    notifyListeners();
  }

  List dropDown = [
    "dealer",
    "customer",
    "fabricator",
    "engineers",
    "masons",
  ];

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void updateSearchQuery(String newQuery) {
    _searchQuery = newQuery;
    notifyListeners();
  }

  void searchContacts(String query) {
    updateSearchQuery(query);
    filteredContactList = contactList.where((contact) {
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
    if (contactId != null) {
      contactDetailsAPI();
    }
  }

  dropDownSelectedValue (newValue) {
    selectedValue = newValue;
    notifyListeners();
  }



  //This API for list of contacts================================
  Future<void> listOfContacts() async {
    contactList.clear();
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.contactListAPI(type: selectedValue.toString());
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        contactList = responseData['contacts'];
        notifyListeners();
      } else {
      }
    } catch (e) {
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }


  // This function calling for clear controller=====================
  clearData() {
    companyNameController.clear();
    personNameController.clear();
    phoneNumberController.clear();
    phoneNumber2Controller.clear();
    landlineController.clear();
    emailController.clear();
    addressController.clear();
    descriptionController.clear();
  }


  // This API for create contact====================================
  Future<void> createContact(BuildContext context) async {
    FocusScope.of(context).unfocus();
    String companyName = companyNameController.text.trim();
    String personName = personNameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String phoneNumber2 = phoneNumber2Controller.text.trim();
    String landLine = landlineController.text.trim();
    String emailId = emailController.text.trim();
    String contactType = contactTypeController.text.trim();
    String address = addressController.text.trim();
    String description = descriptionController.text.trim();
    print("contactType.......... $contactType");

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
        phone2: phoneNumber2,
        landline: landLine,
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
        phoneNumber2Controller.clear();
        landlineController.clear();
        emailController.clear();
        addressController.clear();
        descriptionController.clear();
        Get.back();
        listOfContacts();
        notifyListeners();
      }
      else {
        isAddContactButton = false;
        notifyListeners();
        var responseBody = jsonDecode(logResponse.body);
        resMessage = responseBody['message'];
        Get.back();
      }
    } catch (e) {
      isAddContactButton = false;
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
    }
  }


  // This API for update contact data fetching=============================
  Future<void> contactDetailsAPI() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await apiServices.contactDetails(id: contactId!);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData is Map && responseData.isNotEmpty) {
          companyNameController.text = responseData['companyName'];
          personNameController.text = responseData['personName'];
          contactTypeController.text = responseData['contactType'];
          phoneNumberController.text = responseData['phone'];
          emailController.text = responseData['email'];
          addressController.text = responseData['address'];
          descriptionController.text = responseData['description'];
          landlineController.text = responseData['landline'];
          phoneNumber2Controller.text = responseData['phone2'];
        }
        notifyListeners();
      }
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  // This API for update contact data=============================
  Future<void> contactUpdate(BuildContext context) async {
    isAddContactButton = true;
    FocusScope.of(context).unfocus();
    if (companyNameController.text.isEmpty) {
      resMessage = "Please enter your companyName.";
      return;
    }
    if (personNameController.text.isEmpty) {
      resMessage = "Please enter your personName.";
      return;
    }
    if (phoneNumberController.text.isEmpty) {
      resMessage = "Please enter your phoneNumber.";
      return;
    }else if(phoneNumberController.text.length > 10){
      resMessage = "Please enter a valid 10-digit phoneNumber.";
      return;
    }
    if (emailController.text.isEmpty) {
      resMessage = "Please enter your email.";
      return;
    } else if (!Validation.isValidEmail(emailController.text.trim())) {
      resMessage = "Please enter a valid email address.";
      return;
    }
    if (addressController.text.isEmpty) {
      resMessage = "Please enter your address.";
      return;
    }
    if (descriptionController.text.isEmpty) {
      resMessage = "Please enter your description.";
      return;
    }

    try {
      print("contactTypeController.text............. ${contactTypeController.text}");
      var logResponse = await apiServices.contactUpdate(
        personName: personNameController.text,
        companyName: companyNameController.text,
        email: emailController.text,
        phone: phoneNumberController.text,
        phone2: phoneNumber2Controller.text,
        landline: landlineController.text,
        contactType: contactTypeController.text,
        address: addressController.text,
        description: descriptionController.text,
        contactUserId: contactId,
      );

      if (logResponse.statusCode == 200) {
        isAddContactButton = false;
        selectedContactIndex = -1;
        listOfContacts();
        Get.back();
        notifyListeners();
      }
      print("logResponse.statusCode............. ${logResponse.statusCode}");
    }catch (e) {
      isAddContactButton = false;
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
    }

  }

}
