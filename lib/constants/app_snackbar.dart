import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void showAppSnackBar(
    {required BuildContext context,
    required String title,
    subtitle,
    ContentType? contentType,
    String? type}) {
  final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: Container(
          decoration: BoxDecoration(
            color: type == 'success' || type == ''
                ? Theme.of(context).colorScheme.inversePrimary
                : Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 1.8.h,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )));
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
