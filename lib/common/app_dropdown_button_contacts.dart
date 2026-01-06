import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
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
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
    decoration: BoxDecoration(
      color: context.theme.colorScheme.onPrimaryFixed,
      borderRadius: BorderRadius.circular(1.5.w),
      border:
          Border.all(width: 0.5, color: context.theme.colorScheme.onSecondary),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: title, fontSize: 1.5.h),
        DropdownButton<String>(
          items: items,
          iconSize: 10,
          value: value,
          isDense: true,
          isExpanded: true,
          onChanged: onChanged,
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(1.0.w),
          focusColor: context.theme.colorScheme.surface,
          dropdownColor: context.theme.colorScheme.surface,
          iconEnabledColor: context.theme.colorScheme.onSecondary,
          iconDisabledColor: context.theme.colorScheme.onSecondary,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 1.9.h),
          hint: AppText(
            title: hintValue ?? "--Select--",
            color: context.theme.colorScheme.onSecondary,
          ),
          icon: Icon(size: 3.h, Icons.keyboard_arrow_down_rounded),
        ),
      ],
    ),
  );
}
