import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/tracking/components/add_notes_dailog.dart';
import 'package:digital_lync/modules/tracking/components/bottomsheet.dart';
import 'package:digital_lync/modules/tracking/components/map_dailog_box.dart';
import 'package:digital_lync/modules/tracking/components/tracking_list.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
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
              title: username.toString(),
              leadingArrow: true,
              actions: const [],
              onTap: () {
                Get.back();
              },
            ),
            body:
                Consumer<TrackingProvider>(builder: (context, provider, child) {
              return provider.isLoading == false
                  ? SingleChildScrollView(
                controller: trackingProvider.scrollController,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.h, vertical: 2.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.5.h),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    title: provider.contactTypeCompanyName,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 2.h,
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    children: [
                                      AppText(title: 'Contact Type :'),
                                      SizedBox(width: 1.h),
                                      AppText(title: provider.contactTypeName),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            appOutlineButton(
                                context: context,
                                onTap: () {
                                  addressPlacement != null
                                      ? showMapDialog(context)
                                      : null;
                                  if (!provider.geoLocationBtn) {
                                    provider.geoLocationBtn = true;
                                  }
                                },
                                height: 5.5.h,
                                radius: 1.h,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        AppAssets.APP_GEO_LOCATIONS_SVG,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    SizedBox(width: 2.w),
                                    AppText(
                                      title: 'Capture geo location',
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ],
                                )),
                            SizedBox(height: 2.h),
                            TrackingListScreen(),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: SpinKitLoader(),
                    );
            })),
      ),
    );
  }
}
