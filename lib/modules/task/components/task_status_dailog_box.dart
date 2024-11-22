import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/task/components/task_dropDown.dart';
import 'package:digital_lync/modules/task/provider/task_provider.dart';
import 'package:digital_lync/modules/task/screen/tabbar_view_screen.dart';
import 'package:digital_lync/modules/task/screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void taskStatusDailogBox(BuildContext context, statusId) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
  value: taskProvider,
  child: Consumer<TaskProvider>(
  builder: (context, provider, child) {
  return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.h),
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
                        Row(
                          children: [
                            appCircleIcon(
                                context: context,
                                colors: Theme.of(context).colorScheme.error,
                                radius: 1.w,
                                height: 3.5.h,
                                width: 3.5.h,
                                child: SvgPicture.asset(AppAssets.APP_ACTIVITIES_SVG, height: 3.h,
                                  fit:  BoxFit.fill,
                                  color: Theme.of(context).colorScheme.background,)
                            ),
                            SizedBox(width: 1.2.h,),
                            AppText(title: 'Task',fontSize: 2.h,),
                            Spacer(),
                            GestureDetector(
                                onTap: (){
                                  Get.back();
                                },
                                child: Icon(Icons.close,size: 2.5.h,)),
                          ],
                        ),
                        SizedBox(height: 0.8.h),
                        taskStatusDropDown(context, provider),
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
                        onTap: (){
                          provider.statusUpdateAPI(statusId).then((value) {
                            showAppSnackBar(type: 'success', context: context, title: 'Status updated successfully');
                          Get.back();
                          });
                        },
                        width: double.infinity,
                        height: 4.h,
                        context: context,
                        radius: 1.5.w,
                        child: AppText(
                            title: "Save",
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
),
);
    },
  );
}