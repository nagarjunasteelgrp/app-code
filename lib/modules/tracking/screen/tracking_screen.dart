import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/tracking/components/map_dialog_box.dart';
import 'package:digital_lync/modules/tracking/components/tracking_list.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

TrackingProvider trackingProvider = TrackingProvider(CurrentLocationProvider());

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: CurrentLocationProvider(),
      child: ChangeNotifierProvider.value(
        value: trackingProvider,
        child: Scaffold(
          appBar: CommonAppBar(
            leadingArrow: true,
            onTap: () => Get.back(),
            title: username.toString(),
          ),
          body: Consumer<TrackingProvider>(builder: (context, provider, child) {
            return provider.isLoading == false
                ? SingleChildScrollView(
                    controller: trackingProvider.scrollController,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: Column(
                        spacing: 2.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.h,
                              horizontal: 2.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.5.h),
                              border: Border.all(
                                color: context.theme.colorScheme.onBackground,
                              ),
                            ),
                            child: Column(
                              spacing: 1.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  fontSize: 2.h,
                                  fontWeight: FontWeight.bold,
                                  title: provider.contactTypeCompanyName,
                                ),
                                Row(
                                  spacing: 1.h,
                                  children: [
                                    const AppText(title: 'Contact Type :'),
                                    AppText(title: provider.contactTypeName),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          appOutlineButton(
                            radius: 1.h,
                            height: 5.5.h,
                            context: context,
                            width: double.infinity,
                            onTap: () => showMapDialog(context),
                            child: Row(
                              spacing: 2.w,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.APP_GEO_LOCATIONS_SVG,
                                  colorFilter: ColorFilter.mode(
                                    context.theme.colorScheme.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                AppText(
                                  title: 'Capture geo location',
                                  color: context.theme.colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                          const TrackingListScreen(),
                        ],
                      ),
                    ),
                  )
                : const Center(child: SpinKitLoader());
          }),
        ),
      ),
    );
  }
}
