import 'package:flutter/material.dart';

class NewTaskProvider extends ChangeNotifier {
  bool isShowTask = false;

  List taskList = ['My Tasks', 'Today'];

  onShowTaskChange() {
    isShowTask = !isShowTask;
    notifyListeners();
  }
}
