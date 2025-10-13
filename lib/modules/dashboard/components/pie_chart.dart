import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:sizer/sizer.dart';

class ChartPie extends StatefulWidget {
  final DashboardProvider provider;

  const ChartPie({super.key, required this.provider});

  @override
  State<ChartPie> createState() => ChartPieState();
}

class ChartPieState extends State<ChartPie> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                centerSpaceRadius: 7.h,
                centerSpaceColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                sectionsSpace: 5,
                sections: [
                  PieChartSectionData(
                    radius: 60,
                    badgePositionPercentageOffset: 0.9,
                    color: context.theme.colorScheme.outline,
                    value: widget.provider.dealerSum.toDouble(),
                    badgeWidget: Container(
                      width: 4.h,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.outline,
                        borderRadius: BorderRadius.circular(10.h),
                        border: Border.all(color: Colors.white, width: 0.3.h),
                      ),
                      child: Center(
                        child: AppText(
                          fontSize: 1.1.h,
                          color: context.theme.primaryColor,
                          title: widget.provider.dealerSum.toString(),
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    radius: 60,
                    showTitle: false,
                    value: widget.provider.fabricatorsSum.toDouble(),
                    color: context.theme.colorScheme.onPrimaryContainer,
                    badgePositionPercentageOffset: 0.9,
                    badgeWidget: Container(
                      width: 4.h,
                      height: 4.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: context.theme.colorScheme.onPrimaryContainer,
                        border: Border.all(color: Colors.white, width: 0.3.h),
                      ),
                      child: Center(
                        child: AppText(
                          fontSize: 1.1.h,
                          color: context.theme.primaryColor,
                          title: widget.provider.fabricatorsSum.toString(),
                        ),
                      ),
                    ),
                  ),
                  PieChartSectionData(
                    radius: 60,
                    badgePositionPercentageOffset: 0.9,
                    value: widget.provider.customerSum.toDouble(),
                    color: context.theme.colorScheme.onInverseSurface,
                    badgeWidget: Container(
                      width: 4.h,
                      height: 4.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: context.theme.colorScheme.onInverseSurface,
                        border: Border.all(color: Colors.white, width: 0.3.h),
                      ),
                      child: Center(
                        child: AppText(
                          title: widget.provider.customerSum.toString(),
                          color: context.theme.primaryColor,
                          fontSize: 1.1.h,
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: widget.provider.engineersSum.toDouble(),
                    color: context.theme.colorScheme.onPrimary,
                    radius: 60,
                    // Reduced radius
                    badgePositionPercentageOffset: 0.9,
                    badgeWidget: Container(
                      height: 4.h,
                      width: 4.h,
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.onPrimary,
                        border: Border.all(color: Colors.white, width: 0.3.h),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Center(
                        child: AppText(
                          title: widget.provider.engineersSum.toString(),
                          color: context.theme.primaryColor,
                          fontSize: 1.1.h,
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    radius: 60,
                    showTitle: false,
                    badgePositionPercentageOffset: 0.9,
                    value: widget.provider.masonsSum.toDouble(),
                    color: context.theme.colorScheme.onSecondary,
                    badgeWidget: Container(
                      width: 4.h,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.onSecondary,
                        border: Border.all(color: Colors.white, width: 0.3.h),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Center(
                        child: AppText(
                          fontSize: 1.1.h,
                          color: context.theme.primaryColor,
                          title: widget.provider.masonsSum.toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    title: '${widget.provider.overallEnrollmentSum}',
                  ),
                  AppText(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                    title: 'Total Enrollment',
                    color: context.theme.colorScheme.secondary
                        .withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
