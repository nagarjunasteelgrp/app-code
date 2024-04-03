import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/activities/provider/activities_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ActivitiesProvider>(
        builder: (context, provider, child) {
          return  Column(
            children: [
              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    appCircleIcon(
                      context: context,
                      colors: Theme
                          .of(context)
                          .colorScheme
                          .scrim,
                      radius: 0.5.h,
                      height: 8.w,
                      width: 8.w,
                      child: SvgPicture.asset(AppAssets.APP_ACTIVITIES_SVG,
                          color: Theme
                              .of(context)
                              .primaryColor),
                    ),
                    SizedBox(width: 3.w),
                    AppText(
                      title: Constants.activities,
                      fontSize: 1.8.h,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
                     Expanded(
                       child: provider.isLoading ? Center(child: SpinKitLoader()) : provider.taskList.length < 0 ? Center(
                         child: AppText(title: Constants.result_not_found,),
                       ) : SingleChildScrollView(
                         child: Column(
                          children: List.generate(
                              provider.taskList.length, (index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          AppText(
                                            title: '${Constants.subject} :',
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          AppText(
                                            title: '${Constants.due_Date} :',
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          AppText(
                                            title: '${Constants.priority} :',
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          AppText(
                                            title: '${Constants.owner} :',
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 2.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            AppText(
                                                title: provider
                                                    .taskList[index]['subject'],
                                                fontSize: 1.6.h,
                                                fontWeight: FontWeight.w600),
                                            SizedBox(
                                              height: 1.0.h,
                                            ),
                                            AppText(
                                                title: provider
                                                    .taskList[index]['dueDate'].substring(0, 10),
                                                fontSize: 1.6.h,
                                                fontWeight: FontWeight.w600,
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .onPrimary
                                            ),
                                            SizedBox(
                                              height: 1.0.h,
                                            ),
                                            AppText(
                                              title: provider
                                                  .taskList[index]['priority'],
                                              fontSize: 1.6.h,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            SizedBox(
                                              height: 1.0.h,
                                            ), AppText(
                                              title: 'Nandan Raikwar',
                                              fontSize: 1.6.h,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            SizedBox(
                                              height: 1.0.h,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            appDivider(
                                context: context, vertical: 1.h),
                                // index == 9 ? SizedBox() : appDivider(
                                //     context: context, vertical: 1.h),
                              ],
                            );
                          }),
                                             ),
                       ),
                     ),
            ],
          );
        }   ),
    );
  }
}
