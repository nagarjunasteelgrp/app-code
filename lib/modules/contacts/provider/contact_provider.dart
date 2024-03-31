import 'dart:convert';
import 'dart:io';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/app_token.dart';
import 'package:digital_lync/constants/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:digital_lync/services/api_service.dart';

class ContactProvider extends ChangeNotifier{
  ApiServices apiServices = ApiServices();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController contactTypeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController taxIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

    File? image;
    bool isSelected = true;
    String?  token;
    List contactList = [];
    bool isLoading = false;


     toggleSelected(bool value) {
        isSelected = value;
        notifyListeners();
    }

  ContactProvider() {
    getToken().then((value) {
      token = value;
      listOfContacts(token);
    });
  }

  Future<void> getImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: source);
        if (pickedImage != null) {
          image = File(pickedImage.path);
        } else {
          print('No image selected.');
        }
      notifyListeners();
    }

  Future<void> listOfContacts(token) async {
    try {
      isLoading = true;
    notifyListeners();
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
    String taxId = taxIdController.text.trim();
    String address = addressController.text.trim();
    String description = descriptionController.text.trim();

    if (companyName.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your companyName.');
      return;
    }
    if (personName.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your personName.');
      return;
    }
    if (phoneNumber.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your phoneNumber.');
      return;
    }
    else if (phoneNumber.length != 10) {
      showAppSnackBar(context: context, title: 'Please enter a valid 10-digit phoneNumber.');
      return;
    }
    if (emailId.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your email.');
      return;
    }
    else if (!Validation.isValidEmail(emailController.text.trim())) {
      showAppSnackBar(context: context, title: 'Please enter a valid email address.');
      return;
    }
    if (contactType.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your contactType.');
      return;
    }
    if (taxId.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your taxId.');
      return;
    }
    if (address.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your address.');
      return;
    }
    if (description.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your description.');
      return;
    }

    notifyListeners();
    try {
      var logResponse = await apiServices.createContact(
        token: token,
        personName: personName,
        companyName: companyName,
        email: emailId,
        phone: phoneNumber,
        contactType: contactType,
        taxId: taxId,
        address: address,
        description: description,
      );
      if (logResponse.statusCode == 200) {
        var responseBody = jsonDecode(logResponse.body);
        showAppSnackBar(type: 'success', context: context, title: responseBody['message']);
        emailController.clear();
      } else {
        var responseBody = jsonDecode(logResponse.body);
        print("LOGIN ERROR : ${responseBody['message']}");
        showAppSnackBar(type: 'Error', context: context, title: responseBody['message']);
      }
    } catch (e) {
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
      print("LOGIN E : $e");
    }
  }

}