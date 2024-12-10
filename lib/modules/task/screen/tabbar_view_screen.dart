import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/modules/tracking/components/followup_dailog_box.dart';
import 'package:digital_lync/modules/task/components/message_dailog_box.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/modules/task/screen/follow_up_screen.dart';
import 'package:digital_lync/modules/task/screen/message_screen.dart';
import 'package:digital_lync/modules/task/screen/notification_screen.dart';
import 'package:digital_lync/modules/task/screen/task_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/global.dart';

class TabbarViewScreen extends StatelessWidget {
  TabbarViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: taskProvider,
      child: Consumer<TaskProvider>(
  builder: (context, provider, child) {
  return Scaffold(
        floatingActionButton: provider.currentIndex == 3 ? Container() : FloatingActionButton(
          onPressed: () {
           messageDialogBox(context, taskProvider!);
          },
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(AppAssets.APP_MESSAGE_SVG),
          ),
        ),
        body: DefaultTabController(
          length: 4,
          initialIndex: taskProvider!.currentIndex ?? 0,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 0.2.h, horizontal: 0.2.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    borderRadius: BorderRadius.circular(1.h)),
                child: ButtonsTabBar(
                  backgroundColor: Colors.white,
                  unselectedBackgroundColor: Colors.transparent,
                  labelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  onTap: (index){
                    taskProvider!.changeIndex(index);
                  },
                  tabs: [
                    Tab(
                      child: SizedBox(
                          width: 15.h,
                          child: Center(
                              child: AppText(
                            title: 'Tasks',
                            fontSize: 1.7.h,
                          ))),
                    ),
                    Tab(
                      child: SizedBox(
                          width: 15.h,
                          child: Center(
                              child: AppText(
                                  title: 'Announcements', fontSize: 1.7.h))),
                    ),
                    Tab(
                      child: SizedBox(
                          width: 15.h,
                          child: Center(
                              child:
                                  AppText(title: 'Message', fontSize: 1.7.h))),
                    ),
                    Tab(
                      child: SizedBox(
                          width: 15.h,
                          child: Center(
                              child: AppText(
                                  title: 'Follow Ups', fontSize: 1.7.h))),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    TaskScreen(),
                    NotificationScreen(),
                    MessageListScreen(),
                    FollowUpScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  },
),
    );
  }
}
