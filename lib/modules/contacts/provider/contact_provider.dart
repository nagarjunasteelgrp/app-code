import 'package:flutter/foundation.dart';

class ContactProvider extends ChangeNotifier{

    bool isDetails = false;
    bool isSelected = true;

     toggleSelected(bool value) {
        isSelected = value;
        notifyListeners();
    }

    toggleDetails(bool value) {
      isDetails = value;
        notifyListeners();
    }

}