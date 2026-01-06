import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/auth/provider/login_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LoginProvider(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
              child: Column(
                children: [
                  Center(child: Image.asset(AppAssets.APP_LOGO, width: 40.w)),
                  SizedBox(height: 2.h),
                  Center(
                    child: AppText(
                      fontSize: 1.8.h,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      title: "Login to your account",
                    ),
                  ),
                  appDivider(context: context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        fontSize: 1.8.h,
                        fontWeight: FontWeight.w500,
                        title: "Enter Your Email or Mobile Number",
                      ),
                      SizedBox(height: 1.h),
                      Consumer<LoginProvider>(
                        builder: (context, value, _) {
                          return appTextField(
                            context: context,
                            verticalPadding: 2.h,
                            controller: value.emailController,
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                      SizedBox(height: 2.h),
                      AppText(
                        fontSize: 1.8.h,
                        fontWeight: FontWeight.w500,
                        title: "Enter Your Password",
                      ),
                      SizedBox(height: 1.h),
                      Consumer<LoginProvider>(builder: (context, value, _) {
                        return appTextField(
                          context: context,
                          verticalPadding: 2.0.h,
                          obscureText: value.obscureText,
                          controller: value.passwordController,
                          textInputAction: TextInputAction.done,
                          suffixIcon: GestureDetector(
                            onTap: () => value.obscureTextChange(),
                            child: value.obscureText
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        );
                      }),
                      Consumer<LoginProvider>(
                        builder: (context, value, child) {
                          return CheckboxListTile.adaptive(
                            value: value.isChecked,
                            contentPadding: EdgeInsets.zero,
                            title: const AppText(title: "Remember Me"),
                            onChanged: (values) => value.toggleCheckbox(),
                            activeColor: context.theme.colorScheme.primary,
                            checkColor: context.theme.colorScheme.surface,
                            controlAffinity: ListTileControlAffinity.leading,
                            checkboxShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(3),
                              ),
                            ),
                          );
                        },
                      ),
                      Consumer<LoginProvider>(
                        builder: (context, provider, _) {
                          return provider.isLoading
                              ? const Center(child: SpinKitLoader())
                              : Center(
                                  child: appButton(
                                    context: context,
                                    width: double.infinity,
                                    onTap: () => provider.login(context),
                                    child: AppText(
                                      title: "Login",
                                      fontSize: 2.h,
                                      fontWeight: FontWeight.w700,
                                      color: context.theme.colorScheme.surface,
                                    ),
                                  ),
                                );
                        },
                      ),
                      SizedBox(height: 1.5.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              "By clicking login, you agree to our terms learn How we process your data in our ",
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.tooLightBlackColor,
                          ),
                          children: [
                            TextSpan(
                              text: "Privacy Policy",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.blueColor,
                                decoration: TextDecoration.underline,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
