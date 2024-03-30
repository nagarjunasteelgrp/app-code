import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/modules/check%20In/screen/checkIn_screen.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:digital_lync/modules/contacts/screen/activities/activities_screen.dart';
import 'package:digital_lync/modules/contacts/screen/conatct_screen.dart';
import 'package:digital_lync/modules/home/components/bottom_bar.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:digital_lync/modules/menu/screen/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CommonAppBar(
        elevation: Provider.of<HomeProvider>(context).selectedIndex == 4 ? 0 : 1,
        leadingArrow: Provider.of<HomeProvider>(context).selectedIndex == 0 ?
        Provider.of<ContactProvider>(context).isSelected ? false : true : false,
        onTap: (){
         Provider.of<ContactProvider>(context,listen: false).toggleSelected(true);
        },
      ),
      body: Consumer<HomeProvider>(builder: (context, value, _) {
        return value.selectedIndex == 4
            ? const MenuScreen()
            : value.selectedIndex == 0
                ? const ContactScreen()
                : value.selectedIndex == 2 ? const CheckInScreen() : value.selectedIndex == 1 ? const ActivitiesScreen() : const SizedBox();
      }),
      bottomNavigationBar: const AppBottomBar(),
    );
  }
}
