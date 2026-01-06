import 'package:digital_lync/modules/activities/screen/activities_screen.dart';
import 'package:digital_lync/modules/auth/screen/login_screen.dart';
import 'package:digital_lync/modules/contacts/screen/contact_list_screen.dart';
import 'package:digital_lync/modules/contacts/screen/details/contact_details_screen.dart';
import 'package:digital_lync/modules/contacts/screen/new_task_screen.dart';
import 'package:digital_lync/modules/contacts/screen/related%20contacts/related_contact_screen.dart';
import 'package:digital_lync/modules/home/screen/home_screen.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:get/get.dart';

class RouteNavigation {
  static final routes = [
    GetPage(
      name: RoutesName.LOGIN,
      transition: Transition.fadeIn,
      page: () => const LoginScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.HOME,
      transition: Transition.fadeIn,
      page: () => const HomeScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: RoutesName.CONTACTS_LIST,
      page: () => const ContactListScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: RoutesName.CONTACT_DETAILS,
      page: () => const ContactDetailsScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.TRACKING,
      transition: Transition.fadeIn,
      page: () => const TrackingScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.NEW_TASK,
      transition: Transition.fadeIn,
      page: () => const NewTaskScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: RoutesName.RELATED_CONTACT,
      page: () => const RelatedContactScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.ACTIVITIES,
      transition: Transition.fadeIn,
      page: () => const ActivitiesScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
