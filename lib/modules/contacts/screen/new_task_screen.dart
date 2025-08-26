import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/contacts/components/add_task_dailog_box.dart';
import 'package:digital_lync/modules/contacts/provider/new_task_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        leadingArrow: true,
        actions: const [],
        onTap: () {
          Get.back();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Consumer<NewTaskProvider>(
              builder: (context, value, _) {
                return GestureDetector(
                  onTap: () {
                    value.onShowTaskChange();
                  },
                  child: Row(
                    children: [
                      AppText(title: 'My Tasks', fontSize: 1.7.h),
                      Icon(
                        value.isShowTask == false
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        size: 4.h,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Consumer<NewTaskProvider>(builder: (context, value, _) {
            return value.isShowTask == true
                ? appDivider(context: context, vertical: 0.0)
                : const SizedBox();
          }),
          Consumer<NewTaskProvider>(builder: (context, value, _) {
            return value.isShowTask == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(value.taskList.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 0.5.h),
                                AppText(
                                    title: value.taskList[index],
                                    fontSize: 1.8.h),
                                SizedBox(height: 0.5.h),
                              ],
                            ),
                          ),
                          appDivider(context: context, vertical: 0.0),
                        ],
                      );
                    }),
                  )
                : const SizedBox();
          }),
          SizedBox(height: 2.h),
          appOutlineButton(
              onTap: () {
                showAddTaskDialog(context);
              },
              context: context,
              width: double.infinity,
              radius: 2.w,
              child: AppText(
                title: 'New Tasks',
                color: Theme.of(context).colorScheme.primary,
              )),
        ],
      ),
    );
  }
}
