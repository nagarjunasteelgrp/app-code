import 'package:background_location/background_location.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/routes/routes_navi.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:digital_lync/services/provider_services.dart';
import 'package:digital_lync/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void main() async {
 WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
 BackgroundLocation.startLocationService();
  BackgroundLocation.setAndroidNotification(
   title: "Background Nagarjuna Steel",
   message: "App is up and running",
   icon: "@mipmap/ic_launcher",
 );
 FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
 SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
   statusBarColor: Colors.transparent,
 ));
 SystemChrome.setPreferredOrientations([
   DeviceOrientation.portraitUp,
 ]);
 FlutterNativeSplash.remove();
  runApp(MultiProvider(providers: providers,
    child: const MyApp()));
}
const notificationChannelId = 'my_foreground';
  const notificationId = 10181;


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool? isLogin;

  @override
  void initState() {
    getToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CurrentLocationProvider>(context, listen: false).getUserLocation();
    });
    super.initState();
  }

 getToken() async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
     isLogin = preferences.getBool("isLogin") ?? false;
   print("TOKENS...........MAIN FILE $isLogin");
 }

  @override
  Widget build(BuildContext context) {
    getToken();
    print("TOKEN IN BUILD ... $isLogin");
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          navigatorKey: Get.key,
          debugShowCheckedModeBanner: false,
          title: Constants.APP_NAME,
          themeMode: ThemeMode.light,
          theme: ThemeServices.getLightTheme(),
          initialRoute: isLogin == true ? RoutesName.HOME : RoutesName.LOGIN,
          getPages: RouteNavigation.routes,
        );
      },
    );
  }
}
