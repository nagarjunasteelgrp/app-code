import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/check%20In/screen/checkin_screen.dart';
import 'package:digital_lync/modules/check%20In/provider/checkIn_provider.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showCheckInDialog(BuildContext context, {VoidCallback? onTapSave}) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
        value: checkInProvider,
        child: Dialog(
          elevation: 5,
          insetAnimationCurve: Curves.bounceIn,
          backgroundColor: context.theme.colorScheme.surface,
          insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Consumer<CheckInProvider>(
            builder: (context, provider, _) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.h),
                child: Column(
                  spacing: 2.h,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 4.w,
                      children: [
                        Column(
                          spacing: 1.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(title: 'Date:'),
                            AppText(title: 'Current Time:')
                          ],
                        ),
                        Column(
                          spacing: 1.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              title: DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now()),
                            ),
                            AppText(
                              title:
                                  DateFormat('hh:mm a').format(DateTime.now()),
                            ),
                          ],
                        )
                      ],
                    ),
                    provider.isLoading == false
                        ? ValueListenableBuilder<bool>(
                            valueListenable: checkInStatus,
                            builder: (context, value, child) => appButton(
                              height: 5.h,
                              radius: 0.8.h,
                              context: context,
                              width: double.infinity,
                              onTap: () {
                                value
                                    ? provider.checkInAPI()
                                    : provider.checkOutAPI();
                                context.read<HomeProvider>().matchUserToken();
                              },
                              child: AppText(
                                title: value
                                    ? Constants.checkIn
                                    : Constants.checkOut,
                                color: context.theme.colorScheme.surface,
                              ),
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
