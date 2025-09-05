import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/provider/tracking_contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

TrackingCurrentLocationProvider trackingCurrentLocationProvider =
    TrackingCurrentLocationProvider();

class TrackingContactScreen extends StatelessWidget {
  const TrackingContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: trackingCurrentLocationProvider,
      child: Scaffold(
        appBar: CommonAppBar(
          title: Constants.APP_NAME,
          leadingArrow: true,
          actions: const [],
          onTap: () {
            Get.back();
          },
        ),
        body: Consumer<TrackingCurrentLocationProvider>(
            builder: (context, provider, child) {
          return provider.isLoading == false
              ? SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<TrackingCurrentLocationProvider>(
                            builder: (context, provider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                title: 'Address',
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                              SizedBox(height: 0.5.h),
                              (provider.address != "")
                                  ? AppText(
                                      title: provider.address,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      textOverflow: TextOverflow.ellipsis,
                                      maxLines: 5)
                                  : const SizedBox(),
                              SizedBox(height: 1.0.h),
                              Container(
                                height: 25.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.h),
                                ),
                                child: GoogleMap(
                                  onMapCreated: (controller) {
                                    provider.mapController = controller;
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: provider.initialPosition!,
                                    zoom: 15.0,
                                  ),
                                  zoomControlsEnabled: false,
                                  compassEnabled: false,
                                  myLocationButtonEnabled: false,
                                  mapToolbarEnabled: false,
                                  mapType: MapType.normal,
                                  markers: {
                                    Marker(
                                      markerId:
                                          const MarkerId('selected-location'),
                                      position: provider.initialPosition!,
                                      infoWindow: InfoWindow(
                                        title: provider.address,
                                      ),
                                    ),
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: 1.h,
                        ),
                        Column(
                          children: List.generate(
                              provider.trackingInfoNotesList.length, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                  borderRadius: BorderRadius.circular(1.h),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.w, vertical: 1.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                          AppAssets.APP_ADD_NOTES_SVG,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          AppText(
                                            title: 'Note:',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                          SizedBox(
                                            width: 80.w,
                                            child: AppText(
                                              maxLines: 3,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                              title: provider
                                                      .trackingInfoNotesList[
                                                  index]['description'],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        AppText(
                          title: 'Images',
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        SizedBox(height: 0.5.h),
                        Column(
                          children: List.generate(
                              provider.trackingInfoImagesList.length, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Container(
                                height: 25.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withValues(alpha: 0.3),
                                  border: DashedBorder.fromBorderSide(
                                    dashLength: 10,
                                    side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withValues(alpha: 0.4),
                                      width: 2,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(1.h),
                                ),
                                child: Image.network(
                                    provider.trackingInfoImagesList[index]
                                        ['imgSrc']!,
                                    fit: BoxFit.fill),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: SpinKitLoader(),
                );
        }),
      ),
    );
  }
}
