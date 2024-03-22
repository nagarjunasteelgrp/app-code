import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier{

  int selectedIndex = 4;

   void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}