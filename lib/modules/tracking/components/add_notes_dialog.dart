import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showAddNotesDialog(BuildContext context, {VoidCallback? onTapSave}) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
        value: trackingProvider,
        child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            elevation: 5,
            insetAnimationCurve: Curves.bounceIn,
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Consumer<TrackingProvider>(builder: (context, provider, _) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppText(title: Constants.add_notes),
                    SizedBox(height: 1.h),
                    appTextField(
                        context: context,
                        maxLines: 5,
                        controller: provider.addNotesController),
                    SizedBox(height: 1.h),
                    provider.isLoading == false
                        ? appButton(
                            context: context,
                            width: double.infinity,
                            onTap: () {
                              provider.trackingAddNotes(context);
                            },
                            child: AppText(
                              height: 5.h,
                              title: 'Save',
                              color: Theme.of(context).colorScheme.background,
                            ),
                          )
                        : const Center(child: SpinKitLoader()),
                  ],
                ),
              );
            })),
      );
    },
  );
}
