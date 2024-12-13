import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/check%20In/components/checkIn_dailog_box.dart';
import 'package:digital_lync/modules/check%20In/provider/checkIn_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  children: [
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              appCircleIcon(
                                context: context,
                                colors: Theme.of(context).colorScheme.scrim,
                                radius: 0.5.h,
                                height: 8.w,
                                width: 8.w,
                                child: SvgPicture.asset(
                                    AppAssets.APP_CHECKING_SVG,
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(width: 3.w),
                              AppText(
                                title: Constants.attendance,
                                fontSize: 1.8.h,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          appOutlineButton(
                            context: context,
                            height: 4.h,
                            radius: 0.6.h,
                            onTap: () {
                              showCheckInDialog(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                    title: checkInStatus
                                        ? Constants.checkIn
                                        : Constants.checkOut),
                                SizedBox(width: 1.h),
                                checkInStatus ? SizedBox() : Icon(Icons.login)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Expanded(
                      child: provider.checkInList.length < 0
                          ? Center(
                              child: AppText(
                                title: Constants.result_not_found,
                              ),
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
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  title:
                                                      '${Constants.user_name} :',
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                AppText(
                                                  title:
                                                      '${Constants.total_working_hour} :',
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                AppText(
                                                  title:
                                                      '${Constants.checkIn} :',
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                AppText(
                                                  title:
                                                      '${Constants.checkOut} :',
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 5.w,
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
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                  AppText(
                                                      title: provider.checkInList[
                                                                      index][
                                                                  'clockOut'] !=
                                                              null
                                                          ? DateFormat('yyyy-MM-dd   h:mm a').format(
                                                              DateTime.parse(provider
                                                                          .checkInList[
                                                                      index]
                                                                  ['clockOut']))
                                                          : 'Remaining check out time',
                                                      fontSize: 1.6.h,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary),
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
                                          context: context, vertical: 1.h),
                                      // index == 9 ? SizedBox() : appDivider(
                                      //     context: context, vertical: 1.h),
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
