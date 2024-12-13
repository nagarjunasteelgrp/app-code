import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/task/components/confirmation_for_status.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FollowUpScreen extends StatefulWidget {
  const FollowUpScreen({super.key});

  @override
  State<FollowUpScreen> createState() => _FollowUpScreenState();
}

class _FollowUpScreenState extends State<FollowUpScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: taskProvider,
      child: Scaffold(
          body: taskProvider!.isLoading == true
              ? const Center(child: SpinKitLoader())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: AppText(
                          title: Constants.filter,
                          fontSize: 2.h,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Consumer<TaskProvider>(
                              builder: (context, provider, child) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1.h),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.3))),
                                  child: DropdownButton<String>(
                                    value: provider.selectedDateFilter,
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    isDense: true,
                                    items: provider.dateFilters
                                        .map((filter) => DropdownMenuItem(
                                              value: filter,
                                              child: AppText(
                                                title: filter.capitalize!,
                                                fontSize: 2.h,
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        provider.updateDateFilter(value);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 2.w),
                          // Status Filter Dropdown
                          Expanded(
                            child: Consumer<TaskProvider>(
                              builder: (context, provider, child) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1.h),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.3))),
                                  child: DropdownButton<String>(
                                    value: provider.selectedStatusFilter,
                                    underline: const SizedBox(),
                                    padding: EdgeInsets.zero,
                                    isDense: true,
                                    isExpanded: true,
                                    items: provider.statusFilters
                                        .map((filter) => DropdownMenuItem(
                                              value: filter,
                                              child: AppText(
                                                title: filter.capitalize!,
                                                fontSize: 2.h,
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        provider.updateStatusFilter(value);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Consumer<TaskProvider>(
                          builder: (context, provider, child) {
                            return Column(
                                children: List.generate(
                                    provider.followUpsAPIResponse.length,
                                    (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.2.h, horizontal: 4.w),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          AppText(
                                            title: 'Dealer Name: ',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 1.7.h,
                                          ),
                                          AppText(
                                            fontSize: 1.7.h,
                                            title: provider
                                                    .followUpsAPIResponse[index]
                                                ['dealerName'],
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary)),
                                            child: AppText(
                                              title:
                                                  provider.followUpsAPIResponse[
                                                      index]["status"],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 1.h),
                                      Row(
                                        children: [
                                          AppText(
                                            title: 'FollowUps Date: ',
                                            fontSize: 1.7.h,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          AppText(
                                            fontSize: 1.7.h,
                                            title: provider.formatDate(
                                              provider.followUpsAPIResponse[
                                                  index]['followUpDate'],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 1.4.h),
                                      Row(
                                        children: [
                                          AppText(
                                            title: 'Created Date: ',
                                            fontSize: 1.7.h,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          AppText(
                                            fontSize: 1.7.h,
                                            title: provider.formatDateWithTime(
                                              provider.followUpsAPIResponse[
                                                  index]['createdAt'],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 1.4.h),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            title: 'Notes: ',
                                            fontSize: 1.7.h,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          Flexible(
                                            child: AppText(
                                              fontSize: 1.7.h,
                                              title:
                                                  provider.followUpsAPIResponse[
                                                      index]['notes'],
                                              maxLines: 2,
                                              // Optional: Limits the text to 2 lines
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 2.h),
                                      (provider.followUpsAPIResponse[index]
                                                      ['status'] ==
                                                  "done" ||
                                              DateTime.parse(provider
                                                          .followUpsAPIResponse[
                                                      index]['followUpDate'])
                                                  .isAfter(DateTime.now()))
                                          ? const SizedBox()
                                          : appButton(
                                              context: context,
                                              onTap: () {
                                                provider.followUpId = provider
                                                        .followUpsAPIResponse[
                                                    index]['id'];
                                                confirmationDialogBox(
                                                    context, provider);
                                              },
                                              width: double.infinity,
                                              height: 5.5.h,
                                              radius: 1.h,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  AppText(
                                                    title: 'Done',
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                  ),
                                                ],
                                              )),
                                    ],
                                  ),
                                ),
                              );
                            }));
                          },
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }
}
