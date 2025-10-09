import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget contactTopBar({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          spacing: 0.7.h,
          children: [
            appCircleIcon(
                context: context,
                colors: Theme.of(context).colorScheme.inversePrimary,
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.APP_POST_SVG,
                    color: Theme.of(context).primaryColor,
                  ),
                )),
            const AppText(
              title: Constants.post,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
        Column(
          spacing: 0.7.h,
          children: [
            appCircleIcon(
                context: context,
                colors: Theme.of(context).colorScheme.scrim,
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.APP_FILE_SVG,
                    color: Theme.of(context).primaryColor,
                  ),
                )),
            const AppText(
              title: Constants.file,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
        Column(
          spacing: 0.7.h,
          children: [
            appCircleIcon(
                onTap: () {
                  Get.toNamed(RoutesName.NEW_TASK);
                },
                context: context,
                colors: Theme.of(context).colorScheme.error,
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.APP_ACTIVITIES_SVG,
                    color: Theme.of(context).primaryColor,
                  ),
                )),
            const AppText(
              title: Constants.new_Tasks,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
        Column(
          spacing: 0.7.h,
          children: [
            appCircleIcon(
              context: context,
              colors: Theme.of(context).colorScheme.onPrimary,
              child: Center(
                child: Icon(Icons.more_horiz_outlined,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            const AppText(
              title: Constants.more,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ],
    ),
  );
}
