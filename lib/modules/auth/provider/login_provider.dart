import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
  bool isChecked = false;

  void toggleCheckbox() {
    isChecked = !isChecked;
    notifyListeners();
  }
}
