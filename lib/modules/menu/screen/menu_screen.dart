import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/menu/components/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
appDivider(context: context , vertical: 1.4.h, colors: Theme.of(context).colorScheme.secondary.withOpacity(0.8)),
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: AppText(title: Constants.menu,fontWeight: FontWeight.w500,fontSize: 4.w,color: Theme.of(context).colorScheme.secondary),
        ),
          SizedBox(
            height: 0.6.h,
          ),
          appDivider(context: context ,vertical: 0.8.h, colors: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
          Padding(
            padding: EdgeInsets.only(left: 5.5.w, right: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.scale(
                        scale: 1.3, child: SvgPicture.asset(AppAssets.APP_PROFILE_SVG)),
                    SizedBox(
                      width: 3.0.w,
                    ),
                    AppText(
                      fontWeight: FontWeight.w600,
                      title: Constants.APP_NAME,
                      fontSize: 1.4.h,
                    )
                  ],
                ),
                Image.asset(
                  AppAssets.EDIT,
                  height: 2.5.h,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.8.h,
          ),
          appDivider(context: context ,vertical: 0.4.h, colors: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
          MenuTile(
            iconHeight: 3.5.h,
            icon: AppAssets.APP_CONTACTS_SVG,
            title: Constants.contacts,
            index: 0,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          SizedBox(
            height: 0.2.h,
          ),
          MenuTile(
            iconHeight: 3.5.h,
            icon: AppAssets.APP_ACTIVITIES_SVG,
            title: Constants.activities,
            index: 1,
            color: Theme.of(context).colorScheme.scrim,
          ),
          SizedBox(
            height: 0.2.h,
          ),
          MenuTile(
            iconHeight: 3.5.h,
            icon: AppAssets.APP_CHECKING_SVG,
            title: Constants.checkIn,
            index: 2,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          SizedBox(
            height: 0.2.h,
          ),
          MenuTile(
            iconHeight: 3.5.h,
            icon: AppAssets.APP_TRACKING_SVG,
            title: Constants.tracking,
            index: 3,
            color: Theme.of(context).colorScheme.error,
          ),
          SizedBox(
            height: 0.2.h,
          ),
          MenuTile(
            iconHeight: 3.5.h,
            icon: AppAssets.APP_DASHBOARD_SVG,
            title: Constants.dashboard,
            index: 3,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
