import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
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
                        children: [
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 3.w),
                                  child: AppText(
                                    title: 'Date',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: AppText(
                                  title: 'Message',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  provider.messageFetchingAPIResponse.length,
                                  (index) {
                                    DateTime dateTime = DateTime.parse(provider
                                            .messageFetchingAPIResponse[index]
                                        ['createdAt']);
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(dateTime);
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0.h, vertical: 1.h),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 1.h, vertical: 1.h),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary),
                                        borderRadius:
                                            BorderRadius.circular(2.w),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                            .withOpacity(0.05),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child:
                                                  AppText(title: formattedDate),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: AppText(
                                              title: provider
                                                      .messageFetchingAPIResponse[
                                                  index]['message'],
                                              maxLines: 5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(child: AppText(title: Constants.result_not_found))
                : const Center(child: SpinKitLoader());
          },
        ),
      ),
    );
  }
}
