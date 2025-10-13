import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void followUpDialogBox(BuildContext context, TrackingProvider provider) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
        value: provider,
        child: Consumer<TrackingProvider>(
          builder: (context, provider, child) {
            return Dialog(
              elevation: 5,
              insetAnimationCurve: Curves.bounceIn,
              backgroundColor: context.theme.colorScheme.background,
              insetPadding:EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.5.h),),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  spacing: 2.h,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          AppText(
                            title: "Follow-Up",
                            fontWeight: FontWeight.w600,
                            color: context.theme.colorScheme.secondary,
                            fontSize: 1.8.h,
                          ),
                          SizedBox(height: 2.h),
                          // Date Picker
                          AppText(
                            title: "Dealer",
                            fontWeight: FontWeight.w600,
                            color: context.theme.colorScheme.secondary,
                            fontSize: 1.6.h,
                          ),
                          SizedBox(height: 0.5.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 1.5.h,
                              horizontal: 3.w,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: context.theme.colorScheme.secondary
                                      .withValues(alpha: 0.3)),
                              borderRadius: BorderRadius.circular(0.8.h),
                            ),
                            child: AppText(
                              title: provider.dealerName!,
                              fontSize: 1.5.h,
                              color: context.theme.hintColor,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          AppText(
                            fontSize: 1.6.h,
                            title: "Select Date",
                            fontWeight: FontWeight.w600,
                            color: context.theme.colorScheme.secondary,
                          ),
                          SizedBox(height: 0.5.h),
                          GestureDetector(
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    provider.selectedDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData(
                                      primarySwatch: Colors.red,
                                      splashColor: Colors.green,
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (selectedDate != null) {
                                provider.updateSelectedDate(selectedDate);
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 1.5.h,
                                horizontal: 3.w,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: context.theme.colorScheme.secondary
                                      .withValues(alpha: 0.3),
                                ),
                                borderRadius: BorderRadius.circular(0.8.h),
                              ),
                              child: AppText(
                                fontSize: 1.5.h,
                                color: context.theme.hintColor,
                                title: provider.selectedDate != null
                                    ? "${provider.selectedDate!.day}-${provider.selectedDate!.month}-${provider.selectedDate!.year}"
                                    : "Select a date",
                              ),
                            ),
                          ),

                          SizedBox(height: 1.5.h),
                          // Note Text Field
                          AppText(
                            fontSize: 1.6.h,
                            title: "Add Note",
                            fontWeight: FontWeight.w600,
                            color: context.theme.colorScheme.secondary,
                          ),
                          SizedBox(height: 0.5.h),
                          appTextField(
                            context: context,
                            maxLines: 4,
                            controller: provider.noteController,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: provider.isLoading
                          ? const Center(child: SpinKitLoader())
                          : Row(
                              children: [
                                Flexible(
                                  child: appOutlineButton(
                                    height: 4.h,
                                    radius: 1.5.w,
                                    context: context,
                                    width: double.infinity,
                                    onTap: () {
                                      provider.noteController.clear();
                                      Get.back();
                                    },
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
                                SizedBox(width: 1.w),
                                Flexible(
                                  child: appButton(
                                    height: 4.h,
                                    radius: 1.5.w,
                                    context: context,
                                    width: double.infinity,
                                    onTap: () {
                                      if (provider.selectedDate != null) {
                                        {
                                          provider.followUpsAPI(context);
                                        }
                                      }
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
