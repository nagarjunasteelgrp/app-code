import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/dashboard/components/dashboard_dropDown.dart';
import 'package:digital_lync/modules/dashboard/components/lineChart.dart';
import 'package:digital_lync/modules/dashboard/components/myProgress_list.dart';
import 'package:digital_lync/modules/dashboard/components/reportCard.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

DashboardProvider dashboardProvider = DashboardProvider();

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
  value: DashboardProvider(),
  child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
          return provider.isLoading == false ?  SingleChildScrollView(
              child: Column(
              children: [
                SizedBox(height: 3.h),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.5.h, vertical: 1.5.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(1.4.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title: 'MY PROGRESS',
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 1.5.h),
                      myProgressList(provider),
                      SizedBox(height: 1.h,),
                      appDivider(context: context,colors: Theme.of(context).colorScheme.secondary,vertical: 0.5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          reportCard(color: Theme.of(context).colorScheme.onInverseSurface,title: 'Total Applications',noOfTile: provider.myProgressAPIResponse.isNotEmpty ? provider.myProgressAPIResponse[0]['totalNoOfContacts'].toString() : ''),
                          reportCard(color: Theme.of(context).colorScheme.onPrimaryContainer,title: "Today's Visits",noOfTile: provider.myProgressAPIResponse.isNotEmpty ? provider.myProgressAPIResponse[0]['visitsCount'].toString() : ''),
                        ],
                      ),
                      SizedBox(height: 1.5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          reportCard(color: Theme.of(context).colorScheme.error,title: 'New Enrollments',noOfTile: provider.myProgressAPIResponse.isNotEmpty ? provider.myProgressAPIResponse[0]['tasksCount'].toString() : ''),
                          reportCard(color: Theme.of(context).colorScheme.outline,title: 'Attendance',noOfTile: provider.myProgressAPIResponse.isNotEmpty ? "${provider.myProgressAPIResponse[0]['presentCount'].toString()}/${provider.myProgressAPIResponse[0]['totalUsers'].toString()}" : ''),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.5.h, vertical: 1.5.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(1.4.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),child: Column(
                  children: [
                    dashBoardProvider(context,provider),
                    SizedBox(height: 1.h,),
                    LineChartWidget(provider: provider),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 1.5.h,
                              width: 1.5.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.h),
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            SizedBox(width: 1.h,),
                            AppText(title: 'Dealers',color: Theme.of(context).colorScheme.onSecondary,),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 1.5.h,
                              width: 1.5.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.h),
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            SizedBox(width: 1.h,),
                            AppText(title: 'Fabricator',color: Theme.of(context).colorScheme.onSecondary,),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 1.5.h,
                              width: 1.5.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.h),
                                color: Theme.of(context).colorScheme.onInverseSurface,
                              ),
                            ),
                            SizedBox(width: 1.h,),
                            AppText(title: 'Customer',color: Theme.of(context).colorScheme.onSecondary,),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),),
              ],
                        ),
            ) : Align(
            alignment: Alignment.center,child: SpinKitLoader() ,);
          },
        ),
        ),
    ),
);
  }
}
