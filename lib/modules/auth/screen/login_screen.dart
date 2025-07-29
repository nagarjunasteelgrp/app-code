import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_dialog_for_background_permission.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfiled.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/auth/components/check_box.dart';
import 'package:digital_lync/modules/auth/provider/login_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      bool isDialogShown = prefs.getBool('isLocationDialogShown') ?? false;

      if (!isDialogShown) {
        showLocationDisclosureDialog(context);
        await prefs.setBool('isLocationDialogShown', true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LoginProvider(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
              child: Column(
                children: [
                  Center(child: Image.asset(AppAssets.APP_LOGO, width: 40.w)),
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
                              verticalPadding: 2.h,
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
                            verticalPadding: 2.0.h,
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
                          child: Consumer<LoginProvider>(
                              builder: (context, value, child) {
                            return const CommonCheckbox(label: "Remember Me");
                          }),
                        ),
                        SizedBox(height: 1.w),
                        Consumer<LoginProvider>(
                            builder: (context, provider, _) {
                          return provider.isLoading
                              ? const Center(child: SpinKitLoader())
                              : Center(
                                  child: appButton(
                                    width: double.infinity,
                                    child: AppText(
                                        title: "Login",
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                    context: context,
                                    onTap: () {
                                      provider.login(context);
                                      // Get.toNamed(RoutesName.HOME);
                                    },
                                  ),
                                );
                        }),
                        SizedBox(height: 1.5.h),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                "By clicking login, you agree to our terms learn How we process your data in our ",
                            style: const TextStyle(
                              color: AppColors.tooLightBlackColor,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: "Privacy Policy",
                                style: const TextStyle(
                                  color: AppColors.blueColor,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await launchUrl(
                                      Uri.parse(
                                          'https://www.nagarjunasteel.com/privacy-policy'),
                                    );
                                  },
                              ),
                            ],
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
      ),
    );
  }
}
