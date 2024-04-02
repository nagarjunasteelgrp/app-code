import 'package:digital_lync/modules/auth/screen/login_screen.dart';
import 'package:digital_lync/modules/auth/screen/reset_email_screen.dart';
import 'package:digital_lync/modules/activities/screen/activities_screen.dart';
import 'package:digital_lync/modules/contacts/screen/contact_list_screen.dart';
import 'package:digital_lync/modules/contacts/screen/details/conatct_details_screen.dart';
import 'package:digital_lync/modules/contacts/screen/new_task_screen.dart';
import 'package:digital_lync/modules/contacts/screen/related%20contacts/related_contact_screen.dart';
import 'package:digital_lync/modules/contacts/screen/tracking/tracking_screen.dart';
import 'package:digital_lync/modules/home/screen/home_screen.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:get/get.dart';

class RouteNavigation {
  static final routes = [
    GetPage(name: RoutesName.LOGIN, page: () => const LoginScreen()),
    GetPage(name: RoutesName.HOME, page: () => const HomeScreen()),
    GetPage(name: RoutesName.CONTACTS_LIST, page: () => const ContactListScreen()),
    GetPage(name: RoutesName.CONTACT_DETAILS, page: () => const ContactDetailsScreen()),
    GetPage(name: RoutesName.TRACKING, page: () => const TrackingContactScreen()),
    GetPage(name: RoutesName.NEW_TASK, page: () => const NewTaskScreen()),
    GetPage(name: RoutesName.RESET_EMAIL, page: () => const ResetEmailScreen()),
    GetPage(name: RoutesName.RELATED_CONTACT, page: () => const RelatedContactScreen()),
    GetPage(name: RoutesName.ACTIVITIES, page: () => const ActivitiesScreen()),
  ];
}
