import 'package:digital_lync/modules/auth/provider/login_provider.dart';
import 'package:digital_lync/modules/auth/provider/reset_email_provider.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:digital_lync/modules/contacts/provider/new_task_provider.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:digital_lync/modules/menu/provider/menu_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => LoginProvider()),
  ChangeNotifierProvider(create: (context) => HomeProvider()),
  ChangeNotifierProvider(create: (context) => MenuProvider()),
  ChangeNotifierProvider(create: (context) => ContactProvider()),
  ChangeNotifierProvider(create: (context) => NewTaskProvider()),
  ChangeNotifierProvider(create: (context) => ResetEmailProvider()),
];
