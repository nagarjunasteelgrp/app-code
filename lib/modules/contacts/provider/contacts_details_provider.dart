import 'dart:convert';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/validation.dart';
import 'package:digital_lync/services/api/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactDetailsProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController contactTypeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController taxIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
  int? contactUserId;
  String? selectedValue;
  List dropDown = ["customer", "fabricator", "dealer", "engineers", "masons"];

  dropDownSelectedValue(newValue) {
    selectedValue = newValue;
    notifyListeners();
  }

  ContactDetailsProvider() {
    selectedValue = dropDown.first;
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
        if (responseData is Map && responseData.isNotEmpty) {
          companyName = responseData['companyName'];
          personName = responseData['personName'];
          contactType = responseData['contactType'];
          phoneNumber = responseData['phone'];
          email = responseData['email'];
          address = responseData['address'];
          taxId = responseData['taxId'];
          description = responseData['description'];
          contactUserId = responseData['id'];
          companyNameController.text = companyName!;
          personNameController.text = personName!;
          contactTypeController.text = contactType!;
          phoneNumberController.text = phoneNumber!;
          emailController.text = email!;
          addressController.text = address!;
          taxIdController.text = taxId!;
          descriptionController.text = description!;
        } else {}
        notifyListeners();
      } else {}
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> contactUpdate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    String companyName = companyNameController.text.trim();
    String personName = personNameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String emailId = emailController.text.trim();
    String contactType = contactTypeController.text.trim();
    String taxId = taxIdController.text.trim();
    String address = addressController.text.trim();
    String description = descriptionController.text.trim();

    if (companyName.isEmpty) {
      showAppSnackBar(title: 'Please enter your companyName.');
      return;
    }
    if (personName.isEmpty) {
      showAppSnackBar(title: 'Please enter your personName.');
      return;
    }
    if (phoneNumber.isEmpty) {
      showAppSnackBar(title: 'Please enter your phoneNumber.');
      return;
    } else if (phoneNumber.length != 10) {
      showAppSnackBar(title: 'Please enter a valid 10-digit phoneNumber.');
      return;
    }
    if (emailId.isEmpty) {
      showAppSnackBar(title: 'Please enter your email.');
      return;
    } else if (!Validation.isValidEmail(emailController.text.trim())) {
      showAppSnackBar(title: 'Please enter a valid email address.');
      return;
    }
    if (taxId.isEmpty) {
      showAppSnackBar(title: 'Please enter your taxId.');
      return;
    }
    if (address.isEmpty) {
      showAppSnackBar(title: 'Please enter your address.');
      return;
    }
    if (description.isEmpty) {
      showAppSnackBar(title: 'Please enter your description.');
      return;
    }
    isLoading = true;
    notifyListeners();
    try {
      var logResponse = await apiServices.contactUpdate(
        personName: personName,
        companyName: companyName,
        email: emailId,
        phone: phoneNumber,
        contactType: contactType.isNotEmpty ? contactType : 'customer',
        address: address,
        description: description,
        contactUserId: contactUserId,
      );
      if (logResponse.statusCode == 200) {
        isLoading = false;
        notifyListeners();
        var responseBody = jsonDecode(logResponse.body);
        showAppSnackBar(type: 'success', title: responseBody['message']);
        Get.back();
        contactDetailsAPI();
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        var responseBody = jsonDecode(logResponse.body);
        showAppSnackBar(type: 'Error', title: responseBody['message']);
        Get.back();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showAppSnackBar(title: 'Error', subtitle: e.toString());
    }
  }
}
