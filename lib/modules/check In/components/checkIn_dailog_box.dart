import 'package:digital_lync/modules/check%20In/provider/checkIn_provider.dart';
import 'package:digital_lync/modules/check%20In/screen/checkIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/provider/tracking_provider.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              title: 'Total Date:',
                            ),AppText(
                              title: 'Current Time:',
                            )
                          ],
                        ),
                        SizedBox(width: 4.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              title:  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                            ), AppText(
                              title:  '${DateTime.now().hour}:${DateTime.now().minute}',
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 2.h),
                    provider.isLoading == false
                        ? appButton(
                      context: context,
                      onTap: () {
                        provider.checkInStatus == true ? provider.checkInAPI() : provider.checkOutAPI();
                        provider.checkInStatusBtn = !provider.checkInStatus;
                      },
                      child: AppText(
                        title: provider.checkInStatus ? Constants.checkIn : Constants.checkOut,
                        color: Theme.of(context).colorScheme.background,
                      ),
                      radius: 0.8.h,
                      width: double.infinity,
                      height: 5.h, // Adjust button height
                    )
                        : const Center(
                      child: SpinKitLoader(),
                    ),
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
