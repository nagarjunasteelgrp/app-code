import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_exit_pop.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/check%20In/provider/checkIn_provider.dart';
import 'package:digital_lync/modules/check%20In/screen/checkIn_screen.dart';
import 'package:digital_lync/modules/menu/components/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider.value(
          value: checkInProvider,
          child: Consumer<CheckInProvider>(
            builder: (context, provider, _) {
              return Column(
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
                  appDivider(context: context ,vertical: 0.4.h, colors: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
                  MenuTile(
                    iconHeight: 3.5.h,
                    icon: AppAssets.APP_CONTACTS_SVG,
                    title: Constants.contacts,
                    index: 1,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  MenuTile(
                    iconHeight: 3.5.h,
                    icon: AppAssets.APP_CHECKING_SVG,
              // Icon(Icons.login
                    title: checkInStatus? Constants.checkIn : Constants.checkOut,
                    index: 3,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  MenuTile(
                    iconHeight: 3.5.h,
                    icon: AppAssets.APP_ACTIVITIES_SVG,
                    title: Constants.tasks,
                    index: 2,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  MenuTile(
                    iconHeight: 3.5.h,
                    icon: AppAssets.APP_DASHBOARD_SVG,
                    title: Constants.dashboard,
                    index: 0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              );
            }
          ),
        ),
      );

  }
}
