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
    print("Reset Email:- ${resetEmailController.text}");
    if (!Validation.isValidEmail(resetEmailController.text.trim())) {
      showAppSnackBar(context: context, title: 'Please enter a valid email address.');
      return;
    }
    notifyListeners();
    try {
      var logResponse = await apiServices.resetEmail(email: resetEmailController.text);
      if (logResponse['success'] == true) {
        print("RESET EMAIL SUCCESS : ${logResponse['token']}");
        resetEmailController.clear();
        showAppSnackBar(type: 'success', context: context, title: logResponse['message'],);
        Get.toNamed(RoutesName.LOGIN);
      } else {
        print("RESET EMAIL ERROR : ${logResponse['message']}");
        showAppSnackBar(
          type: 'Error',
          context: context,
          title: logResponse['message'],
        );
      }
    } catch (e) {
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
      print("RESET EMAIL E : $e");
    }
  }

}