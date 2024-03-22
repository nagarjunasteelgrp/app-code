import 'package:digital_lync/constants/constants.dart';
import 'package:flutter/foundation.dart';

class MenuProvider extends ChangeNotifier {
  List menuList = [
    {'icon': '', 'title': Constants.contacts},
    {'icon': '', 'title': Constants.activities},
    {'icon': '', 'title': Constants.checkIn},
    {'icon': '', 'title': Constants.tracking},
    {'icon': '', 'title': Constants.menu},
  ];
}
