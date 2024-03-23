import 'package:flutter/foundation.dart';

class ContactProvider extends ChangeNotifier{

    bool isSelected = true;

     toggleSelected(bool value) {
        isSelected = value;
        notifyListeners();
    }


}