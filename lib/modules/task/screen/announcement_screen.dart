import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/task/components/task_container_ui.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TaskProvider(),
      child: Scaffold(
        body: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            return provider.isLoading == false
                ? provider.notificationAPIResponse.isEmpty
                    ? const Center(
                        child: AppText(title: Constants.result_not_found),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Consumer<TaskProvider>(
                            builder: (context, value, child) {
                              return Column(
                                children: [
                                  Column(
                                    children: List.generate(
                                      value.notificationAPIResponse.length,
                                      (index) {
                                        final dateTimeString =
                                            value.notificationAPIResponse[index]
                                                ['createdAt'];
                                        final dateTime =
                                            DateTime.parse(dateTimeString);
                                        value.dateTime =
                                            DateFormat('dd-MM-yyyy hh:mm a')
                                                .format(dateTime.toLocal());
                                        return taskContainerUI(
                                          context,
                                          onTap: () {},
                                          colors: context
                                              .theme.colorScheme.outline
                                              .withValues(alpha: 0.8),
                                          title: value.notificationAPIResponse[
                                              index]['title'],
                                          description:
                                              value.notificationAPIResponse[
                                                  index]['description'],
                                          type: value.notificationAPIResponse[
                                              index]['titleType'],
                                          dateTime: value.dateTime,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                : const Center(child: SpinKitLoader());
          },
        ),
      ),
    );
  }
}
