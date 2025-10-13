import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sizer/sizer.dart';

Widget dropdownWidget({
  double? width,
  String? hintValue,
  required String value,
  required BuildContext context,
  required Function(String?) onChanged,
  required List<DropdownMenuItem<String>> items,
}) {
  return Container(
    width: width ?? double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 2.0.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1.5.w),
      color: context.theme.colorScheme.onSurface,
      border: Border.all(
        width: 0.5,
        color: context.theme.colorScheme.onSecondary,
      ),
    ),
    child: DropdownButton<String>(
      value: value,
      items: items,
      isExpanded: true,
      onChanged: onChanged,
      underline: const SizedBox(),
      borderRadius: BorderRadius.circular(1.0.w),
      focusColor: context.theme.colorScheme.background,
      dropdownColor: context.theme.colorScheme.background,
      iconEnabledColor: context.theme.colorScheme.onSecondary,
      iconDisabledColor: context.theme.colorScheme.onSecondary,
      icon: Icon(size: 3.h, Icons.keyboard_arrow_down_rounded),
      hint: AppText(
        title: hintValue ?? "--Select--",
        color: context.theme.colorScheme.onSecondary,
      ),
    ),
  );
}
