import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/check%20in/screen/checkin_screen.dart';
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
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: ValueListenableBuilder<bool>(
              valueListenable: checkInStatus,
              builder: (context, checkInStatusValue, child) {
                return BottomNavigationBar(
                  elevation: 5.h,
                  showUnselectedLabels: true,
                  currentIndex: value.selectedIndex,
                  key: ValueKey<int>(value.selectedIndex),
                  backgroundColor: context.theme.primaryColor,
                  selectedItemColor: context.theme.colorScheme.onError,
                  unselectedItemColor: context.theme.colorScheme.secondary,
                  onTap: (values) =>
                      value.setSelectedIndex(values, tabIndex: false),
                  items: [
                    BottomNavigationBarItem(
                      label: Constants.dashboard,
                      icon: AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: value.selectedIndex == 0 ? 1.2 : 1.0,
                        child: SvgPicture.asset(
                          height: 3.h,
                          AppAssets.APP_DASHBOARD_SVG,
                          colorFilter: value.selectedIndex == 0
                              ? ColorFilter.mode(
                                  context.theme.colorScheme.onError,
                                  BlendMode.srcIn)
                              : ColorFilter.mode(
                                  context.theme.colorScheme.secondary,
                                  BlendMode.srcIn),
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: Constants.contacts,
                      icon: AnimatedScale(
                        scale: value.selectedIndex == 1 ? 1.2 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: SvgPicture.asset(
                          height: 3.h,
                          AppAssets.APP_CONTACTS_SVG,
                          colorFilter: ColorFilter.mode(
                              value.selectedIndex == 1
                                  ? context.theme.colorScheme.onError
                                  : context.theme.colorScheme.secondary,
                              BlendMode.srcIn),
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: Constants.tasks,
                      icon: AnimatedScale(
                        scale: value.selectedIndex == 2 ? 1.2 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: SvgPicture.asset(
                          height: 3.h,
                          AppAssets.APP_ACTIVITIES_SVG,
                          colorFilter: ColorFilter.mode(
                              value.selectedIndex == 2
                                  ? context.theme.colorScheme.onError
                                  : context.theme.colorScheme.secondary,
                              BlendMode.srcIn),
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: checkInStatusValue
                          ? Constants.checkIn
                          : Constants.checkOut,
                      icon: AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: value.selectedIndex == 3 ? 1.2 : 1.0,
                        child: checkInStatusValue
                            ? SvgPicture.asset(
                                height: 3.h,
                                AppAssets.APP_CHECKING_SVG,
                                colorFilter: value.selectedIndex == 3
                                    ? ColorFilter.mode(
                                        context.theme.colorScheme.onError,
                                        BlendMode.srcIn)
                                    : ColorFilter.mode(
                                        context.theme.colorScheme.secondary,
                                        BlendMode.srcIn),
                              )
                            : Icon(
                                Icons.login,
                                color: value.selectedIndex == 3
                                    ? context.theme.colorScheme.onError
                                    : context.theme.colorScheme.secondary,
                              ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: Constants.menu,
                      icon: AnimatedScale(
                        scale: value.selectedIndex == 4 ? 1.2 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.menu,
                          size: 3.h,
                          color: value.selectedIndex == 4
                              ? context.theme.colorScheme.onError
                              : context.theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
