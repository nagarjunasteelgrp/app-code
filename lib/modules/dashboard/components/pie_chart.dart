import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class pieChart extends StatefulWidget {
  final DashboardProvider provider;

  const pieChart({super.key, required this.provider});

  @override
  State<pieChart> createState() => pieChartState();
}

class pieChartState extends State<pieChart> {
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
                    value: widget.provider.dealerSum.toDouble(),
                    color: Theme.of(context).colorScheme.outline,
                    radius: 60,
                    // Reduced radius
                    badgePositionPercentageOffset: 0.9,
                    badgeWidget: Container(
                      height: 4.h,
                      width: 4.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outline,
                        border: Border.all(color: Colors.white, width: 0.3.h),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Center(
                        child: AppText(
                          title: widget.provider.dealerSum.toString(),
                          color: Theme.of(context).primaryColor,
                          fontSize: 1.1.h,
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: widget.provider.fabricatorsSum.toDouble(),
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    radius: 60,
                    // Reduced radius
                    badgePositionPercentageOffset: 0.9,
                    badgeWidget: Container(
                      height: 4.h,
                      width: 4.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        border: Border.all(color: Colors.white, width: 0.3.h),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Center(
                        child: AppText(
                          title: widget.provider.fabricatorsSum.toString(),
                          color: Theme.of(context).primaryColor,
                          fontSize: 1.1.h,
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: widget.provider.customerSum.toDouble(),
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    radius: 60,
                    // Reduced radius
                    badgePositionPercentageOffset: 0.9,
                    badgeWidget: Container(
                      height: 4.h,
                      width: 4.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        border: Border.all(color: Colors.white, width: 0.3.h),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Center(
                        child: AppText(
                          title: widget.provider.customerSum.toString(),
                          color: Theme.of(context).primaryColor,
                          fontSize: 1.1.h,
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: widget.provider.engineersSum.toDouble(),
                    color: Theme.of(context).colorScheme.onPrimary,
                    radius: 60,
                    // Reduced radius
                    badgePositionPercentageOffset: 0.9,
                    badgeWidget: Container(
                      height: 4.h,
                      width: 4.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        border: Border.all(color: Colors.white, width: 0.3.h),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Center(
                        child: AppText(
                          title: widget.provider.engineersSum.toString(),
                          color: Theme.of(context).primaryColor,
                          fontSize: 1.1.h,
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: widget.provider.masonsSum.toDouble(),
                    color: Theme.of(context).colorScheme.onSecondary,
                    radius: 60,
                    // Reduced radius
                    badgePositionPercentageOffset: 0.9,
                    badgeWidget: Container(
                      height: 4.h,
                      width: 4.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSecondary,
                        border: Border.all(color: Colors.white, width: 0.3.h),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Center(
                        child: AppText(
                          title: widget.provider.masonsSum.toString(),
                          color: Theme.of(context).primaryColor,
                          fontSize: 1.1.h,
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    title: '${widget.provider.overallEnrollmentSum}',
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  AppText(
                    title: 'Total Enrollment',
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withValues(alpha: 0.5),
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
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
