import 'package:digital_lync/constants/global.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier{

  int selectedIndex = 3;

   void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  HomeProvider(){
    initState();
    personalDetails();
    getHeaders();
    notifyListeners();
  }

  initState() async {
     if(token != '') {
    await initializeService(true);
    notifyListeners();
     }
  }

  prefsClear(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = "";
    await initializeService(false);
    print("SharedPreferences Cleared........................${sharedPreferences.getString('token')}");
   await initState();
    notifyListeners();
  }


}