import 'package:digital_lync/modules/auth/screen/login_screen.dart';
import 'package:digital_lync/modules/auth/screen/reset_email_screen.dart';
import 'package:digital_lync/modules/activities/screen/activities_screen.dart';
import 'package:digital_lync/modules/contacts/screen/contact_list_screen.dart';
import 'package:digital_lync/modules/contacts/screen/details/conatct_details_screen.dart';
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
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.HOME,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.CONTACTS_LIST,
      page: () => const ContactListScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.CONTACT_DETAILS,
      page: () => const ContactDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.TRACKING,
      page: () => const TrackingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.NEW_TASK,
      page: () => const NewTaskScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.RESET_EMAIL,
      page: () => const ResetEmailScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.RELATED_CONTACT,
      page: () => const RelatedContactScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RoutesName.ACTIVITIES,
      page: () => const ActivitiesScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
