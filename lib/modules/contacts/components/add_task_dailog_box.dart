import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfiled.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

void showAddTaskDialog(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 4.w),
                      appCircleIcon(
                        context: context,
                        colors: Theme.of(context).colorScheme.error,
                        radius: 0.5.h,
                        height: 6.w,
                        width: 6.w,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(AppAssets.APP_NEW_TASK_SVG,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      AppText(title: 'New Tasks', fontSize: 2.h),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, size: 2.h),
                  )
                ],
              ),
              appDivider(context: context, vertical: 0.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: AppText(
                        title: "Subject",
                        fontWeight: FontWeight.w400,
                        fontSize: 1.5.h),
                  ),
                  appDivider(
                      vertical: 1.0,
                      context: context,
                      colors: Theme.of(context).colorScheme.onBackground),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppText(
                            title: "Name",
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextField(context: context),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: "Related to",
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextField(context: context),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: "Due Date",
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextField(context: context),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: "Assigned to*",
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextField(context: context),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: "Status",
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextField(
                            context: context,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 3.h,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              appDivider(context: context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Center(
                  child: appButton(
                    width: double.infinity,
                    height: 5.h,
                    context: context,
                    radius: 1.w,
                    child: AppText(
                        title: "Save",
                        fontSize: 1.5.h,
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.w600),
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
