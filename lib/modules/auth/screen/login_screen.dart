import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/dailog_box.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_textfiled.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/modules/auth/components/check_box.dart';
import 'package:digital_lync/modules/auth/provider/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
            child: Column(
              children: [
                Center(child: Image.asset(AppAssets.APP_LOGO, width: 56.w)),
                SizedBox(height: 2.h),
                Center(
                  child: AppText(
                    title: "Login to your account",
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ),
                appDivider(context: context),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 2.h),
                      AppText(
                        title: "Enter Your Email or Mobile Number",
                        fontWeight: FontWeight.w500,
                        fontSize: 1.8.h,
                      ),
                      SizedBox(height: 1.h),
                      appTextfield(context: context),
                      SizedBox(height: 2.h),
                      AppText(
                        title: "Enter Your Password",
                        fontWeight: FontWeight.w500,
                        fontSize: 1.8.h,
                      ),
                      SizedBox(height: 1.h),
                      appTextfield(context: context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<LoginProvider>(
                              builder: (context, value, child) {
                                return const CommonCheckbox(label: "Remember Me");
                              }),
                          TextButton(
                            onPressed: () {},
                            child: AppText(
                                title: "Recover Password",
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface),
                          )
                        ],
                      ),
                      SizedBox(height: 5.w),
                      Center(
                        child: appButton(
                          width: 80.w,
                          child: AppText(
                              title: "Login",
                              fontSize: 2.5.h,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.background),
                          context: context,
                          onTap: () {
                            Get.toNamed(RoutesName.HOME);
                            // showContactDialog(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
