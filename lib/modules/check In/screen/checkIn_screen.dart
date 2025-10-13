import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/check%20In/provider/checkIn_provider.dart';
import 'package:digital_lync/modules/check%20in/components/check_in_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

CheckInProvider checkInProvider = CheckInProvider();

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    checkInProvider.checkInListAPI();
    return ChangeNotifierProvider.value(
      value: checkInProvider,
      child: Scaffold(
        body: Consumer<CheckInProvider>(builder: (context, provider, child) {
          return provider.isLoading
              ? const Center(child: SpinKitLoader())
              : Column(
                  spacing: 3.h,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 3.w,
                            children: [
                              appCircleIcon(
                                width: 8.w,
                                height: 8.w,
                                radius: 0.5.h,
                                context: context,
                                colors: context.theme.colorScheme.scrim,
                                child: SvgPicture.asset(
                                    AppAssets.APP_CHECKING_SVG,
                                    color: context.theme.primaryColor),
                              ),
                              AppText(
                                fontSize: 1.8.h,
                                fontWeight: FontWeight.w500,
                                title: Constants.attendance,
                              ),
                            ],
                          ),
                          appOutlineButton(
                            height: 4.h,
                            radius: 0.6.h,
                            context: context,
                            onTap: () => showCheckInDialog(context),
                            child: Row(
                              spacing: 1.w,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  title: checkInStatus
                                      ? Constants.checkIn
                                      : Constants.checkOut,
                                ),
                                checkInStatus
                                    ? const SizedBox()
                                    : const Icon(Icons.login)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: provider.checkInList.isEmpty
                          ? const Center(
                              child: AppText(title: Constants.result_not_found),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    provider.checkInList.length, (index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 2.h),
                                        child: Row(
                                          spacing: 5.w,
                                          children: [
                                            Column(
                                              spacing: 1.0.h,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  title:
                                                      '${Constants.user_name} :',
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                AppText(
                                                  fontSize: 1.6.h,
                                                  title:
                                                      '${Constants.total_working_hour} :',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                AppText(
                                                  fontSize: 1.6.h,
                                                  title:
                                                      '${Constants.checkIn} :',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                AppText(
                                                  fontSize: 1.6.h,
                                                  title:
                                                      '${Constants.checkOut} :',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 2.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    title: provider
                                                            .checkInList[index]
                                                        ['user']['name'],
                                                    fontSize: 1.6.h,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                  AppText(
                                                    title: provider.checkInList[
                                                                    index][
                                                                'workingHours'] !=
                                                            null
                                                        ? provider
                                                            .checkInList[index]
                                                                ['workingHours']
                                                            .toStringAsFixed(3)
                                                        : 'Remaining check out time',
                                                    fontSize: 1.6.h,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                  AppText(
                                                    title: DateFormat(
                                                            'yyyy-MM-dd   h:mm a')
                                                        .format(DateTime.parse(
                                                            provider.checkInList[
                                                                    index]
                                                                ['clockIn'])),
                                                    fontSize: 1.6.h,
                                                    fontWeight: FontWeight.w600,
                                                    color: context.theme
                                                        .colorScheme.onPrimary,
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                  AppText(
                                                    title: provider.checkInList[
                                                                    index]
                                                                ['clockOut'] !=
                                                            null
                                                        ? DateFormat(
                                                                'yyyy-MM-dd   h:mm a')
                                                            .format(DateTime.parse(
                                                                provider.checkInList[
                                                                        index][
                                                                    'clockOut']))
                                                        : 'Remaining check out time',
                                                    fontSize: 1.6.h,
                                                    fontWeight: FontWeight.w600,
                                                    color: context.theme
                                                        .colorScheme.onPrimary,
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      appDivider(
                                        vertical: 1.h,
                                        context: context,
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
