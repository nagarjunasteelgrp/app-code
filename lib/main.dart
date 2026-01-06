import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/core/provider_services.dart';
import 'package:digital_lync/helper/shared_prefs_helper.dart';
import 'package:digital_lync/routes/routes_navi.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/app_permissions.dart';
import 'package:digital_lync/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();

  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings('ic_notification_white'),
    ),
  );
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterNativeSplash.remove();

  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<bool> getToken() async {
    bool isLogin = SharedPrefsHelper.getBool("isLogin") ?? false;
    return isLogin;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          bool isLogin = snapshot.data ?? false;
          return Sizer(
            builder: (context, orientation, deviceType) {
              return GetMaterialApp(
                navigatorKey: Get.key,
                title: Constants.APP_NAME,
                themeMode: ThemeMode.light,
                getPages: RouteNavigation.routes,
                debugShowCheckedModeBanner: false,
                theme: ThemeServices.getLightTheme(),
                initialRoute: isLogin ? RoutesName.HOME : RoutesName.LOGIN,
                onReady: () async => await AppPermissions.checkAndShowDialog(),
              );
            },
          );
        }
      },
    );
  }
}
