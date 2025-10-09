import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget dropdownContactsWidget({
  String? title,
  double? width,
  String? hintValue,
  required String value,
  required BuildContext context,
  required Function(String?) onChanged,
  required List<DropdownMenuItem<String>> items,
}) {
  return Container(
    width: width ?? double.infinity,
    padding: EdgeInsets.only(left: 3.5.w, right: 5.0.w),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onSurface,
      borderRadius: BorderRadius.circular(1.5.w),
      border: Border.all(
        width: 0.5,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        AppText(title: title, fontSize: 1.5.h),
        DropdownButton<String>(
          items: items,
          value: value,
          isDense: true,
          isExpanded: true,
          onChanged: onChanged,
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(1.0.w),
          focusColor: Theme.of(context).colorScheme.background,
          dropdownColor: Theme.of(context).colorScheme.background,
          iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
          iconDisabledColor: Theme.of(context).colorScheme.onSecondary,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 1.9.h),
          hint: Text(
            hintValue ?? "--Select--",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          icon: Icon(
            size: 3.h,
            Icons.keyboard_arrow_down_rounded,
          ),
        ),
        SizedBox(height: 0.5.h),
      ],
    ),
  );
}
