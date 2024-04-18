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
     print("TOKEN....................$token");
     if(token != '' && token != null) {
    await initializeService();
    notifyListeners();
     }
  }

  prefsClear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print('SharedPrefs Instance: $sharedPreferences'); // Check if sharedPreferences instance is correctly obtained
    await sharedPreferences.remove("isLoginIn");
    await sharedPreferences.clear();
    print('SharedPreferences Cleared');
    notifyListeners();
  }


}