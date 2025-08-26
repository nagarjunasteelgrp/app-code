import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.5.h),
              ),
              insetPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              elevation: 5,
              insetAnimationCurve: Curves.bounceIn,
              backgroundColor: Theme.of(context).colorScheme.background,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
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
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 1.8.h,
                          ),
                          SizedBox(height: 2.h),
                          // Date Picker
                          AppText(
                            title: "Dealer",
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.secondary,
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(0.8.h),
                            ),
                            child: Text(
                              provider.dealerName!,
                              style: TextStyle(
                                fontSize: 1.5.h,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          // Date Picker
                          AppText(
                            title: "Select Date",
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 1.6.h,
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
                                          splashColor: Colors.green),
                                      child: child!);
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(0.8.h),
                              ),
                              child: Text(
                                provider.selectedDate != null
                                    ? "${provider.selectedDate!.day}-${provider.selectedDate!.month}-${provider.selectedDate!.year}" // Display formatted date
                                    : "Select a date",
                                style: TextStyle(
                                  fontSize: 1.5.h,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 1.5.h),

                          // Note Text Field
                          AppText(
                            title: "Add Note",
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 1.6.h,
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
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: provider.isLoading
                          ? const Center(child: SpinKitLoader())
                          : Row(
                              children: [
                                Flexible(
                                  child: appOutlineButton(
                                    onTap: () {
                                      provider.noteController.clear();
                                      Get.back();
                                    },
                                    boxColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.3),
                                    width: double.infinity,
                                    height: 4.h,
                                    context: context,
                                    radius: 1.5.w,
                                    child: AppText(
                                      title: Constants.cancel,
                                      fontSize: 1.5.h,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 1.w),
                                Flexible(
                                  child: appButton(
                                    onTap: () {
                                      if (provider.selectedDate != null) {
                                        {
                                          provider.followUpsAPI(context);
                                        }
                                      }
                                    },
                                    width: double.infinity,
                                    height: 4.h,
                                    context: context,
                                    radius: 1.5.w,
                                    child: AppText(
                                      title: "Save",
                                      fontSize: 1.5.h,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      fontWeight: FontWeight.w600,
                                    ),
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
