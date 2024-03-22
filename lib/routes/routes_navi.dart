import 'package:digital_lync/modules/auth/screen/login_screen.dart';
import 'package:digital_lync/modules/contacts/components/contact%20details/conatct_extra_details_screen.dart';
import 'package:digital_lync/modules/contacts/components/tracking/tracking_screen.dart';
import 'package:digital_lync/modules/home/home_screen.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:get/get.dart';

class RouteNavigation {
  static final routes = [
    GetPage(name: RoutesName.LOGIN, page: () => const LoginScreen()),
    GetPage(name: RoutesName.HOME, page: () => const HomeScreen()),
    GetPage(name: RoutesName.TRACKING, page: () => const TrackingScreen()),

  ];
}
