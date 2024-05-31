import 'package:digital_lync/common/app_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget pieChartWidget (BuildContext context){
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
                    value: 200,
                    color: Theme.of(context).colorScheme.outline,
                    radius: 60, // Reduced radius
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
                          title: '200',
                          color: Theme.of(context).primaryColor,
                          fontSize: 1.3.h,
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 150,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    radius: 60, // Reduced radius
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
                          title: '150',
                          color: Theme.of(context).primaryColor,
                          fontSize: 1.3.h,
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 110,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    radius: 60, // Reduced radius
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
                          title: '110',
                          color: Theme.of(context).primaryColor,
                          fontSize: 1.3.h,
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
                  AppText(title: '316',fontWeight: FontWeight.bold,fontSize: 14.sp,),
                  AppText(
                    title: 'Overall Enrollment',
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
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