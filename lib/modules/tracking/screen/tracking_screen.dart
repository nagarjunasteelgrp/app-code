import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/tracking/components/add_notes_dailog.dart';
import 'package:digital_lync/modules/tracking/components/bottomsheet.dart';
import 'package:digital_lync/modules/tracking/components/map_dailog_box.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

TrackingProvider trackingProvider = TrackingProvider();

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: trackingProvider,
      child: Scaffold(
        body: Consumer<TrackingProvider>(
            builder: (context, provider, child) {
              return provider.isLoading == false ?
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appOutlineButton(
                          context: context,
                          onTap: () {
                            showMapDialog(context);
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
                                  color: provider.geoLocationBtn == true
                                      ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5)
                                      : Theme.of(context)
                                      .colorScheme
                                      .primary),
                              SizedBox(width: 2.w),
                              AppText(
                                title: 'Capture geo location',
                                color: provider.geoLocationBtn == true
                                    ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5)
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      Consumer<TrackingProvider>(
                          builder: (context, provider, child) {
                            return appButton(
                                context: context,
                                onTap: () =>
                                provider.trackingInfoId != 0  ?
                                contactBottomSheet(context,
                                    cameraOnTap: () {
                                      provider.getImage(
                                          context, ImageSource.camera);
                                      Get.back();
                                    }, galleryOnTap: () {
                                      provider.getImage(
                                          context, ImageSource.gallery);
                                      Get.back();
                                    })
                                : {},
                                height: 5.5.h,
                                radius: 1.h,
                                width: double.infinity,
                                color: provider.geoLocationBtn == true
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        AppAssets.APP_CAPTURE_IMAGE_SVG,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                    SizedBox(width: 2.w),
                                    AppText(
                                      title: 'Capture image',
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  ],
                                ));
                          }),
                      SizedBox(height: 2.h),
                      appOutlineButton(
                          context: context,
                          onTap: () {
                            provider.trackingInfoId != 0 ?
                            showAddNotesDialog(context)
                            : SizedBox();
                          },
                          height: 5.5.h,
                          radius: 1.h,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppAssets.APP_ADD_NOTES_SVG,
                                  color: provider.geoLocationBtn == true
                                      ? Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      : Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.5)),
                              SizedBox(width: 2.w),
                              AppText(
                                title: 'Add Notes',
                                color: provider.geoLocationBtn == true
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.5),
                              ),
                            ],
                          )),
                      SizedBox(height: 3.h),
                      provider.trackingInfoId != 0
                          ? Consumer<TrackingProvider>(
                          builder: (context, provider, child) {
                            print(
                                "TrackingProvider Latitude: ${provider.latitude}");
                            print(
                                "TrackingProvider Longitude: ${provider.longitude}");
                            return  Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  title: 'Address',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary,
                                ),
                                SizedBox(height: 0.5.h),
                                (provider.address != "")
                                    ? AppText(
                                    title: provider.address,
                                    color: Theme.of(context).colorScheme.secondary,
                                    textOverflow:
                                    TextOverflow.ellipsis,
                                    maxLines: 5)
                                    : SizedBox(),
                                SizedBox(height: 1.0.h),
                                Container(
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(2.h),
                                  ),
                                  child: GoogleMap(
                                    onMapCreated: (GoogleMapController
                                    controller) {
                                      provider.setMapController (controller);
                                    },
                                    // markers:
                                    // Set.from(provider.markers.map((marker) {
                                    //   return Marker(markerId: marker['marker_id'],);
                                    //
                                    // })),
                                    initialCameraPosition:
                                    CameraPosition(
                                      target: LatLng(
                                          provider.latitude!,
                                          provider.longitude!),
                                      zoom: 15,
                                    ),
                                    zoomControlsEnabled: false,
                                    compassEnabled: false,
                                    myLocationButtonEnabled: false,
                                    mapToolbarEnabled: false,
                                    mapType: MapType.normal,
                                  ),
                                ),
                              ],
                            );
                          })
                          : SizedBox(),
                      SizedBox(height: 1.h,),
                      provider.trackingInfoId != 0 ? Column(
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
                      ) : SizedBox(),
                      provider.trackingInfoId != 0 ? AppText(
                        title: 'Images',
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary,
                      ) : SizedBox(),
                      SizedBox(height: 0.5.h),
                      provider.trackingInfoId != 0  ? Column(
                        children: List.generate(
                            provider.trackingInfoImagesList
                                .length, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Container(
                              height: 25.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.3),
                                border: DashedBorder
                                    .fromBorderSide(
                                  dashLength: 10,
                                  side: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.4),
                                    width: 2,
                                  ),
                                ),
                                borderRadius:
                                BorderRadius.circular(
                                    1.h),
                              ),
                              child: Image.network(
                                  provider.trackingInfoImagesList[index]['imgSrc']!,
                                  fit: BoxFit.fill),
                            ),
                          );
                        }),
                      ) : SizedBox(),
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


