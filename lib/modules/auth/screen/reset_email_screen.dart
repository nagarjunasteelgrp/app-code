import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/modules/auth/provider/reset_email_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/app_assets.dart';

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
                    title: "Reset your email",
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
                        title: "Enter Your Email",
                        fontWeight: FontWeight.w500,
                        fontSize: 1.8.h,
                      ),
                      SizedBox(height: 1.h),
                      Consumer<ResetEmailProvider>(
                          builder: (context, value, _) {
                        return appTextField(
                            controller: value.resetEmailController,
                            context: context);
                      }),

                      SizedBox(height: 2.h),
                      Consumer<ResetEmailProvider>(
                          builder: (context, provider, _) {
                        return Center(
                          child: appButton(
                            width: 80.w,
                            child: AppText(
                                title: "Reset",
                                fontSize: 2.h,
                                fontWeight: FontWeight.w700,
                                color:
                                    Theme.of(context).colorScheme.background),
                            context: context,
                            onTap: () {
                              provider.resetEmail(context);
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
