import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sizer/sizer.dart';

void showAddTaskDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 5,
        insetAnimationCurve: Curves.bounceIn,
        backgroundColor: context.theme.colorScheme.surface,
        insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
                    spacing: 4.w,
                    children: [
                      appCircleIcon(
                        context: context,
                        colors: context.theme.colorScheme.error,
                        radius: 0.5.h,
                        height: 6.w,
                        width: 6.w,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            AppAssets.APP_NEW_TASK_SVG,
                            colorFilter: ColorFilter.mode(
                                context.theme.primaryColor, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      AppText(title: 'New Tasks', fontSize: 2.h),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 2.h),
                    onPressed: () => Navigator.pop(context),
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
                      fontSize: 1.5.h,
                      title: "Subject",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  appDivider(
                    vertical: 1.0,
                    context: context,
                    colors: context.theme.colorScheme.onSecondaryFixed,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppText(
                          title: "Name",
                          fontSize: 1.5.h,
                          fontWeight: FontWeight.w400,
                          color: context.theme.colorScheme.onSecondary,
                        ),
                        SizedBox(height: 0.5.h),
                        appTextField(context: context),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: "Related to",
                            fontWeight: FontWeight.w400,
                            color: context.theme.colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextField(context: context),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: "Due Date",
                            fontWeight: FontWeight.w400,
                            color: context.theme.colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextField(context: context),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: "Assigned to*",
                            fontWeight: FontWeight.w400,
                            color: context.theme.colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextField(context: context),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: "Status",
                            fontWeight: FontWeight.w400,
                            color: context.theme.colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextField(
                          context: context,
                          suffixIcon: Icon(
                              size: 3.h, Icons.keyboard_arrow_down_rounded),
                        ),
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
                      fontWeight: FontWeight.w600,
                      color: context.theme.colorScheme.surface,
                    ),
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
