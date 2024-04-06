import 'dart:convert';
import 'package:digital_lync/common/shared_prefs.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  SharedPrefers sharedPrefers = SharedPrefers();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
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
      isLoading = true;
      notifyListeners();
      var logResponse = await apiServices.login(email: emailController.text, password: passwordController.text);
      if (logResponse.statusCode == 200) {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        print("LOGIN SUCCESS : ${response['token']}");
        print("LOGIN SUCCESS : ${response['userInfo']['userId']}");
        await sharedPrefers.saveTokenToPrefs(response['token']);
        await sharedPrefers.saveUserIdPrefs(response['userInfo']['userId']);
        await sharedPrefers.saveUserEmailPrefs(response['userInfo']['email'].toString());
        await sharedPrefers.saveUserPhoneNoPrefs(response['userInfo']['mobile'].toString());
        await sharedPrefers.saveUserUsernamePrefs(response['userInfo']['username'].toString());
        await sharedPrefers.saveUserUsernamePrefs(response['userInfo']['empId'].toString());
        await sharedPrefers.saveUserUsernamePrefs(response['userInfo']['role'].toString());
        showAppSnackBar(type: 'success', context: context, title: response['message']);
        personalDetails();
        emailController.clear();
        passwordController.clear();
        Get.toNamed(RoutesName.HOME);
      } else {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(logResponse.body);
        print("LOGIN ERROR : ${response['message']}");
        showAppSnackBar(type: 'Error', context: context, title: response['message']);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
      print("LOGIN E : $e");
    }
  }

}
