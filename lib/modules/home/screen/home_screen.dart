import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/constants/app_logout.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/auth/provider/login_provider.dart';
import 'package:digital_lync/modules/check%20In/screen/checkIn_screen.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:digital_lync/modules/contacts/screen/conatct_screen.dart';
import 'package:digital_lync/modules/home/components/bottom_bar.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:digital_lync/modules/menu/screen/menu_screen.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: HomeProvider(),
      child: Scaffold(
        appBar: CommonAppBar(
          title:  username != null ? '${empId} (${username.toString()})': '',
          elevation: Provider.of<HomeProvider>(context).selectedIndex == 3 ? 0 : 1,
          leadingArrow: Provider.of<HomeProvider>(context).selectedIndex == 0 ?
          Provider.of<ContactProvider>(context).isSelected ? false : true : false,
          onTap: (){
            Provider.of<ContactProvider>(context,listen: false).toggleSelected(true);
          },
          onTapLogo: () async {
            checkInProvider.checkInStatus ? null : checkInProvider.checkOutAPI();
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            bool isConfirmed = await AppDialog.showDialog(context,
                title: 'Logout', message: 'Are you sure you want to logout?');
            if (isConfirmed) {
              Provider.of<LoginProvider>(context, listen: false).emailController.clear();
              Provider.of<LoginProvider>(context, listen: false).passwordController.clear();
              sharedPreferences.clear();
              Get.offNamed(RoutesName.LOGIN);
            }
          },
        ),
        body: Consumer<HomeProvider>(builder: (context, value, _) {
          return value.selectedIndex == 3
              ? const MenuScreen()
              : value.selectedIndex == 0
              ? const ContactScreen()
              : value.selectedIndex == 2 ? const CheckInScreen()
          // : value.selectedIndex == 1 ? const ActivitiesScreen()
              : const SizedBox();
        }),
        bottomNavigationBar: const AppBottomBar(),
      ),
    );
  }
}