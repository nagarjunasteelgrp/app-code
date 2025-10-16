import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/task/components/task_drop_down.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void taskStatusDialogBox(BuildContext context, statusId) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
        value: taskProvider,
        child: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            return Dialog(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.h),
              ),
              insetAnimationCurve: Curves.bounceIn,
              backgroundColor: context.theme.colorScheme.background,
              insetPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      spacing: 2..h,
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
                              Row(
                                spacing: 1.2.h,
                                children: [
                                  appCircleIcon(
                                    radius: 1.w,
                                    width: 3.5.h,
                                    height: 3.5.h,
                                    context: context,
                                    colors: context.theme.colorScheme.error,
                                    child: SvgPicture.asset(
                                      AppAssets.APP_ACTIVITIES_SVG,
                                      height: 3.h,
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                        context.theme.colorScheme.background,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  AppText(title: 'Task', fontSize: 2.h),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () => Get.back(),
                                    child: Icon(Icons.close, size: 2.5.h),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.8.h),
                              taskStatusDropDown(context, provider),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        spacing: 1.w,
                        children: [
                          Flexible(
                            child: appOutlineButton(
                              height: 4.h,
                              radius: 1.5.w,
                              context: context,
                              width: double.infinity,
                              onTap: () => Get.back(),
                              boxColor: context.theme.colorScheme.onBackground
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
                              context: context,
                              width: double.infinity,
                              onTap: () {
                                provider
                                    .statusUpdateAPI(statusId)
                                    .then((value) {
                                  showAppSnackBar(
                                    type: 'success',
                                    context: context,
                                    title: 'Status updated successfully',
                                  );
                                  Get.back();
                                });
                              },
                              radius: 1.5.w,
                              child: AppText(
                                title: "Save",
                                fontSize: 1.5.h,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.background,
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
