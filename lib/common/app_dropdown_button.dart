import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget dropdownWidget(
    {required BuildContext context, required String value, items, onChanged,
      width}) {
  return Container(
    width: width ??double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 2.0.w),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(1.5.w),
        border: Border.all(color: Theme.of(context).colorScheme.onSecondary,width: 0.5)),
    child: DropdownButton<String>(

      iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
      iconDisabledColor: Theme.of(context).colorScheme.onSecondary,
      isExpanded: true,
      underline: const SizedBox(),
      value: value,
      focusColor: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(1.0.w),
      dropdownColor: Theme.of(context).colorScheme.background,

      hint: AppText(
          title: value,
      ),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 3.h,
      ),
      items: items,
      onChanged: onChanged,
    ),
  );
}
