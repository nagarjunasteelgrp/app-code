

import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfiled.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

void showContactDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        elevation: 5,
        insetAnimationCurve: Curves.bounceIn,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 4.w),
                      appCircleIcon(
                        context: context,
                        colors: Theme.of(context).colorScheme.primary,
                        radius: 0.5.h,
                        height: 6.w,
                        width: 6.w,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(AppAssets.APP_CREATE_SVG,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      AppText(
                        title: 'Create Contact',

                        fontSize: 2.h,isPoppins: true,),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,
                        size: 2.h),
                  )
                ],
              ),
              appDivider(context: context,vertical: 0.h),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                        title: "Company Name",
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: "Pearson Name",
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: "Contact",
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: "Phone Number",
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: "Email",
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: "Address",
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: "Tax ID",
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: "Additional Info",
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context),
                  ],
                ),
              ),
              appDivider(context: context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Center(
                  child: appButton(
                    width: double.infinity,
                    height: 4.h,
                    context: context,
                    radius: 1.w,
                    child: AppText(
                        title: "Create",
                        fontSize: 1.5.h,
                        isPoppins: true,
                        color: Theme.of(context)
                            .colorScheme
                            .background,
                        fontWeight:
                        FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      );
    },
  );
}
