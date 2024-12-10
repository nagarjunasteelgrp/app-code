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
          print("LOGIN SUCCESS :1 ${response['token']}");
         prefs.setString('token', response['token']);
          prefs.setInt('userId', response['userInfo']['userId']);
          prefs.setString('email', response['userInfo']['email'].toString());
          prefs.setString('mobile', response['userInfo']['mobile'].toString());
          prefs.setString('username', response['userInfo']['username'].toString());
          prefs.setString('empId', response['userInfo']['empId'].toString());
          prefs.setString('role', response['userInfo']['role'].toString());
          prefs.setBool('isLogin', true);
          prefs.setString('profilePicture', response['userInfo']['profilePicture'].toString());
          print("LOGIN SUCCESS :2 ${response['token']}");
          followUpsForNotificationFetching();
          showAppSnackBar(type: 'success', context: context, title: response['message']);
          await personalDetails();
          print("LOGIN SUCCESS :3 ${response['token']}");
          await getHeaders();
          print("LOGIN SUCCESS :4 ${response['token']}");
          await (followUpsDateList!.isNotEmpty) ?
            await showNotification(
              'Remainder',
              'The followups scheduled with ${followUpsDateList![0]['dealerName']} will be reminded today',
            ) : null;

          BackgroundLocation.startLocationService();
          print("LOGIN SUCCESS :5 ${response['token']}");
          Get.offNamed(RoutesName.HOME);
          notifyListeners();
        } else {
          print("LOGIN SUCCESS :6 ${response['token']}");
          showAppSnackBar(type: 'Error', context: context, title: response['message']);
        }
      });

    } catch (e) {
      print("LOGIN SUCCESS :7 ${e.toString()}");
      isLoading = false;
      notifyListeners();
      showAppSnackBar(context: context, title: 'Error', subtitle: e.toString());
    }
  }

}
