import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/modules/task/components/task_container_ui.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TaskProvider(),
      child: Scaffold(
        body: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            return provider.isLoading == false
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Consumer<TaskProvider>(
                        builder: (context, value, child) {
                          return Column(
                            children: List.generate(
                                value.taskAPIResponse.length, (index) {
                              final dateTimeString =
                                  value.taskAPIResponse[index]['createdAt'];
                              final dateTime = DateTime.parse(dateTimeString);
                              value.dateTime = DateFormat('dd-MM-yyyy hh:mm a')
                                  .format(dateTime);

                              return taskContainerUI(
                                context,
                                title: value.taskAPIResponse[index]['title'],
                                description: value.taskAPIResponse[index]
                                    ['description'],
                                type: value.taskAPIResponse[index]['titleType'],
                                dateTime: value.dateTime,
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  )
                : Center(child: SpinKitLoader());
          },
        ),
      ),
    );
  }
}
// : Center(child: SpinKitLoader())
