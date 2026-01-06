import 'dart:convert';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/helper/shared_prefs_helper.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/api/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

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
      showAppSnackBar(title: 'Please enter your username.');
      return;
    }
    if (password.isEmpty) {
      showAppSnackBar(title: 'Please enter your password.');
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
          await SharedPrefsHelper.setBool('isLogin', true);
          await SharedPrefsHelper.setString('token', response['token']);
          await SharedPrefsHelper.setInt(
              'userId', response['userInfo']['userId']);
          await SharedPrefsHelper.setString(
              'role', response['userInfo']['role'].toString());
          await SharedPrefsHelper.setString(
              'email', response['userInfo']['email'].toString());
          await SharedPrefsHelper.setString(
              'empId', response['userInfo']['empId'].toString());
          await SharedPrefsHelper.setString(
              'mobile', response['userInfo']['mobile'].toString());
          await SharedPrefsHelper.setString(
              'empmId', response['userInfo']['empmId'].toString());
          await SharedPrefsHelper.setString(
              'slpCode', response['userInfo']['slpId'].toString());
          await SharedPrefsHelper.setString(
              'username', response['userInfo']['username'].toString());
          await SharedPrefsHelper.setString(
            'profilePicture',
            response['userInfo']['profilePicture'].toString(),
          );
          showAppSnackBar(type: 'success', title: response['message']);
          await personalDetails();
          await getHeaders();
          isReachedOut = false;
          final homeProvider =
              Provider.of<HomeProvider>(context, listen: false);
          homeProvider.refreshProfilePicture();
          Get.offNamed(RoutesName.HOME);
          // --- START SERVICE LOGIC ---
          if (token != '') {
            await WakelockPlus.enable();
            await FlutterBackground.hasPermissions;

            // 1. Set Flag
            await SharedPrefsHelper.setBool('isService', true);

            // 2. Initialize
            await initializeService(isService: Future.value());

            // 3. Manually Start Service
            final service = FlutterBackgroundService();
            if (!await service.isRunning()) {
              service.startService();
            }

            notifyListeners();
          }
        } else {
          showAppSnackBar(type: 'Error', title: response['message']);
        }
      });
    } catch (e) {
      isLoading = false;
      print('-catch error--${e.toString()}');
      notifyListeners();
    }
  }
}
