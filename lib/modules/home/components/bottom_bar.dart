import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/check%20In/provider/checkIn_provider.dart';
import 'package:digital_lync/modules/check%20In/screen/checkIn_screen.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: checkInProvider,
      child: Consumer<CheckInProvider>(
        builder: (context, provider, _) {
          return Consumer<HomeProvider>(
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
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedItemColor: Theme.of(context).colorScheme.onError,
                  unselectedItemColor: Theme.of(context).colorScheme.secondary,
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
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.secondary,
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
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.secondary,
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
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.secondary,
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
                                    ? Theme.of(context).colorScheme.onError
                                    : Theme.of(context).colorScheme.secondary,
                              )
                            : Icon(
                                Icons.login,
                                color: value.selectedIndex == 3
                                    ? Theme.of(context).colorScheme.onError
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                      ),
                      label: checkInStatus
                          ? Constants.checkIn
                          : Constants.checkOut,
                    ),
                    BottomNavigationBarItem(
                      icon: AnimatedScale(
                        scale: value.selectedIndex == 4 ? 1.2 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Image.asset(
                          AppAssets.MENU,
                          height: 3.h,
                          color: value.selectedIndex == 4
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      label: Constants.menu,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
