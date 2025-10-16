import 'package:digital_lync/modules/activities/provider/activities_provider.dart';
import 'package:digital_lync/modules/auth/provider/login_provider.dart';
import 'package:digital_lync/modules/auth/provider/reset_email_provider.dart';
import 'package:digital_lync/modules/check%20In/provider/checkin_provider.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:digital_lync/modules/contacts/provider/contacts_details_provider.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/contacts/provider/new_task_provider.dart';
import 'package:digital_lync/modules/contacts/provider/releated_contacts_provider.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:digital_lync/modules/menu/provider/menu_provider.dart';
import 'package:digital_lync/modules/notification/provider/notification_provider.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => MenuProvider()),
  ChangeNotifierProvider(create: (context) => HomeProvider()),
  ChangeNotifierProvider(create: (context) => TaskProvider()),
  ChangeNotifierProvider(create: (context) => LoginProvider()),
  ChangeNotifierProvider(create: (context) => ContactProvider()),
  ChangeNotifierProvider(create: (context) => NewTaskProvider()),
  ChangeNotifierProvider(create: (context) => CheckInProvider()),
  ChangeNotifierProvider(create: (context) => DashboardProvider()),
  ChangeNotifierProvider(create: (context) => ActivitiesProvider()),
  ChangeNotifierProvider(create: (context) => ResetEmailProvider()),
  ChangeNotifierProvider(create: (context) => NotificationProvider()),
  ChangeNotifierProvider(create: (context) => RelatedContactProvider()),
  ChangeNotifierProvider(create: (context) => ContactDetailsProvider()),
  ChangeNotifierProvider(create: (context) => CurrentLocationProvider()),
  ChangeNotifierProvider(
      create: (context) => TrackingProvider(CurrentLocationProvider())),
];
