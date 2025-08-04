import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/task/components/task_container_ui.dart';
import 'package:digital_lync/modules/task/components/task_status_dailog_box.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                      position: const RelativeRect.fromLTRB(100, 200, 20, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.h)),
                      items: [
                        PopupMenuItem(
                          onTap: () {
                            Future.delayed(Duration.zero, () {
                              provider.filterTasks('all');
                            });
                          },
                          value: 'All',
                          child: const Text('All'),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            Future.delayed(Duration.zero, () {
                              provider.filterTasks('assigned');
                            });
                          },
                          value: 'Assigned',
                          child: const Text('Assigned'),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            Future.delayed(Duration.zero, () {
                              provider.filterTasks('inprogress');
                            });
                          },
                          value: 'In Progress',
                          child: const Text('In Progress'),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            Future.delayed(Duration.zero, () {
                              provider.filterTasks('completed');
                            });
                          },
                          value: 'Completed',
                          child: const Text('Completed'),
                        ),
                      ],
                      elevation: 8.0,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 2.h, top: 1.h),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(
                          AppAssets.APP_FILTER_SVG,
                          color: Colors.black,
                        )),
                  ),
                ),
                Expanded(
                  child: provider.isLoading == false
                      ? provider.filteredTaskAPIResponse.isEmpty
                          ? Center(
                              child: AppText(
                              title: Constants.result_not_found,
                            ))
                          : SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: Consumer<TaskProvider>(
                                  builder: (context, value, child) {
                                    return Column(
                                      children: List.generate(
                                          value.filteredTaskAPIResponse.length,
                                          (index) {
                                        final dateTimeString =
                                            value.filteredTaskAPIResponse[index]
                                                ['createdAt'];
                                        final dateTime =
                                            DateTime.parse(dateTimeString);
                                        value.dateTime =
                                            DateFormat('dd-MM-yyyy hh:mm a')
                                                .format(dateTime.toLocal());
                                        return taskContainerUI(
                                          onTap: () {
                                            value.statusId =
                                                value.filteredTaskAPIResponse[
                                                    index]['id'];
                                            taskStatusDialogBox(
                                                context, value.statusId);
                                          },
                                          context,
                                          colors: value.filteredTaskAPIResponse[
                                                      index]['status'] ==
                                                  "assigned"
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .outline
                                                  .withOpacity(0.8)
                                              : value.filteredTaskAPIResponse[
                                                          index]['status'] ==
                                                      "completed"
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .onInverseSurface
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                          title: value.filteredTaskAPIResponse[
                                              index]['title'],
                                          description:
                                              value.filteredTaskAPIResponse[
                                                  index]['description'],
                                          type: value.filteredTaskAPIResponse[
                                              index]['titleType'],
                                          dateTime: value.dateTime,
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ),
                            )
                      : const Center(child: SpinKitLoader()),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
// : Center(child: SpinKitLoader())
