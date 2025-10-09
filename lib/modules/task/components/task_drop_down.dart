import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget taskStatusDropDown(BuildContext context, TaskProvider provider) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText(
        title: 'Task Status',
      ),
      SizedBox(
        height: 0.5.h,
      ),
      Container(
        width: double.infinity,
        height: 4.h,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onBackground),
          borderRadius: BorderRadius.circular(1.h),
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
              value: provider.selectedValue.toString(),
              focusColor: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(1.0.w),
              dropdownColor: Theme.of(context).colorScheme.background,
              hint: Text(
                "--Select--",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.inverseSurface,
                size: 3.h,
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
                      color: Theme.of(context).colorScheme.secondary,
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
