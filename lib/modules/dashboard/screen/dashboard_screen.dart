import 'package:animated_digit/animated_digit.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/dashboard/components/dashboardDropDownNewEnrollment.dart';
import 'package:digital_lync/modules/dashboard/components/dashboardDropDownOverallDistance.dart';
import 'package:digital_lync/modules/dashboard/components/my_progress_list.dart';
import 'package:digital_lync/modules/dashboard/components/pie_chart.dart';
import 'package:digital_lync/modules/dashboard/components/row_widget_text.dart';
import 'package:digital_lync/modules/dashboard/components/travel_summary.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_fonts/google_fonts.dart';
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
              final dropDownProvider = Provider.of<DashboardProvider>(context);

              return provider.isLoading == true
                  ? const Align(
                      alignment: Alignment.center,
                      child: SpinKitLoader(),
                    )
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
                                  vertical: 0.5.h,
                                  context: context,
                                  colors:
                                      Theme.of(context).colorScheme.secondary,
                                ),
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
                                        length: 60,
                                        dashLength: 3,
                                        direction: Axis.vertical,
                                        dashColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
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
                                            .secondary,
                                      ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        fontSize: 18,
                                        title: "This Month",
                                        color: AppColors.WHITE_COLOR,
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
                                Consumer<DashboardProvider>(
                                  builder: (context, provider, _) {
                                    final qtyList = provider.estimationAndQty !=
                                                null &&
                                            provider.estimationAndQty[
                                                    'quantity'] !=
                                                null
                                        ? provider.estimationAndQty['quantity']
                                            as List
                                        : [];

                                    return Column(
                                      children: qtyList.isEmpty
                                          ? [
                                              const RowTextWidget(
                                                value1: "0",
                                                label1: 'Target Qty',
                                                value2: "0",
                                                label2: 'Achieved Qty',
                                                value3: "0",
                                                label3: 'Due Qty',
                                              )
                                            ]
                                          : List.generate(
                                              qtyList.length,
                                              (index) {
                                                final item = qtyList[index];
                                                return RowTextWidget(
                                                  brands: true,
                                                  brandsTitle:
                                                      item['Brand'] ?? '',
                                                  value1:
                                                      (item['Target Qty (MT)'] ??
                                                              0)
                                                          .toString(),
                                                  label1: 'Target Qty',
                                                  value2:
                                                      (item['Achieved Qty (MT)'] ??
                                                              0)
                                                          .toString(),
                                                  label2: 'Achieved Qty',
                                                  value3:
                                                      (item['Balance Qty (MT)'] ??
                                                              0)
                                                          .toString(),
                                                  label3: 'Due Qty',
                                                );
                                              },
                                            ),
                                    );
                                  },
                                ),
                                RowTextWidget(
                                    value1: provider.estimationAndQty != null && provider.estimationAndQty['estimation'] != null && provider.estimationAndQty['estimation'].isNotEmpty
                                        ? provider.estimationAndQty['estimation']
                                                [0]['Target Amt (Rs)']
                                            .toString()
                                        : "0",
                                    label1: 'Target Amt',
                                    //

                                    value2: provider.estimationAndQty != null &&
                                            provider.estimationAndQty['estimation'] !=
                                                null &&
                                            provider
                                                .estimationAndQty['estimation']
                                                .isNotEmpty
                                        ? provider
                                            .estimationAndQty['estimation'][0]
                                                ['Achieved Amt (Rs)']
                                            .toString()
                                        : "0",
                                    label2: 'Achieved Amt',
                                    //

                                    value3: provider.estimationAndQty != null &&
                                            provider.estimationAndQty['estimation'] !=
                                                null &&
                                            provider.estimationAndQty['estimation'].isNotEmpty
                                        ? provider.estimationAndQty['estimation'][0]['Balance Amt (Rs)'].toString()
                                        : "0",
                                    label3: 'Due Amt'
                                    //

                                    ),
                                SizedBox(height: 1.h),
                                appDivider(
                                    context: context,
                                    colors:
                                        Theme.of(context).colorScheme.secondary,
                                    vertical: 0.5.h),
                                SizedBox(height: 1.5.h),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 30.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: AppColors.borderColor)),
                                    child: DropdownButton<String>(
                                      isDense: true,
                                      isExpanded: true,
                                      value: dropDownProvider.selectedValue,
                                      iconEnabledColor: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      iconDisabledColor: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: AppColors.lightBlackColor,
                                        size: 3.h,
                                      ),
                                      underline: const SizedBox(),
                                      borderRadius:
                                          BorderRadius.circular(1.0.w),
                                      dropdownColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      focusColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 1.9.h,
                                        color: AppColors.lightBlackColor,
                                      ),
                                      items: dropDownProvider.items
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 0.5.w),
                                            child: AppText(
                                              title:
                                                  "${value[0].toUpperCase()}${value.substring(1)}",
                                              fontSize: 1.5.h,
                                              color: AppColors.lightBlackColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          dropDownProvider
                                              .setSelectedValue(newValue);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Consumer<DashboardProvider>(
                                  builder: (context, provider, _) {
                                    final data = provider.selectedData;

                                    final bool isQty =
                                        provider.selectedValue == 'Quantity';

                                    // Agar data null ya empty ho to default 0 values
                                    final target = isQty
                                        ? (data != null
                                            ? (data['Target Qty (MT)'] ?? 0.0)
                                                .toDouble()
                                            : 0.0)
                                        : (data != null
                                            ? (data['Target Amt (Rs)'] ?? 0.0)
                                                .toDouble()
                                            : 0.0);

                                    final achieved = isQty
                                        ? (data != null
                                            ? (data['Achieved Qty (MT)'] ?? 0.0)
                                                .toDouble()
                                            : 0.0)
                                        : (data != null
                                            ? (data['Achieved Amt (Rs)'] ?? 0.0)
                                                .toDouble()
                                            : 0.0);

                                    final balance = isQty
                                        ? (data != null
                                            ? (data['Balance Qty (MT)'] ?? 0.0)
                                                .toDouble()
                                            : 0.0)
                                        : (data != null
                                            ? (data['Balance Amt (Rs)'] ?? 0.0)
                                                .toDouble()
                                            : 0.0);

                                    final percentage = target == 0
                                        ? 0.0
                                        : (achieved / target).clamp(0.0, 1.0);

                                    return Column(
                                      children: [
                                        targetAmountWidget(
                                          title: isQty
                                              ? "Target Quantity"
                                              : "Target Amount",
                                          targetAmount:
                                              target.toStringAsFixed(2),
                                          duePercentage: percentage,
                                        ),
                                        SizedBox(height: 2.5.h),
                                        Row(
                                          children: [
                                            // DUE WIDGET
                                            Expanded(
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 2.2.h,
                                                          width: 1.5.h,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: AppColors
                                                                .yellowColor,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        SizedBox(width: 1.h),
                                                        AppText(
                                                          fontSize: 16,
                                                          title: isQty
                                                              ? "Due Quantity"
                                                              : "Due Amount",
                                                          color: AppColors
                                                              .lightBlackColor,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 0.5.h),
                                                    AnimatedDigitWidget(
                                                      textStyle:
                                                          GoogleFonts.lato(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .lightBlackColor,
                                                      ),
                                                      fractionDigits: 2,
                                                      value: balance,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // ACHIEVED WIDGET
                                            Expanded(
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 1.5.h,
                                                          width: 1.5.h,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: AppColors
                                                                .greenColor,
                                                          ),
                                                        ),
                                                        SizedBox(width: 1.h),
                                                        AppText(
                                                          fontSize: 16,
                                                          title: isQty
                                                              ? "Achieved Quantity"
                                                              : "Achieved Amount",
                                                          color: AppColors
                                                              .lightBlackColor,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 0.5.h),
                                                    AnimatedDigitWidget(
                                                      textStyle:
                                                          GoogleFonts.lato(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .lightBlackColor,
                                                      ),
                                                      fractionDigits: 2,
                                                      value: achieved,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                )
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

  Widget targetAmountWidget({
    String? title,
    String? targetAmount,
    double? duePercentage,
  }) {
    return CircularPercentIndicator(
      radius: 100.0,
      animation: true,
      lineWidth: 15.0,
      animationDuration: 1200,
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
            fontSize: 12,
            title: title ?? "Target Amount",
            color: AppColors.tooLightBlackColor,
          ),
        ],
      ),
      progressColor: AppColors.greenColor,
      backgroundColor: AppColors.yellowColor,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
