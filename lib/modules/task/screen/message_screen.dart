import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MessageListScreen extends StatelessWidget {
  final ScrollController? scrollController;
  const MessageListScreen({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: taskProvider,
      child: Scaffold(
        body: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            return provider.isLoading == false
                ? provider.messageFetchingAPIResponse.isNotEmpty
                    ? Column(
                        spacing: 2.h,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              itemCount:
                                  provider.messageFetchingAPIResponse.length +
                                      1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 1.h,
                                      horizontal: 1.h,
                                    ),
                                    child: Table(
                                      border: TableBorder.all(
                                        width: 1,
                                        color: context
                                            .theme.colorScheme.onSecondary,
                                      ),
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(3),
                                      },
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(
                                            color: context
                                                .theme.colorScheme.onSecondary
                                                .withValues(alpha: 0.1),
                                          ),
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(2.w),
                                              child: const AppText(
                                                title: 'Date',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(2.w),
                                              child: const AppText(
                                                title: 'Message',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                // Data rows
                                final dataIndex = index - 1;
                                DateTime dateTime = DateTime.parse(provider
                                        .messageFetchingAPIResponse[dataIndex]
                                    ['createdAt']);
                                String formattedDate =
                                    DateFormat('dd/MM/yyyy').format(dateTime);

                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 1.h,
                                    horizontal: 1.h,
                                  ),
                                  child: Table(
                                    border: TableBorder.all(
                                      width: 1,
                                      color:
                                          context.theme.colorScheme.onSecondary,
                                    ),
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(3),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(2.w),
                                            child:
                                                AppText(title: formattedDate),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(2.w),
                                            child: AppText(
                                              maxLines: 5,
                                              title: provider
                                                      .messageFetchingAPIResponse[
                                                  dataIndex]['message'],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: AppText(title: Constants.result_not_found),
                      )
                : SpinKitLoader();
          },
        ),
      ),
    );
  }
}
