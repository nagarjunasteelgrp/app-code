import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void messageDialogBox(BuildContext context, TaskProvider provider) {
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.5.h),
              ),
              backgroundColor: context.theme.colorScheme.background,
              insetPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  spacing: 2.h,
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
                                fontSize: 1.6.h,
                                title: "Message",
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.secondary,
                              ),
                              SizedBox(height: 0.8.h),
                              appTextField(
                                maxLines: 4,
                                context: context,
                                controller: provider.sendMessageController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: provider.isLoading == true
                          ? const Center(child: SpinKitLoader())
                          : Row(
                              spacing: 1.w,
                              children: [
                                Flexible(
                                  child: appOutlineButton(
                                    height: 4.h,
                                    radius: 1.5.w,
                                    context: context,
                                    width: double.infinity,
                                    onTap: () => Get.back(),
                                    boxColor: context
                                        .theme.colorScheme.onBackground
                                        .withValues(alpha: 0.3),
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      title: Constants.cancel,
                                      fontWeight: FontWeight.w600,
                                      color: context.theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: appButton(
                                    height: 4.h,
                                    radius: 1.5.w,
                                    context: context,
                                    width: double.infinity,
                                    onTap: () {
                                      provider.sendMessage().then((_) {
                                        provider.sendMessageController.clear();
                                        showAppSnackBar(
                                          type: 'success',
                                          context: context,
                                          title: 'Message sent successfully.',
                                        );
                                        return provider.messageFetching();
                                      }).then((_) => Get.back());
                                    },
                                    child: AppText(
                                      title: "Save",
                                      fontSize: 1.5.h,
                                      color:
                                          context.theme.colorScheme.background,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
