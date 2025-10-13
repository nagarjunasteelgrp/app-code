import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/modules/auth/provider/reset_email_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ResetEmailScreen extends StatelessWidget {
  const ResetEmailScreen({super.key});

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
                    fontSize: 1.8.h,
                    title: "Reset your email",
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                appDivider(context: context),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        fontSize: 1.8.h,
                        title: "Enter Your Email",
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 1.h),
                      Consumer<ResetEmailProvider>(
                        builder: (context, value, _) {
                          return appTextField(
                            context: context,
                            controller: value.resetEmailController,
                          );
                        },
                      ),
                      SizedBox(height: 2.h),
                      Consumer<ResetEmailProvider>(
                          builder: (context, provider, _) {
                        return Center(
                          child: appButton(
                            width: 80.w,
                            context: context,
                            onTap: () => provider.resetEmail(context),
                            child: AppText(
                              title: "Reset",
                              fontSize: 2.h,
                              fontWeight: FontWeight.w700,
                              color: context.theme.colorScheme.background,
                            ),
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
