import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ReachedScreen extends StatelessWidget {
  const ReachedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    int remainingDays = lastDayOfMonth.difference(now).inDays;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ChangeNotifierProvider.value(
          value: DashboardProvider(),
          child: Consumer<DashboardProvider>(
            builder: (context, provider, child) {
              double achPercent = provider.monthlyReportResponse != null &&
                      provider.monthlyReportResponse['responseObject'] !=
                          null &&
                      provider
                          .monthlyReportResponse['responseObject'].isNotEmpty
                  ? double.tryParse(provider
                          .monthlyReportResponse['responseObject'][0]['Ach(%)']
                          .toString()) ??
                      0.0
                  : 0.0;

              return Column(
                spacing: 2.h,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: AppColors.WHITE_COLOR,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.lightGreyColor,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularPercentIndicator(
                            radius: 100.0,
                            animation: true,
                            animationDuration: 1200,
                            lineWidth: 30.0,
                            percent: (achPercent / 100).clamp(0.0, 1.0),
                            center: AppText(
                              title: "${achPercent.toStringAsFixed(2)}%",
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                            circularStrokeCap: CircularStrokeCap.butt,
                            backgroundColor: AppColors.lightGreyColor,
                            progressColor: AppColors.blueColor,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Center(
                          child: AppText(
                            fontSize: 24,
                            title: "Congratulations!",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Center(
                            child: AppText(
                                title:
                                    "You’ve reached ${achPercent.toStringAsFixed(2)}% of your target",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.BLACK_COLOR.withAlpha(100))),
                        SizedBox(height: 3.h),
                        AppText(
                            title: "Current Progress",
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        SizedBox(height: 1.h),
                        AppText(
                            title:
                                "${achPercent.toStringAsFixed(2)} out of 100 points achieved",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.BLACK_COLOR.withAlpha(100)),
                        SizedBox(height: 1.h),
                        LinearPercentIndicator(
                          width: 81.w,
                          padding: EdgeInsets.zero,
                          lineHeight: 8.0,
                          percent: (achPercent / 100).clamp(0.0, 1.0),
                          barRadius: const Radius.circular(10),
                          backgroundColor: AppColors.lightGreyColor,
                          progressColor: AppColors.blueColor,
                        ),
                        SizedBox(height: 2.h),
                        Center(
                          child: AppText(
                            title:
                                "You’re doing great! Stay  focused on your target",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greenColor2,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Consumer<HomeProvider>(
                          builder: (context, provider, child) {
                            return appButton(
                              height: 5.7.h,
                              radius: 1.5.h,
                              context: context,
                              width: double.infinity,
                              onTap: () {
                                provider.setReachedOut(true);
                                provider.setSelectedIndex(0);
                                Get.offNamed(RoutesName.HOME);
                              },
                              child: AppText(
                                fontSize: 16,
                                title: "Continue Journey",
                                fontWeight: FontWeight.w500,
                                color: AppColors.WHITE_COLOR,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: AppText(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.BLACK_COLOR.withAlpha(150),
                      title:
                          "$remainingDays Days remaining to complete the target",
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
