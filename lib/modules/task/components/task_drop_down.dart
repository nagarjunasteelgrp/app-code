import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sizer/sizer.dart';

Widget taskStatusDropDown(BuildContext context, TaskProvider provider) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const AppText(title: 'Task Status'),
      SizedBox(height: 0.5.h),
      Container(
        height: 4.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.colorScheme.onBackground),
          borderRadius: BorderRadius.circular(1.h),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          child: Center(
            child: DropdownButton<String>(
              isDense: true,
              isExpanded: true,
              underline: const SizedBox(),
              value: provider.selectedValue.toString(),
              borderRadius: BorderRadius.circular(1.0.w),
              focusColor: context.theme.colorScheme.background,
              dropdownColor: context.theme.colorScheme.background,
              iconEnabledColor: context.theme.colorScheme.onSecondary,
              iconDisabledColor: context.theme.colorScheme.onSecondary,
              hint: AppText(
                title: "--Select--",
                color: context.theme.colorScheme.onSecondary,
              ),
              icon: Icon(
                size: 3.h,
                Icons.keyboard_arrow_down_rounded,
                color: context.theme.colorScheme.inverseSurface,
              ),
              items: List.generate(provider.dropDown.length, (index) {
                var data = provider.dropDown[index];
                var value = data.toString();
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.5.w),
                    child: AppText(
                      title: "${data[0].toUpperCase()}${data.substring(1)}",
                      fontSize: 1.5.h,
                      color: context.theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 1.9.h),
              onChanged: (newValue) {
                provider.dropDownSelectedValue(newValue);
              },
            ),
          ),
        ),
      ),
    ],
  );
}
