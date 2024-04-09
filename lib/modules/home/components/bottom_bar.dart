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
                return BottomNavigationBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 5.h,
                    currentIndex: value.selectedIndex,
                    showUnselectedLabels: true,
                    selectedItemColor: Theme.of(context).colorScheme.onError,
                    unselectedItemColor: Theme.of(context).colorScheme.secondary,
                    onTap: (values) {
                      value.setSelectedIndex(values);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          AppAssets.APP_CONTACTS_SVG,
                          height: 3.h,
                          color: value.selectedIndex == 0
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.secondary,
                        ),
                        label: Constants.contacts,
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          AppAssets.APP_ACTIVITIES_SVG,
                          height: 3.h,
                          color: value.selectedIndex == 1
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.secondary,
                        ),
                        label: Constants.tasks,
                      ),
                      BottomNavigationBarItem(
                        icon:  provider.checkInStatus ?SvgPicture.asset(
                          height: 3.h,
                          color: value.selectedIndex == 2
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.secondary,
                          AppAssets.APP_CHECKING_SVG,
                        ) : Icon(Icons.login , color: value.selectedIndex == 2
                            ? Theme.of(context).colorScheme.onError
                            : Theme.of(context).colorScheme.secondary),
                        label: provider.checkInStatus ? Constants.checkIn : Constants.checkOut,
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          color: value.selectedIndex == 3
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
        )
      );
  }
}
