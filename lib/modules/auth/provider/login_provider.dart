import 'package:digital_lync/common/shared_prefs.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/validation.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LoginProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  SharedPrefers sharedPrefers = SharedPrefers();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isChecked = false;

  void toggleCheckbox() {
    isChecked = !isChecked;
    notifyListeners();
  }

  bool obscureText = true;

  void obscureTextChange() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    print("Email:- ${emailController.text}");
    print("Password:- ${passwordController.text}");

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your username.');
      return;
    }
    if (password.isEmpty) {
      showAppSnackBar(context: context, title: 'Please enter your password.');
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
  }

}
