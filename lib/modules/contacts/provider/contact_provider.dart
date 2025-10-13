import 'dart:convert';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digital_lync/services/api_service.dart';

class ContactProvider extends ChangeNotifier {
  ContactProvider() {
    selectedValue = dropDown.first;
    listOfContacts();
    if (contactId != null) {
      contactDetailsAPI();
    }
  }

  int? contactId;
  dynamic resMessage;
  List contactList = [];
  String? selectedValue;
  bool isLoading = false;
  bool isSelected = true;
  bool isExpanded = false;
  String _searchQuery = '';
  int? selectedContactIndex;
  bool _isListReversed = false;
  List<dynamic> displayList = [];
  bool isAddContactButton = false;
  List<dynamic> filteredContactList = [];
  String get searchQuery => _searchQuery;
  ApiServices apiServices = ApiServices();
  bool get isListReversed => _isListReversed;
  List dropDown = ["dealer", "customer", "fabricator", "engineers", "masons"];

  TextEditingController emailController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landlineController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactTypeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController phoneNumber2Controller = TextEditingController();

  void onDropDownChanged(String? newValue) {
    selectedValue = newValue;
    contactTypeController.text = newValue ?? 'dealer';
    dropDownSelectedValue(newValue);
    notifyListeners();
  }

  void updateSearchQuery(String newQuery) {
    _searchQuery = newQuery;
    notifyListeners();
  }

  void selectContactIndex(int index) {
    selectedContactIndex = index;
    notifyListeners();
  }

  void searchContacts(String query) {
    updateSearchQuery(query);
    filteredContactList = contactList.where((contact) {
      return contact['companyName'].toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void toggleListOrder() {
    _isListReversed = !_isListReversed;
    notifyListeners();
  }

  toggleSelected(bool value) {
    isSelected = value;
    notifyListeners();
  }

  //This API for list of contacts
  void dropDownSelectedValue(String? newValue) => selectedValue = newValue;
  Future<void> listOfContacts() async {
    contactList.clear();
    try {
      isLoading = true;
      notifyListeners();
      var response =
          await apiServices.contactListAPI(type: selectedValue.toString());
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        contactList = responseData['contacts'];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // This function calling for clear controller 
  clearData() {
    companyNameController.clear();
    personNameController.clear();
    phoneNumberController.clear();
    phoneNumber2Controller.clear();
    landlineController.clear();
    gstNumberController.clear();
    emailController.clear();
    addressController.clear();
    descriptionController.clear();
    notifyListeners();
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
    if (gstNumberController.text.isNotEmpty) {
      if (gstNumberController.text.length < 15) {
        resMessage = "Please enter a valid GST number.";
        return;
      }
    }
    if (address.isEmpty) {
      resMessage = "Please enter your address.";
      return;
    }
    isAddContactButton = true;
    notifyListeners();
    try {
      var logResponse = await apiServices.createContact(
        email: emailId,
        address: address,
        phone: phoneNumber,
        landline: landLine,
        phone2: phoneNumber2,
        personName: personName,
        description: description,
        companyName: companyName,
        gstNumber: gstNumberController.text,
        contactType: contactType.isNotEmpty ? contactType : 'dealer',
      );
      if (logResponse.statusCode == 201) {
        isAddContactButton = false;
        notifyListeners();
        var responseBody = jsonDecode(logResponse.body);
        showAppSnackBar(
          type: 'success',
          context: Get.context!,
          title: responseBody['message'],
        );

        resMessage = '';
        companyNameController.clear();
        personNameController.clear();
        contactTypeController.clear();
        phoneNumberController.clear();
        phoneNumber2Controller.clear();
        landlineController.clear();
        gstNumberController.clear();
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
        resMessage = responseBody['message'];
        Get.back();
      }
    } catch (e) {
      isAddContactButton = false;
      notifyListeners();

      showAppSnackBar(
        title: 'Error',
        context: Get.context!,
        subtitle: e.toString(),
      );
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
          emailController.text = responseData['email'];
          addressController.text = responseData['address'];
          phoneNumberController.text = responseData['phone'];
          landlineController.text = responseData['landline'];
          phoneNumber2Controller.text = responseData['phone2'];
          personNameController.text = responseData['personName'];
          descriptionController.text = responseData['description'];
          companyNameController.text = responseData['companyName'];
          contactTypeController.text = responseData['contactType'];
          gstNumberController.text = responseData['gstNumber'] ?? '';
        }
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // This API for update contact data
  Future<void> contactUpdate(BuildContext context) async {
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
    } else if (phoneNumberController.text.length > 10) {
      resMessage = "Please enter a valid 10-digit phoneNumber.";
      return;
    }
    if (gstNumberController.text.isNotEmpty) {
      if (gstNumberController.text.length < 15) {
        resMessage = "Please enter a valid GST number.";
        return;
      }
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
    isAddContactButton = true;
    try {
      var logResponse = await apiServices.contactUpdate(
        personName: personNameController.text,
        companyName: companyNameController.text,
        email: emailController.text,
        phone: phoneNumberController.text,
        phone2: phoneNumber2Controller.text,
        landline: landlineController.text,
        gstNumber: gstNumberController.text,
        contactType: contactTypeController.text,
        address: addressController.text,
        description: descriptionController.text,
        contactUserId: contactId,
      );

      if (logResponse.statusCode == 200) {
        isAddContactButton = false;
        selectedContactIndex = -1;
        resMessage = '';
        listOfContacts();
        Get.back();
        notifyListeners();
      }
    } catch (e) {
      isAddContactButton = false;
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
    }
  }
}
