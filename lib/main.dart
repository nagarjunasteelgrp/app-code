import 'dart:async';
import 'dart:ui';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/routes/routes_navi.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/provider_services.dart';
import 'package:digital_lync/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


void main() async {

 WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
 await initializeService();
 FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
 SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
   statusBarColor: Colors.transparent,
 ));
 SystemChrome.setPreferredOrientations([
   DeviceOrientation.portraitUp,
 ]);
 await Future.delayed(const Duration(seconds: 2));
 FlutterNativeSplash.remove();
  runApp(MultiProvider(providers: providers,
    child: const MyApp()));
}
const notificationChannelId = 'my_foreground';
  const notificationId = 10181;


Future<void> initializeService() async {
  getHeaders();
  personalDetails();
  final service = FlutterBackgroundService();
  service.isRunning();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'MY FOREGROUND SERVICE',
    description:
    'App is up and running',
    importance: Importance.low,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await service.configure(iosConfiguration: IosConfiguration(
      autoStart: true,
    onForeground: onStart,
      ),
      androidConfiguration: AndroidConfiguration(
        autoStart: true,
        isForegroundMode: true,
        onStart: onStart,
        notificationChannelId: notificationChannelId,
        initialNotificationTitle: 'Nagarjuna Steel',
        initialNotificationContent: 'App is up and running',
        foregroundServiceNotificationId: notificationId,
      ),
  );
}


@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  DartPluginRegistrant.ensureInitialized();
  Timer.periodic(const Duration(hours: 2), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        getHeaders();
        personalDetails();
        // flutterLocalNotificationsPlugin.show(
        //   notificationId, 'COOL SERVICE', 'Awesome ${DateTime.now()}',
        //   const NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       notificationChannelId,
        //       'MY FOREGROUND SERVICE',
        //       icon: 'ic_bg_service_small',
        //       ongoing: true,
        //       importance: Importance.high,
        //     ),
        //   ),
        // );
        // print("ON START CALLED................5");
        //
      }
    }
  });
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getHeaders();
    personalDetails();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CurrentLocationProvider>(context, listen: false).getUserLocation();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          navigatorKey: Get.key,
          debugShowCheckedModeBanner: false,
          title: Constants.APP_NAME,
          themeMode: ThemeMode.light,
          theme: ThemeServices.getLightTheme(),
          initialRoute:
          token != null ? RoutesName.HOME :
          RoutesName.LOGIN,
          getPages: RouteNavigation.routes,
        );
      },
    );
  }
}
