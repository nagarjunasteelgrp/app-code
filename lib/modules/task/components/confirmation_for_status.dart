import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void confirmationDialogBox(BuildContext context, TaskProvider provider) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
        value: provider,
        child: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            return Dialog(
              elevation: 5,
              insetAnimationCurve: Curves.bounceIn,
              backgroundColor: context.theme.colorScheme.surface,
              insetPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.5.h),
              ),
              child: SizedBox(
                width: 80.w,
                child: Padding(
                  padding: EdgeInsets.all(2.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AppText(
                          title: 'Are you sure you want to change the status?',
                          fontSize: 2.h,
                          maxLines: 3,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      provider.isLoading == true
                          ? const Center(child: SpinKitLoader())
                          : Row(
                              spacing: 2.w,
                              children: [
                                Expanded(
                                  child: appButton(
                                    context: context,
                                    onTap: () {
                                      provider.followUpsPutUpdateAPI(context);
                                    },
                                    width: double.infinity,
                                    height: 5.5.h,
                                    radius: 1.h,
                                    color: context.theme.colorScheme.primary,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppText(
                                          title: 'Yes',
                                          color:
                                              context.theme.colorScheme.surface,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: appButton(
                                    context: context,
                                    onTap: () {
                                      Get.back();
                                    },
                                    radius: 1.h,
                                    height: 5.5.h,
                                    width: double.infinity,
                                    color: context.theme.colorScheme.primary,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppText(
                                          title: 'No',
                                          color:
                                              context.theme.colorScheme.surface,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
