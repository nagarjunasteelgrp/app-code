import 'dart:convert';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isChecked = false;
  bool obscureText = true;

  ApiServices apiServices = ApiServices();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void toggleCheckbox() {
    isChecked = !isChecked;
    notifyListeners();
  }

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
      await apiServices
          .login(
        email: emailController.text.trim().replaceAll(RegExp(r'\s+'), ''),
        password: passwordController.text,
      )
          .then((value) async {
        isLoading = false;
        notifyListeners();
        var response = jsonDecode(value.body);

        if (value.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLogin', true);
          prefs.setString('token', response['token']);
          prefs.setInt('userId', response['userInfo']['userId']);
          prefs.setString('role', response['userInfo']['role'].toString());
          prefs.setString('email', response['userInfo']['email'].toString());
          prefs.setString('empId', response['userInfo']['empId'].toString());
          prefs.setString('mobile', response['userInfo']['mobile'].toString());
          prefs.setString('empmId', response['userInfo']['empmId'].toString());
          prefs.setString('slpCode', response['userInfo']['slpId'].toString());
          prefs.setString(
              'username', response['userInfo']['username'].toString());
          prefs.setString('profilePicture',
              response['userInfo']['profilePicture'].toString());
          if (context.mounted) {
            showAppSnackBar(
              type: 'success',
              context: context,
              title: response['message'],
            );
          }
          await personalDetails();
          await getHeaders();
          isReachedOut = false;

          final homeProvider =
              Provider.of<HomeProvider>(context, listen: false);
          homeProvider.refreshProfilePicture();

          Get.offNamed(RoutesName.HOME);
          notifyListeners();
        } else {
          showAppSnackBar(
              type: 'Error', context: context, title: response['message']);
        }
      });
    } catch (e) {
      isLoading = false;
      print('-catch error--${e.toString()}');
      notifyListeners();
    }
  }
}
