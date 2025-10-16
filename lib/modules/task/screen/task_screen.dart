import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/task/components/task_container_ui.dart';
import 'package:digital_lync/modules/task/components/task_status_dialog_box.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: taskProvider,
      child: Scaffold(
        body: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showMenu(
                      context: context,
                      elevation: 8.0,
                      position: const RelativeRect.fromLTRB(100, 200, 20, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.h),
                      ),
                      items: [
                        PopupMenuItem(
                          value: 'All',
                          child: const AppText(title: 'All'),
                          onTap: () => Future.delayed(
                              Duration.zero, () => provider.filterTasks('all')),
                        ),
                        PopupMenuItem(
                          value: 'Assigned',
                          child: const AppText(title: 'Assigned'),
                          onTap: () => Future.delayed(Duration.zero,
                              () => provider.filterTasks('assigned')),
                        ),
                        PopupMenuItem(
                          value: 'In Progress',
                          child: const AppText(title: 'In Progress'),
                          onTap: () => Future.delayed(Duration.zero,
                              () => provider.filterTasks('inprogress')),
                        ),
                        PopupMenuItem(
                          value: 'Completed',
                          child: const AppText(title: 'Completed'),
                          onTap: () => Future.delayed(Duration.zero,
                              () => provider.filterTasks('completed')),
                        ),
                      ],
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 2.w, top: 1.h),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(
                          AppAssets.APP_FILTER_SVG,
                          colorFilter:
                              ColorFilter.mode(Colors.black, BlendMode.srcIn),
                        )),
                  ),
                ),
                Expanded(
                  child: provider.isLoading == false
                      ? provider.filteredTaskAPIResponse.isEmpty
                          ? const Center(
                              child: AppText(title: Constants.result_not_found),
                            )
                          : Consumer<TaskProvider>(
                              builder: (context, value, child) {
                                return ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  itemCount:
                                      value.filteredTaskAPIResponse.length,
                                  itemBuilder: (context, index) {
                                    final dateTimeString =
                                        value.filteredTaskAPIResponse[index]
                                            ['createdAt'];
                                    final dateTime =
                                        DateTime.parse(dateTimeString);
                                    value.dateTime =
                                        DateFormat('dd-MM-yyyy hh:mm a')
                                            .format(dateTime.toLocal());
                                    return taskContainerUI(
                                      context,
                                      onTap: () {
                                        value.statusId =
                                            value.filteredTaskAPIResponse[index]
                                                ['id'];
                                        taskStatusDialogBox(
                                            context, value.statusId);
                                      },
                                      colors: value.filteredTaskAPIResponse[
                                                  index]['status'] ==
                                              "assigned"
                                          ? context.theme.colorScheme.outline
                                              .withValues(alpha: 0.8)
                                          : value.filteredTaskAPIResponse[index]
                                                      ['status'] ==
                                                  "completed"
                                              ? context.theme.colorScheme
                                                  .onInverseSurface
                                              : context.theme.colorScheme
                                                  .onSurfaceVariant,
                                      title:
                                          value.filteredTaskAPIResponse[index]
                                              ['title'],
                                      description:
                                          value.filteredTaskAPIResponse[index]
                                              ['description'],
                                      type: value.filteredTaskAPIResponse[index]
                                          ['titleType'],
                                      dateTime: value.dateTime,
                                    );
                                  },
                                );
                              },
                            )
                      : SpinKitLoader(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
