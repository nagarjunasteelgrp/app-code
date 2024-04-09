import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/main.dart';
import 'package:digital_lync/routes/routes_path.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
            child: Column(
              children: [
                Center(child: Image.asset(AppAssets.APP_LOGO, width: 56.w)),
                SizedBox(height: 2.h),
                Center(
                  child: AppText(
                    title: "Login to your account",
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    fontSize: 1.8.h,
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
                      Consumer<LoginProvider>(builder: (context, value, _) {
                        return appTextField(
                          controller: value.emailController,
                            context: context);
                      }),

                      SizedBox(height: 2.h),
                      AppText(
                        title: "Enter Your Password",
                        fontWeight: FontWeight.w500,
                        fontSize: 1.8.h,
                      ),
                      SizedBox(height: 1.h),
                      Consumer<LoginProvider>(builder: (context, value, _) {
                        return appTextField(
                          controller: value.passwordController,
                          context: context,
                          obscureText: value.obscureText,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              value.obscureTextChange();
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: value.obscureText
                                  ? const Icon(
                                      Icons.visibility,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                    ),
                            ),
                          ),
                        );
                      }),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<LoginProvider>(
                                builder: (context, value, child) {
                              return const CommonCheckbox(label: "Remember Me");
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.w),
                      Consumer<LoginProvider>(builder: (context, provider, _) {
                        return provider.isLoading ? const Center(child: SpinKitLoader()) : Center(
                          child: appButton(
                            width: 80.w,
                            child: AppText(
                                title: "Login",
                                fontSize: 2.h,
                                fontWeight: FontWeight.w700,
                                color:
                                    Theme.of(context).colorScheme.background),
                            context: context,
                            onTap: () {
                              provider.login(context);
                              // Get.toNamed(RoutesName.HOME);
                            },
                          ),
                        );
                      }),
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
