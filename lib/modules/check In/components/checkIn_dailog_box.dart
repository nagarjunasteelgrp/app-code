import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/check%20In/provider/checkIn_provider.dart';
import 'package:digital_lync/modules/check%20In/screen/checkin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showCheckInDialog(BuildContext context, {VoidCallback? onTapSave}) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
        value: checkInProvider,
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          elevation: 5,
          insetAnimationCurve: Curves.bounceIn,
          backgroundColor: Theme.of(context).colorScheme.background,
          child: Consumer<CheckInProvider>(
            builder: (context, provider, _) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.h),
                child: Column(
                  spacing: 2.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      spacing: 4.w,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(title: 'Date:'),
                            AppText(title: 'Current Time:')
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              title:
                                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                            ),
                            AppText(
                              title:
                                  '${DateTime.now().hour}:${DateTime.now().minute}',
                            ),
                          ],
                        )
                      ],
                    ),
                    provider.isLoading == false
                        ? appButton(
                            height: 5.h,
                            radius: 0.8.h,
                            context: context,
                            width: double.infinity,
                            onTap: () {
                              checkInStatus == true
                                  ? provider.checkInAPI()
                                  : provider.checkOutAPI();
                            },
                            child: AppText(
                              title: checkInStatus
                                  ? Constants.checkIn
                                  : Constants.checkOut,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          )
                        : const Center(child: SpinKitLoader()),
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
