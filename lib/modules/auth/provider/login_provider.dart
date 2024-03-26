import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
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


}
