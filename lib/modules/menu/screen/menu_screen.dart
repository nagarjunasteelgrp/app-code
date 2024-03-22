import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/menu/components/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 1.h, left: 2.5.w),
          height: 5.h,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).colorScheme.onBackground,
                    offset: const Offset(0, 2),
                    blurRadius: 5)
              ]),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: AppText(
              title: Constants.menu,
              fontWeight: FontWeight.w500,
              fontSize: 1.8.h,
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        Container(
            height: 8.h,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).colorScheme.onBackground,
                      offset: const Offset(0, 1),
                      blurRadius: 5)
                ]),
            child: Padding(
              padding: EdgeInsets.only(left: 2.w, right: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(AppAssets.LOGO),
                      SizedBox(
                        width: 2.w,
                      ),
                      AppText(
                        fontWeight: FontWeight.w600,
                        title: Constants.APP_NAME,
                        fontSize: 1.4.h,
                        isPoppins: true,
                      )
                    ],
                  ),
                  Image.asset(
                    AppAssets.EDIT,
                    height: 2.5.h,
                  ),
                ],
              ),
            )),
        SizedBox(
          height: 0.2.h,
        ),
        MenuTile(
          icon: AppAssets.CONTACTS,
          title: Constants.contacts,
          index: 0,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        SizedBox(
          height: 0.2.h,
        ),
        MenuTile(
          icon: AppAssets.ACRIVITIES,
          title: Constants.activities,
          index: 1,
          color: Theme.of(context).colorScheme.scrim,
        ),
        SizedBox(
          height: 0.2.h,
        ),
        MenuTile(
          iconHeight: 3.h,
          icon: AppAssets.CHEACK_IN_2,
          title: Constants.checkIn,
          index: 2,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        SizedBox(
          height: 0.2.h,
        ),
        MenuTile(
          icon: AppAssets.TRACKING_2,
          title: Constants.tracking,
          index: 3,
          color: Theme.of(context).colorScheme.error,
        ),
        SizedBox(
          height: 0.2.h,
        ),
        MenuTile(
          iconHeight: 3.h,
          icon: AppAssets.DASHBOARD,
          title: Constants.dashboard,
          index: 3,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
