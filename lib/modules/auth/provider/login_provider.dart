import 'dart:convert';
import 'package:digital_lync/common/shared_prefs.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/cupertino.dart';
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
      if (logResponse.statusCode == 200) {
        var response = jsonDecode(logResponse.body);
        print("LOGIN SUCCESS : ${response['token']}");
        await sharedPrefers.saveTokenToPrefs(response['token']);
        showAppSnackBar(type: 'success', context: context, title: response['message']);
        emailController.clear();
        passwordController.clear();
        Get.toNamed(RoutesName.HOME);
      } else {
        var response = jsonDecode(logResponse.body);
        print("LOGIN ERROR : ${response['message']}");
        showAppSnackBar(type: 'Error', context: context, title: response['message']);
      }
    } catch (e) {
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
      print("LOGIN E : $e");
    }
  }

}
