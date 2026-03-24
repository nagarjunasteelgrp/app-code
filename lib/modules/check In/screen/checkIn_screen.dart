import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/constants/global.dart';
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
        body: Consumer<CheckInProvider>(
          builder: (context, provider, child) {
            return provider.isLoading
                ? const Center(child: SpinKitLoader())
                : Column(
                    children: [
                      appDivider(context: context, vertical: 0.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
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
                                    colorFilter: ColorFilter.mode(
                                      context.theme.primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                AppText(
                                  fontSize: 1.8.h,
                                  fontWeight: FontWeight.w500,
                                  title: Constants.attendance,
                                ),
                              ],
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: checkInStatus,
                              builder: (context, value, child) {
                                return appOutlineButton(
                                  height: 4.h,
                                  radius: 0.6.h,
                                  context: context,
                                  onTap: () => showCheckInDialog(context),
                                  child: Row(
                                    spacing: 1.w,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText(
                                        title: value
                                            ? Constants.checkIn
                                            : Constants.checkOut,
                                      ),
                                      value
                                          ? const SizedBox()
                                          : const Icon(Icons.login)
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      appDivider(context: context, vertical: 0.0),
                      Expanded(
                        child: provider.checkInList.isEmpty
                            ? const Center(
                                child:
                                    AppText(title: Constants.result_not_found),
                              )
                            : ListView.separated(
                                padding: EdgeInsets.only(left: 2.h),
                                itemCount: provider.checkInList.length,
                                separatorBuilder: (context, index) =>
                                    appDivider(vertical: 1.h, context: context),
                                itemBuilder: (context, index) {
                                  return Row(
                                    spacing: 5.w,
                                    children: [
                                      Column(
                                        spacing: 1.0.h,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                            title: '${Constants.user_name} :',
                                          ),
                                          AppText(
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                            title:
                                                '${Constants.total_working_hour} :',
                                          ),
                                          AppText(
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                            title: '${Constants.checkIn} :',
                                          ),
                                          AppText(
                                            fontSize: 1.6.h,
                                            fontWeight: FontWeight.w500,
                                            title: '${Constants.checkOut} :',
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 2.h),
                                        child: Column(
                                          spacing: 1.0.h,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              fontSize: 1.6.h,
                                              fontWeight: FontWeight.w600,
                                              title: provider.checkInList[index]
                                                  ['user']['name'],
                                            ),
                                            AppText(
                                              fontSize: 1.6.h,
                                              fontWeight: FontWeight.w600,
                                              title: provider.checkInList[index]
                                                          ['workingHours'] !=
                                                      null
                                                  ? provider.checkInList[index]
                                                          ['workingHours']
                                                      .toStringAsFixed(3)
                                                  : 'Remaining check out time',
                                            ),
                                            AppText(
                                              fontSize: 1.6.h,
                                              fontWeight: FontWeight.w600,
                                              color: context
                                                  .theme.colorScheme.onPrimary,
                                              title: DateTime.tryParse(
                                                          provider.checkInList[
                                                                      index]
                                                                  ['clockIn'] ??
                                                              '') !=
                                                      null
                                                  ? DateFormat(
                                                          'dd-MM-yyyy hh:mm a')
                                                      .format(
                                                      DateTime.parse(provider
                                                                  .checkInList[
                                                              index]['clockIn'])
                                                          .toLocal(),
                                                    )
                                                  : provider.checkInList[index]
                                                          ['clockIn'] ??
                                                      '',
                                            ),
                                            AppText(
                                              fontSize: 1.6.h,
                                              fontWeight: FontWeight.w600,
                                              color: context
                                                  .theme.colorScheme.onPrimary,
                                              title: provider.checkInList[index]
                                                          ['clockOut'] !=
                                                      null
                                                  ? (DateTime.tryParse(
                                                            provider.checkInList[
                                                                    index]
                                                                ['clockOut'],
                                                          ) !=
                                                          null
                                                      ? DateFormat(
                                                          'dd-MM-yyyy hh:mm a',
                                                        ).format(
                                                          DateTime.parse(
                                                            provider.checkInList[
                                                                    index]
                                                                ['clockOut'],
                                                          ).toLocal(),
                                                        )
                                                      : provider.checkInList[
                                                          index]['clockOut'])
                                                  : 'Remaining check out time',
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
