import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppDialog {
  AppDialog._();

  static Future<bool> showDialog(BuildContext context,
      {String? title, String? message}) async {
    return await showCupertinoDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: Container(
            padding: EdgeInsets.all(2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                    title: title,
                    maxLines: 2,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 2.h,
                    fontWeight: FontWeight.w700),
                SizedBox(height: 2.h),
                AppText(
                  title: message,
                  textAlign: TextAlign.center,
                  color: Theme.of(context).colorScheme.secondary,
                  maxLines: 3,
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    appButton(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        height: 5.h,
                        width: 25.w,
                        context: context,
                        child: AppText(
                          color: Theme.of(context).colorScheme.background,
                          title: 'No',
                        )),
                    appButton(
                      context: context,
                      height: 5.h,
                      width: 25.w,
                      child: Center(
                        child: AppText(
                            title: 'Yes',
                            color: Theme.of(context).colorScheme.background,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


