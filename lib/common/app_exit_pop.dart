

import 'dart:io';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Future<bool> showExitPopup(context) async{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to exit?"),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: appButton(context: context, onTap: () {
                        print('yes selected');
                        exit(0);
                      },child: AppText(title: 'Yes',color: Colors.white,),height: 5.h),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: appButton(context: context, onTap: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },child: AppText(title: 'No',color: Colors.white),height: 5.h))
                  ],
                )
              ],
            ),
          ),
        );
      });
}