// ignore_for_file: must_be_immutable

import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/auth/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CommonCheckbox extends StatefulWidget {
  final String label;
  const CommonCheckbox({super.key, required this.label});
  @override
  CommonCheckboxState createState() => CommonCheckboxState();
}

class CommonCheckboxState extends State<CommonCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                value.toggleCheckbox();
              },
              child: value.isChecked == false
                  ? Icon(Icons.check_box_outline_blank_rounded,
                  color: Theme.of(context).colorScheme.inverseSurface)
                  : Icon(Icons.check_box_rounded,
                  color: Theme.of(context).colorScheme.inverseSurface),
            ),
            SizedBox(width: 2.w),
            AppText(title: widget.label),
          ],
        );
      },
    );
  }
}
