import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void showLogOutDialog(BuildContext context,
    {VoidCallback? onTapSave}) {
  showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: trackingProvider,
          child: Dialog(insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              elevation: 5,
              insetAnimationCurve: Curves.bounceIn,
              backgroundColor: Theme.of(context).colorScheme.background,
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  AppText(title: "Are you sure you want to logout?"),
                  SizedBox(height: 2.h),
                  appButton(context: context,child: AppText(title: 'Log Out',color: Theme.of(context).colorScheme.background,),
                  height: 4.5.h,
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.remove('token');
                      Get.toNamed(RoutesName.LOGIN);
                    },
                  ),
                ],),
              )
          ),
        );
      });
}
