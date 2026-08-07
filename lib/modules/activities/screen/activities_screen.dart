import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/activities/provider/activities_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ActivitiesProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                spacing: 3.w,
                children: [
                  appCircleIcon( 
                    width: 8.w,
                    height: 8.w,
                    radius: 0.5.h,
                    context: context,
                    colors: context.theme.colorScheme.scrim,
                    child: SvgPicture.asset(
                      AppAssets.APP_ACTIVITIES_SVG,
                      colorFilter: ColorFilter.mode(
                        context.theme.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  AppText(
                    fontSize: 1.8.h,
                    title: Constants.activities,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            Expanded(
              child: provider.isLoading
                  ? const Center(child: SpinKitLoader())
                  : provider.taskList.isEmpty
                      ? const Center(
                          child: AppText(title: Constants.result_not_found),
                        )
                      : ListView.builder(
                          itemCount: provider.taskList.length,
                          itemBuilder: (context, index) {
                            final task = provider.taskList[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Row(
                                    spacing: 5.w,
                                    children: [
                                      Column(
                                        spacing: 1.0.h,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            fontSize: 1.6.h,
                                            title: '${Constants.subject} :',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          AppText(
                                            title: '${Constants.due_Date} :',
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          AppText(
                                            title: '${Constants.priority} :',
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          AppText(
                                            title: '${Constants.owner} :',
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 2.h),
                                        child: Column(
                                          spacing: 1.0.h,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              fontSize: 1.6.h,
                                              title: task['subject'],
                                              fontWeight: FontWeight.w600,
                                            ),
                                            AppText(
                                              fontSize: 1.6.h,
                                              fontWeight: FontWeight.w600,
                                              title: task['dueDate']
                                                  .substring(0, 10),
                                              color: context
                                                  .theme.colorScheme.onPrimary,
                                            ),
                                            AppText(
                                              fontSize: 1.6.h,
                                              fontWeight: FontWeight.w600,
                                              title: task['priority'],
                                            ),
                                            AppText(
                                              fontSize: 1.6.h,
                                              title: 'Nandan Raikwar',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                appDivider(context: context, vertical: 1.h),
                              ],
                            );
                          },
                        ),
            ),
          ],
        );
      }),
    );
  }
}
