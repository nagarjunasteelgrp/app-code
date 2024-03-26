import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, _) {
        return BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 3.h,
            currentIndex: value.selectedIndex,
            showUnselectedLabels: true,
            selectedItemColor: Theme.of(context).colorScheme.onError,
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
            onTap: (values) {
              value.setSelectedIndex(values);
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.CONTACTS,
                  height: 3.h,
                  color: value.selectedIndex == 0
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).colorScheme.secondary,
                ),
                label: Constants.contacts,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.ACRIVITIES,
                  height: 3.h,
                  color: value.selectedIndex == 1
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).colorScheme.secondary,
                ),
                label: Constants.activities,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  height: 3.h,
                  color: value.selectedIndex == 2
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).colorScheme.secondary,
                  AppAssets.CHEACK_IN,
                ),
                label: Constants.checkIn,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  height: 3.h,
                  color: value.selectedIndex == 3
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).colorScheme.secondary,
                  AppAssets.TRACKING,
                ),
                label: Constants.tracking,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  color: value.selectedIndex == 4
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).colorScheme.secondary,
                  AppAssets.MENU,
                  height: 3.h,
                ),
                label: Constants.menu,
              ),
            ]);
      },
    );
  }
}
