import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/task/components/message_dialog_box.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/modules/task/screen/follow_up_screen.dart';
import 'package:digital_lync/modules/task/screen/message_screen.dart';
import 'package:digital_lync/modules/task/screen/announcement_screen.dart';
import 'package:digital_lync/modules/task/screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TabBarViewScreen extends StatefulWidget {
  const TabBarViewScreen({super.key});

  @override
  State<TabBarViewScreen> createState() => _TabBarViewScreenState();
}

class _TabBarViewScreenState extends State<TabBarViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  static final ScrollController scrollController = ScrollController();
  static final ValueNotifier<bool> isScrolling = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    tabController = TabController(
        length: 4, vsync: this, initialIndex: taskProvider?.currentIndex ?? 0);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        taskProvider?.changeIndex(tabController.index);
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.isScrollingNotifier.value) {
        isScrolling.value = true;
      } else {
        Future.delayed(Duration(milliseconds: 200), () {
          isScrolling.value = false;
        });
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: taskProvider,
      child: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Column(
              children: [
                SizedBox(height: 1.5.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.2.h,
                    horizontal: 0.2.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.h),
                    color: context.theme.colorScheme.onSecondaryContainer,
                  ),
                  child: ButtonsTabBar(
                    controller: tabController,
                    backgroundColor: AppColors.WHITE_COLOR,
                    onTap: (index) => provider.changeIndex(index),
                    unselectedBackgroundColor: AppColors.lightGreyColor,
                    tabs: [
                      Tab(
                        child: SizedBox(
                          width: 15.h,
                          child: Center(
                            child: AppText(title: 'Tasks', fontSize: 1.7.h),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: 15.h,
                          child: Center(
                            child: AppText(
                                title: 'Announcements', fontSize: 1.7.h),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: 15.h,
                          child: Center(
                            child: AppText(title: 'Message', fontSize: 1.7.h),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: 15.h,
                          child: Center(
                            child:
                                AppText(title: 'Follow Ups', fontSize: 1.7.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      TaskScreen(),
                      AnnouncementScreen(),
                      MessageListScreen(scrollController: scrollController),
                      FollowUpScreen(),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: (provider.currentIndex == 2)
                ? ValueListenableBuilder<bool>(
                    valueListenable: isScrolling,
                    builder: (context, scrolling, child) {
                      return FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () => messageDialogBox(context, provider),
                        child: SvgPicture.asset(
                            height: 3.h, width: 3.w, AppAssets.APP_MESSAGE_SVG),
                      );
                    },
                  )
                : SizedBox(),
          );
        },
      ),
    );
  }
}
