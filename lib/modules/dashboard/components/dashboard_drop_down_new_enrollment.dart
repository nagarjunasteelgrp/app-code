import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget dashBoardDropDownNewEnrollment(
    BuildContext context, DashboardProvider provider) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AppText(
        fontSize: 1.8.h,
        letterSpacing: 0.4,
        title: 'New Enrollment',
        fontWeight: FontWeight.bold,
      ),
      Container(
        width: 12.h,
        height: 3.8.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(1.5.h),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          child: Center(
            child: DropdownButton<String>(
              isDense: true,
              iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
              iconDisabledColor: Theme.of(context).colorScheme.onSecondary,
              isExpanded: true,
              underline: const SizedBox(),
              value: provider.selectedValueNewEnrollment.toString(),
              focusColor: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(1.0.w),
              dropdownColor: Theme.of(context).colorScheme.background,
              hint: AppText(
                title: "--Select--",
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.lightBlackColor,
                size: 3.h,
              ),
              items:
                  List.generate(provider.dropDownNewEnrollment.length, (index) {
                var data = provider.dropDownNewEnrollment[index];
                var value = data.toString();
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.5.w),
                    child: AppText(
                      fontSize: 1.5.h,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightBlackColor,
                      title: "${data[0].toUpperCase()}${data.substring(1)}",
                    ),
                  ),
                );
              }),
              style: TextStyle(
                fontSize: 1.9.h,
                fontWeight: FontWeight.w800,
                color: AppColors.WHITE_COLOR,
              ),
              onChanged: (newValue) {
                provider.dropDownSelectedValueNewEnrollment(newValue);
              },
            ),
          ),
        ),
      ),
    ],
  );
}
