import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Widget taskContainerUI(
  BuildContext context, {
  String? type,
  String? title,
  dynamic dateTime,
  String? description,
  required Color colors,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 10.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.4.h),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 1),
              color: Colors.grey.withValues(alpha: 0.5),
            ),
          ],
        ),
        child: Row(
          spacing: 3.w,
          children: [
            appCircleIcon(
              width: 5.h,
              height: 5.h,
              radius: 5.h,
              colors: colors,
              context: context,
              child: SvgPicture.asset(
                type == 'Notification'
                    ? AppAssets.APP_NOTIFICATION_SVG
                    : type == 'Meeting'
                        ? AppAssets.APP_MEETING_SVG
                        : AppAssets.APP_TASK_ICON_SVG,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: title,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    description!,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  AppText(
                    title: dateTime,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
