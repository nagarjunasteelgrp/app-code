import 'dart:convert';
import 'package:background_location/background_location.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();

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
       await apiServices.login(email: emailController.text, password: passwordController.text).then((value)async{
         isLoading = false;
         notifyListeners();
        var response = jsonDecode(value.body);
        if (value.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print("LOGIN SUCCESS : ${response['token']}");
         prefs.setString('token', response['token']);
          prefs.setInt('userId', response['userInfo']['userId']);
          prefs.setString('email', response['userInfo']['email'].toString());
          prefs.setString('mobile', response['userInfo']['mobile'].toString());
          prefs.setString('username', response['userInfo']['username'].toString());
          prefs.setString('empId', response['userInfo']['empId'].toString());
          prefs.setString('role', response['userInfo']['role'].toString());
          prefs.setBool('isLogin', true);
          showAppSnackBar(type: 'success', context: context, title: response['message']);
          await personalDetails();
          await getHeaders();
          BackgroundLocation.startLocationService();
          notifyListeners();
          Get.offNamed(RoutesName.HOME);
        } else {
          showAppSnackBar(type: 'Error', context: context, title: response['message']);
        }
      });

    } catch (e) {
      isLoading = false;
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
    }
  }

}
