import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showAddNotesDialog(BuildContext context, {VoidCallback? onTapSave}) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
        value: trackingProvider,
        child: Dialog(
          elevation: 5,
          insetAnimationCurve: Curves.bounceIn,
          backgroundColor: context.theme.colorScheme.surface,
          insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Consumer<TrackingProvider>(
            builder: (context, provider, _) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.h),
                child: Column(
                  spacing: 1.h,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(title: Constants.add_notes),
                    appTextField(
                      maxLines: 5,
                      context: context,
                      hint: 'Add your description',
                      controller: provider.addNotesController,
                    ),
                    provider.isLoading == false
                        ? appButton(
                            context: context,
                            width: double.infinity,
                            child: AppText(
                              title: 'Save',
                              fontSize: 1.8.h,
                              color: context.theme.colorScheme.surface,
                            ),
                            onTap: () => provider.trackingAddNotes(context),
                          )
                        : const Center(child: SpinKitLoader()),
                    SizedBox(height: 1.h)
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
