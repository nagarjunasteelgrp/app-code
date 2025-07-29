import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/dashboard/components/dashboardDropDownNewEnrollment.dart';
import 'package:digital_lync/modules/dashboard/components/dashboardDropDownOverallDistance.dart';
import 'package:digital_lync/modules/dashboard/components/myProgress_list.dart';
import 'package:digital_lync/modules/dashboard/components/pie_chart.dart';
import 'package:digital_lync/modules/dashboard/components/travel_summary.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
              return provider.isLoading == true
                  ? const Align(
                      alignment: Alignment.center, child: SpinKitLoader())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 3.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.5.h, vertical: 1.5.h),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(1.4.h),
                                border:
                                    Border.all(color: AppColors.borderColor)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  title: 'MY PROGRESS',
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 1.5.h),
                                myProgressList(provider),
                                SizedBox(
                                  height: 1.h,
                                ),
                                appDivider(
                                    context: context,
                                    colors:
                                        Theme.of(context).colorScheme.secondary,
                                    vertical: 0.5.h),
                                SizedBox(height: 1.5.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          AppText(
                                            title:
                                                provider.myProgressAPIResponse !=
                                                        null
                                                    ? provider
                                                        .myProgressAPIResponse[
                                                            'noOfVisits']
                                                        .toString()
                                                    : '0',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(height: 0.5.h),
                                          AppText(
                                            title: 'No. of Visits',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ],
                                      ),
                                      Dash(
                                          direction: Axis.vertical,
                                          length: 60,
                                          dashLength: 3,
                                          dashColor: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      Column(
                                        children: [
                                          AppText(
                                            title:
                                                provider.myProgressAPIResponse !=
                                                        null
                                                    ? provider
                                                        .myProgressAPIResponse[
                                                            'newContacts']
                                                        .toString()
                                                    : '0',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(height: 0.5.h),
                                          AppText(
                                            title: 'New Contacts',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ],
                                      ),
                                      Dash(
                                          direction: Axis.vertical,
                                          length: 60,
                                          dashLength: 3,
                                          dashColor: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      Column(
                                        children: [
                                          AppText(
                                            title: provider
                                                        .myProgressAPIResponse !=
                                                    null
                                                ? '${provider.myProgressAPIResponse['workingHours'].toString()} hrs'
                                                : '0 hrs',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(height: 0.5.h),
                                          AppText(
                                            title: 'Working hours',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                appDivider(
                                  context: context,
                                  colors:
                                      Theme.of(context).colorScheme.secondary,
                                  vertical: 0.5.h,
                                ),
                                Center(
                                    child: AppText(
                                  title:
                                      'Total No of Contacts ${provider.myProgressAPIResponse != null ? provider.myProgressAPIResponse['totalNoOfContacts'].toString() : '0'}',
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  letterSpacing: 0.5,
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.5.h, vertical: 1.5.h),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(1.4.h),
                                border:
                                    Border.all(color: AppColors.borderColor)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dashBoardDropDownOverallDistance(
                                    context, provider),
                                SizedBox(height: 2.h),
                                Center(
                                    child: AppText(
                                  title:
                                      'Total Distance : ${provider.overallDistance.toStringAsFixed(3)} Km',
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.7),
                                  letterSpacing: 0.5,
                                  fontSize: 16,
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.5.h, vertical: 1.5.h),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(1.4.h),
                              border: Border.all(color: AppColors.borderColor),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.h, vertical: 0.7.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.blueColor2,
                                        borderRadius:
                                            BorderRadius.circular(1.h),
                                      ),
                                      child: AppText(
                                        title: "This Month",
                                        color: AppColors.WHITE_COLOR,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                appDivider(
                                    context: context,
                                    colors:
                                        Theme.of(context).colorScheme.secondary,
                                    vertical: 0.5.h),
                                SizedBox(height: 1.5.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          AppText(
                                            title: provider
                                                            .monthlySalesQtyResponse !=
                                                        null &&
                                                    provider.monthlySalesQtyResponse[
                                                            'responseObject'] !=
                                                        null &&
                                                    provider
                                                        .monthlySalesQtyResponse[
                                                            'responseObject']
                                                        .isNotEmpty
                                                ? provider
                                                    .monthlySalesQtyResponse[
                                                        'responseObject'][0]
                                                        ['Target Qty (MT)']
                                                    .toString()
                                                : "0",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color: AppColors.lightBlackColor,
                                          ),
                                          SizedBox(height: 0.5.h),
                                          AppText(
                                              title: "Target Quantity",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  AppColors.tooLightBlackColor),
                                        ],
                                      ),
                                    ),
                                    Dash(
                                        direction: Axis.vertical,
                                        length: 60,
                                        dashLength: 3,
                                        dashColor: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          AppText(
                                            title: provider
                                                            .monthlyReportResponse !=
                                                        null &&
                                                    provider.monthlyReportResponse[
                                                            'responseObject'] !=
                                                        null &&
                                                    provider
                                                        .monthlyReportResponse[
                                                            'responseObject']
                                                        .isNotEmpty
                                                ? provider
                                                    .monthlyReportResponse[
                                                        'responseObject'][0]
                                                        ['Target Amt (Rs)']
                                                    .toString()
                                                : "0",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color: AppColors.lightBlackColor,
                                          ),
                                          SizedBox(height: 0.5.h),
                                          AppText(
                                              title: "Target Amount",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  AppColors.tooLightBlackColor),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          AppText(
                                            title: provider
                                                            .monthlyReportResponse !=
                                                        null &&
                                                    provider.monthlyReportResponse[
                                                            'responseObject'] !=
                                                        null &&
                                                    provider
                                                        .monthlyReportResponse[
                                                            'responseObject']
                                                        .isNotEmpty
                                                ? provider
                                                    .monthlyReportResponse[
                                                        'responseObject'][0]
                                                        ['Achieved Amt (Rs)']
                                                    .toString()
                                                : "0",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color: AppColors.lightBlackColor,
                                          ),
                                          SizedBox(height: 0.5.h),
                                          AppText(
                                              title: "Achieved Amount",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  AppColors.tooLightBlackColor),
                                        ],
                                      ),
                                    ),
                                    Dash(
                                        direction: Axis.vertical,
                                        length: 60,
                                        dashLength: 3,
                                        dashColor: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          AppText(
                                            title: provider
                                                            .monthlyReportResponse !=
                                                        null &&
                                                    provider.monthlyReportResponse[
                                                            'responseObject'] !=
                                                        null &&
                                                    provider
                                                        .monthlyReportResponse[
                                                            'responseObject']
                                                        .isNotEmpty
                                                ? provider
                                                    .monthlyReportResponse[
                                                        'responseObject'][0]
                                                        ['Balance Amt (Rs)']
                                                    .toString()
                                                : "0",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color: AppColors.lightBlackColor,
                                          ),
                                          SizedBox(height: 0.5.h),
                                          AppText(
                                              title: "Due Amount",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  AppColors.tooLightBlackColor),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                appDivider(
                                    context: context,
                                    colors:
                                        Theme.of(context).colorScheme.secondary,
                                    vertical: 0.5.h),
                                SizedBox(height: 1.5.h),
                                targetAmountWidget(
                                  targetAmount:
                                      provider.monthlyReportResponse != null &&
                                              provider.monthlyReportResponse[
                                                      'responseObject'] !=
                                                  null &&
                                              provider
                                                  .monthlyReportResponse[
                                                      'responseObject']
                                                  .isNotEmpty
                                          ? provider.monthlyReportResponse[
                                                  'responseObject'][0]
                                                  ['Target Amt (Rs)']
                                              .toString()
                                          : "0",
                                  duePercentage:
                                      provider.monthlyReportResponse != null &&
                                              provider.monthlyReportResponse[
                                                      'responseObject'] !=
                                                  null &&
                                              provider
                                                  .monthlyReportResponse[
                                                      'responseObject']
                                                  .isNotEmpty
                                          ? (double.parse(provider
                                                      .monthlyReportResponse[
                                                          'responseObject'][0]
                                                          ['Ach(%)']
                                                      .toString()) /
                                                  100)
                                              .clamp(0.0, 1.0)
                                          : 0.0,
                                ),
                                SizedBox(height: 2.5.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 2.2.h,
                                                  width: 1.5.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.h),
                                                    color: AppColors.greenColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1.h,
                                                ),
                                                AppText(
                                                  title: "Due Amount",
                                                  color:
                                                      AppColors.lightBlackColor,
                                                  fontSize: 16,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 0.5.h),
                                            AppText(
                                              title: provider
                                                              .monthlyReportResponse !=
                                                          null &&
                                                      provider.monthlyReportResponse[
                                                              'responseObject'] !=
                                                          null &&
                                                      provider
                                                          .monthlyReportResponse[
                                                              'responseObject']
                                                          .isNotEmpty
                                                  ? provider
                                                      .monthlyReportResponse[
                                                          'responseObject'][0]
                                                          ['Balance Amt (Rs)']
                                                      .toString()
                                                  : "0",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.lightBlackColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 1.5.h,
                                                  width: 1.5.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.h),
                                                    color:
                                                        AppColors.yellowColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1.h,
                                                ),
                                                AppText(
                                                  title: "Achieved Amount",
                                                  color:
                                                      AppColors.lightBlackColor,
                                                  fontSize: 16,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 0.5.h),
                                            AppText(
                                              title: provider
                                                              .monthlyReportResponse !=
                                                          null &&
                                                      provider.monthlyReportResponse[
                                                              'responseObject'] !=
                                                          null &&
                                                      provider
                                                          .monthlyReportResponse[
                                                              'responseObject']
                                                          .isNotEmpty
                                                  ? provider
                                                      .monthlyReportResponse[
                                                          'responseObject'][0]
                                                          ['Achieved Amt (Rs)']
                                                      .toString()
                                                  : "0",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: AppColors.lightBlackColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                color: AppColors.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(1.4.h),
                                border:
                                    Border.all(color: AppColors.borderColor)),
                            child: Column(
                              children: [
                                dashBoardDropDownNewEnrollment(
                                    context, provider),
                                SizedBox(
                                  height: 1.h,
                                ),
                                pieChart(provider: provider),
                                // LineChartWidget(provider: provider),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 1.5.h,
                                          width: 1.5.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.h),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.h,
                                        ),
                                        AppText(
                                          title: 'Dealers',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 1.5.h,
                                          width: 1.5.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.h),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.h,
                                        ),
                                        AppText(
                                          title: 'Fabricator',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 1.5.h,
                                          width: 1.5.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.h),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onInverseSurface,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.h,
                                        ),
                                        AppText(
                                          title: 'Customer',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 1.5.h,
                                          width: 1.5.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.h),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.h,
                                        ),
                                        AppText(
                                          title: 'Engineers',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 1.5.h,
                                          width: 1.5.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.h),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.h,
                                        ),
                                        AppText(
                                          title: 'Masons',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          travelSummary(),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget targetAmountWidget({String? targetAmount, double? duePercentage}) {
    return CircularPercentIndicator(
      radius: 100.0,
      animation: true,
      animationDuration: 1200,
      lineWidth: 15.0,
      percent: duePercentage!,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            title: targetAmount,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          SizedBox(height: 0.2.h),
          AppText(
            title: "Target Amount",
            fontSize: 12,
            color: AppColors.tooLightBlackColor,
          ),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: AppColors.yellowColor,
      progressColor: AppColors.greenColor,
    );
  }
}
