import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfiled.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

void messageDialogBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.5.h),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        elevation: 5,
        insetAnimationCurve: Curves.bounceIn,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 1.h),
                        AppText(
                            title: "Message",
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 1.6.h),
                        SizedBox(height: 0.8.h),
                        appTextField(context: context,maxLines: 4),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    Flexible(
                      child: appOutlineButton(
                        onTap: (){
                          Get.back();
                        },
                        boxColor: Theme.of(context)
                            .colorScheme
                            .onBackground.withOpacity(0.3),
                        width: double.infinity,
                        height: 4.h,
                        context: context,
                        radius: 1.5.w,
                        child: AppText(
                            title: Constants.cancel,
                            fontSize: 1.5.h,
                            color: Theme.of(context)
                                .colorScheme
                                .primary,
                            fontWeight:
                            FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: 1.w,),
                    Flexible(
                      child: appButton(
                        width: double.infinity,
                        height: 4.h,
                        context: context,
                        radius: 1.5.w,
                        child: AppText(
                            title: "Send",
                            fontSize: 1.5.h,
                            color: Theme.of(context).colorScheme.background,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      );
    },
  );
}