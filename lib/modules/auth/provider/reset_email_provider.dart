import 'dart:convert';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/validation.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:get/get.dart';

class ResetEmailProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  TextEditingController resetEmailController = TextEditingController();

  Future<void> resetEmail(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!Validation.isValidEmail(resetEmailController.text.trim())) {
      showAppSnackBar(
          context: context, title: 'Please enter a valid email address.');
      return;
    }
    notifyListeners();
    try {
      var logResponse =
          await apiServices.resetEmail(email: resetEmailController.text);
      if (logResponse.statusCode == 200) {
        var response = jsonDecode(logResponse.body);
        resetEmailController.clear();
        showAppSnackBar(
          type: 'success',
          context: context,
          title: response['message'],
        );
        Get.offNamed(RoutesName.LOGIN);
      } else {
        var response = jsonDecode(logResponse.body);
        showAppSnackBar(
          type: 'Error',
          context: context,
          title: response['message'],
        );
      }
    } catch (e) {
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
    }
  }
}
