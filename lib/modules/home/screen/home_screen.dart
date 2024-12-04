import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_exit_pop.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/constants/app_logout.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/auth/provider/login_provider.dart';
import 'package:digital_lync/modules/check%20In/screen/checkIn_screen.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:digital_lync/modules/contacts/screen/conatct_screen.dart';
import 'package:digital_lync/modules/dashboard/screen/dashboard_screen.dart';
import 'package:digital_lync/modules/home/components/bottom_bar.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:digital_lync/modules/menu/screen/menu_screen.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/modules/task/screen/tabbar_view_screen.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: ChangeNotifierProvider(
        create: (BuildContext context) => HomeProvider(),
        child: ChangeNotifierProvider.value(
        value: HomeProvider(),
        child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
        return Scaffold(
          appBar: CommonAppBar(
            // title:  username != null ? '${empId} (${username.toString()})': '',
            title:  username != null ? username.toString(): '',
            elevation: provider.selectedIndex == 3 ? 0 : 1,
            leadingArrow: provider.selectedIndex == 0 ?
            Provider.of<ContactProvider>(context).isSelected ? false : true : false,
            onTap: (){
              Provider.of<ContactProvider>(context,listen: false).toggleSelected(true);
            },
            onTapLogo: () async {
              // checkInProvider.checkInStatus ? null : checkInProvider.checkOutAPI();
      bool isConfirmed = await AppDialog.showDialog(context,provider,
      title: 'Logout', message: 'Are you sure you want to logout?');
      if (isConfirmed) {
        Provider.of<HomeProvider>(context, listen: false).prefsClear(context);
      Provider.of<LoginProvider>(context, listen: false).emailController.clear();
                Provider.of<LoginProvider>(context, listen: false).passwordController.clear();
                Get.offNamed(RoutesName.LOGIN);
              }
            },
            actions: [
              GestureDetector(
                  onTap: () {
                     provider.setSelectedIndex(2,tabIndex: true); // Pass index 3
                  },
                  child: Icon(Icons.notifications_none,color: AppColors.BLACK_COLOR)),
              SizedBox(width: 2.w),
            ],
          ),
          body: Consumer<HomeProvider>(builder: (context, value, _) {
            contactProvider.selectContactIndex(-1);
            contactProvider.contactId = null;
            return value.selectedIndex == 4
                ? const MenuScreen()
                : value.selectedIndex == 1
                ? const ContactScreen()
                : value.selectedIndex == 3 ? const CheckInScreen()
            : value.selectedIndex == 0 ? const DashBoardScreen()
                : value.selectedIndex == 2 ? TabbarViewScreen() : const SizedBox();
          }),
          bottomNavigationBar: const AppBottomBar(),
        );
        },
      ),
      ),
      ),
    );
  }
}