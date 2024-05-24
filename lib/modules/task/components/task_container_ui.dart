import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Widget taskContainerUI(BuildContext context, {String? type, String? title, String? description}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      height: 10.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1.4.h),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          appCircleIcon(
              context: context,
              colors: Theme.of(context).colorScheme.outline.withOpacity(0.5),
              radius: 5.h,
              height: 5.h,
              width: 5.h,
              child: SvgPicture.asset(
                type == 'Notification'
                    ? AppAssets.APP_NOTIFICATION_SVG
                    : type == 'Meeting'
                        ? AppAssets.APP_MEETING_SVG
                        : AppAssets.APP_TASK_ICON_SVG,
                color: Theme.of(context).primaryColor,
              )),
          SizedBox(
            width: 3.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  title: title,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary),
              SizedBox(height: 0.5.h),
              // AppText(title: description),
              Flexible(child: Text(description!, style: GoogleFonts.lato(fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.secondary))),
              SizedBox(height: 0.5.h),
              AppText(
                  title: '10:30 AM',
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary),
            ],
          ),
        ],
      ),
    ),
  );
}
