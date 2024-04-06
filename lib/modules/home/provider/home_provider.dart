import 'package:digital_lync/constants/global.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier{

  int selectedIndex = 3;

   void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  HomeProvider(){

  }


}