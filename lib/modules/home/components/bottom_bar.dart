import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/check%20In/provider/checkin_provider.dart';
import 'package:digital_lync/modules/check%20In/screen/checkin_screen.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: checkInProvider,
      child: Consumer<HomeProvider>(
        builder: (context, value, _) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: BottomNavigationBar(
              elevation: 5.h,
              showUnselectedLabels: true,
              currentIndex: value.selectedIndex,
              key: ValueKey<int>(value.selectedIndex),
              backgroundColor: context.theme.primaryColor,
              selectedItemColor: context.theme.colorScheme.onError,
              unselectedItemColor: context.theme.colorScheme.secondary,
              onTap: (values) {
                value.setSelectedIndex(values, tabIndex: false);
              },
              items: [
                BottomNavigationBarItem(
                  icon: AnimatedScale(
                    scale: value.selectedIndex == 0 ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: SvgPicture.asset(
                      AppAssets.APP_DASHBOARD_SVG,
                      height: 3.h,
                      color: value.selectedIndex == 0
                          ? context.theme.colorScheme.onError
                          : context.theme.colorScheme.secondary,
                    ),
                  ),
                  label: Constants.dashboard,
                ),
                BottomNavigationBarItem(
                  icon: AnimatedScale(
                    scale: value.selectedIndex == 1 ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: SvgPicture.asset(
                      AppAssets.APP_CONTACTS_SVG,
                      height: 3.h,
                      color: value.selectedIndex == 1
                          ? context.theme.colorScheme.onError
                          : context.theme.colorScheme.secondary,
                    ),
                  ),
                  label: Constants.contacts,
                ),
                BottomNavigationBarItem(
                  icon: AnimatedScale(
                    scale: value.selectedIndex == 2 ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: SvgPicture.asset(
                      AppAssets.APP_ACTIVITIES_SVG,
                      height: 3.h,
                      color: value.selectedIndex == 2
                          ? context.theme.colorScheme.onError
                          : context.theme.colorScheme.secondary,
                    ),
                  ),
                  label: Constants.tasks,
                ),
                BottomNavigationBarItem(
                  icon: AnimatedScale(
                    scale: value.selectedIndex == 3 ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: checkInStatus
                        ? SvgPicture.asset(
                            AppAssets.APP_CHECKING_SVG,
                            height: 3.h,
                            color: value.selectedIndex == 3
                                ? context.theme.colorScheme.onError
                                : context.theme.colorScheme.secondary,
                          )
                        : Icon(
                            Icons.login,
                            color: value.selectedIndex == 3
                                ? context.theme.colorScheme.onError
                                : context.theme.colorScheme.secondary,
                          ),
                  ),
                  label: checkInStatus ? Constants.checkIn : Constants.checkOut,
                ),
                BottomNavigationBarItem(
                  icon: AnimatedScale(
                    scale: value.selectedIndex == 4 ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Image.asset(
                      AppAssets.MENU,
                      height: 3.h,
                      color: value.selectedIndex == 4
                          ? context.theme.colorScheme.onError
                          : context.theme.colorScheme.secondary,
                    ),
                  ),
                  label: Constants.menu,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
