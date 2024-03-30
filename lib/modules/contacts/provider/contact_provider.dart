import 'dart:io';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:digital_lync/services/api_service.dart';

class ContactProvider extends ChangeNotifier{

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

     toggleSelected(bool value) {
        isSelected = value;
        notifyListeners();
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


 /* Future<void> createContact(BuildContext context) async {
    FocusScope.of(context).unfocus();
    print("companyNameController:- ${companyNameController.text}");
    print("personNameController:- ${personNameController.text}");
    print("contactTypeController:- ${contactTypeController.text}");
    print("phoneNumberController:- ${phoneNumberController.text}");
    print("emailController:- ${emailController.text}");
    print("addressController:- ${addressController.text}");
    print("taxIdController:- ${taxIdController.text}");
    print("descriptionController:- ${descriptionController.text}");

    String companyName = companyNameController.text.trim();
    String personName = personNameController.text.trim();
    String contactType = contactTypeController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String emailId = emailController.text.trim();
    String address = addressController.text.trim();
    String taxId = taxIdController.text.trim();
    String description = descriptionController.text.trim();

    if (companyName.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your companyName.');
      return;
    }
    if (personName.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your personName.');
      return;
    }
    if (contactType.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your contactType.');
      return;
    }
    if (phoneNumber.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your phoneNumber.');
      return;
    }
    if (emailId.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your email.');
      return;
    }
    if (address.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your address.');
      return;
    } if (taxId.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your taxId.');
      return;
    }if (description.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your description.');
      return;
    }

    notifyListeners();
    try {
      var logResponse = await apiServices.login(email: emailController.text, password: passwordController.text);
      if (logResponse.containsKey('token')) {
        print("LOGIN SUCCESS : ${logResponse['token']}");
        await sharedPrefers.saveTokenToPrefs(logResponse['token']);
        showAppSnackBar(type: 'success', context: context, title: logResponse['message']);
        emailController.clear();
        passwordController.clear();
        Get.toNamed(RoutesName.HOME);
      } else {
        print("LOGIN ERROR : ${logResponse['message']}");
        showAppSnackBar(type: 'Error', context: context, title: logResponse['message']);
      }
    } catch (e) {
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
      print("LOGIN E : $e");
    }
  }*/


}