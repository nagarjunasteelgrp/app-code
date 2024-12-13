import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget dashBoardDropDownOverallDistance(
    BuildContext context, DashboardProvider provider) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AppText(
        title: 'Overall Distance',
        fontWeight: FontWeight.bold,
        letterSpacing: 0.4,
        fontSize: 1.8.h,
      ),
      Container(
        width: 12.h,
        height: 3.8.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(1.5.h),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
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
              value: provider.selectedValueOverallDistance.toString(),
              focusColor: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(1.0.w),
              dropdownColor: Theme.of(context).colorScheme.background,
              hint: Text(
                "--Select--",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.inverseSurface,
                size: 3.h,
              ),
              items: List.generate(provider.dropDownOverallDistance.length,
                  (index) {
                var data = provider.dropDownOverallDistance[index];
                var value = data.toString();
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.5.w),
                    child: AppText(
                      title: "${data[0].toUpperCase()}${data.substring(1)}",
                      fontSize: 1.5.h,
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 1.9.h),
              onChanged: (newValue) {
                provider.dropDownSelectedValueOverallDistance(newValue);
              },
            ),
          ),
        ),
      ),
    ],
  );
}
