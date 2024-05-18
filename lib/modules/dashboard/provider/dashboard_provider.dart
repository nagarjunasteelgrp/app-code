
import 'package:flutter/widgets.dart';

class DashboardProvider extends ChangeNotifier{

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List myProgressList = [
    'TODAY',
    'THIS WEEK',
    'THIS MONTH',
    'THIS YEAR',
  ];


  String? selectedValue;

  DashboardProvider() {
    selectedValue = dropDown.first;
  }

  List dropDown = [
    'TODAY',
    'WEEK',
    'MONTH',
    'YEAR',
  ];

  dropDownSelectedValue (newValue) {
    selectedValue = newValue;
    notifyListeners();
  }

}