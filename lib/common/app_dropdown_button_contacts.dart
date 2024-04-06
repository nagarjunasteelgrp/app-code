import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget dropdownContactsWidget({
  required BuildContext context,
  required String value,
  String? title,
  String? hintValue,
  required List<DropdownMenuItem<String>> items,
  required Function(String?) onChanged,
  double? width,
}) {
  return Container(
    width: width ?? double.infinity,
    padding: EdgeInsets.only(left: 3.5.w,right: 5.0.w),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onSurface,
      borderRadius: BorderRadius.circular(1.5.w),
      border: Border.all(
        color: Theme.of(context).colorScheme.onSecondary,
        width: 0.5,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h,),
        AppText(title: title,fontSize: 1.5.h),
        DropdownButton<String>(
          isDense: true,
          iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
          iconDisabledColor: Theme.of(context).colorScheme.onSecondary,
          isExpanded: true,
          underline: const SizedBox(),
          value: value,
          focusColor: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(1.0.w),
          dropdownColor: Theme.of(context).colorScheme.background,
          hint: Text(
            hintValue ?? "--Select--",
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 3.h,
          ),
          items: items,
          style: TextStyle(fontWeight: FontWeight.w800,fontSize: 1.9.h),
          onChanged: onChanged,
        ),
        SizedBox(height: 0.5.h,),
      ],
    ),
  );
}

