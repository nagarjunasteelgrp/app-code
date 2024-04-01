import 'dart:convert';
import 'dart:io';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/app_token.dart';
import 'package:digital_lync/constants/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:digital_lync/services/api_service.dart';

class ContactProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController contactTypeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController taxIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  bool isSelected = true;
  String? token;
  List contactList = [];
  bool isLoading = false;
  bool isAddContactButton = false;
  String? selectedValue;
  List dropDown = [
    "customer",
    "admin"
  ];

  toggleSelected(bool value) {
    isSelected = value;
    notifyListeners();
  }

  ContactProvider() {
    selectedValue = dropDown.first;
    getToken().then((value) {
      token = value;
      listOfContacts(token);
    });
  }

  dropDownSelectedValue (newValue) {
    selectedValue = newValue;
    notifyListeners();
  }


  Future<void> listOfContacts(token) async {
    try {
      if(contactList.isEmpty){
      isLoading = true;
      notifyListeners();
      }
      var response = await apiServices.listOfContact(token: token);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("LIST OF CONTACTS : ${responseData['contacts']}");
        List contacts = responseData['contacts'];
        contactList = contacts;
        notifyListeners();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
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
    String taxId = taxIdController.text.trim();
    String address = addressController.text.trim();
    String description = descriptionController.text.trim();

    print("Company Name : $companyName");
    print("Person Name : $personName");
    print("Phone Number : $phoneNumber");
    print("Email Id : $emailId");
    print("Contact Type : $contactType");
    print("Tax Id : $taxId");
    print("Address : $address");
    print("Description : $description");

    if (companyName.isEmpty) {
      showAppSnackBar(
          context: context, title: 'Please enter your companyName.');
      return;
    }
    if (personName.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your personName.');
      return;
    }
    if (phoneNumber.isEmpty) {
      showAppSnackBar(
          context: context, title: 'Please enter your phoneNumber.');
      return;
    } else if (phoneNumber.length != 10) {
      showAppSnackBar(
          context: context,
          title: 'Please enter a valid 10-digit phoneNumber.');
      return;
    }
    if (emailId.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your email.');
      return;
    } else if (!Validation.isValidEmail(emailController.text.trim())) {
      showAppSnackBar(
          context: context, title: 'Please enter a valid email address.');
      return;
    }
    // if (contactType.isEmpty) {
    //   showAppSnackBar(
    //       context: context, title: 'Please enter your contactType.');
    //   return;
    // }
    if (taxId.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your taxId.');
      return;
    }
    if (address.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your address.');
      return;
    }
    if (description.isEmpty) {
      showAppSnackBar(
          context: context, title: 'Please enter your description.');
      return;
    }
    isAddContactButton = true;
    notifyListeners();
    try {
      var logResponse = await apiServices.createContact(
        token: token,
        personName: personName,
        companyName: companyName,
        email: emailId,
        phone: phoneNumber,
        contactType: contactType.isNotEmpty ? contactType : 'customer',
        taxId: taxId,
        address: address,
        description: description,
      );
      if (logResponse.statusCode == 201) {
        isAddContactButton = false;
        notifyListeners();
        var responseBody = jsonDecode(logResponse.body);
        showAppSnackBar(
            type: 'success', context: context, title: responseBody['message']);
        companyNameController.clear();
        personNameController.clear();
        contactTypeController.clear();
        phoneNumberController.clear();
        emailController.clear();
        addressController.clear();
        taxIdController.clear();
        descriptionController.clear();
        Get.back();
        listOfContacts(token);
        notifyListeners();
      } else {
        isAddContactButton = false;
        notifyListeners();
        var responseBody = jsonDecode(logResponse.body);
        print("LOGIN ERROR : ${responseBody['message']}");
        showAppSnackBar(
            type: 'Error', context: context, title: responseBody['message']);
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
