import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/modules/task/screen/notification_screen.dart';
import 'package:digital_lync/modules/task/screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


class TabbarViewScreen extends StatelessWidget {
  const TabbarViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TaskProvider(),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            SizedBox(height: 1.5.h,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.2.h, horizontal: 0.2.h),
              decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
                borderRadius: BorderRadius.circular(1.h)
              ),
              child: ButtonsTabBar(
                backgroundColor: Colors.white,
                unselectedBackgroundColor: Colors.transparent,
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(child: Container(
                      width: 15.h,
                      child: Center(child: AppText(title: 'Tasks',fontSize: 1.7.h,))),),
                  Tab(child: Container(
                      width: 15.h,
                      child: Center(child: AppText(title: 'Notifications',fontSize: 1.7.h))),),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  TaskScreen(),
                  NotificationScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}