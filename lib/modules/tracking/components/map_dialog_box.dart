import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showMapDialog(BuildContext context, {VoidCallback? onTapSave}) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
        value: trackingProvider,
        child: Dialog(
          elevation: 5,
          insetAnimationCurve: Curves.bounceIn,
          backgroundColor: context.theme.colorScheme.background,
          insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Consumer<TrackingProvider>(
            builder: (context, provider, _) {
              return latitude == 0.0 || longitude == 0.0
                  ? const Center(child: SpinKitLoader())
                  : Padding(
                      padding: EdgeInsets.all(2.h),
                      child: ChangeNotifierProvider.value(
                        value: CurrentLocationProvider(),
                        child: Consumer<CurrentLocationProvider>(
                            builder: (context, currentLocationProvider, child) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                title: 'Address',
                                color: context.theme.colorScheme.onSecondary,
                              ),
                              SizedBox(height: 0.5.h),
                              (addressPlacement != "")
                                  ? AppText(
                                      maxLines: 5,
                                      title: addressPlacement,
                                      textOverflow: TextOverflow.ellipsis,
                                      color:
                                          context.theme.colorScheme.secondary,
                                    )
                                  : const SizedBox(),
                              SizedBox(height: 1.0.h),
                              Container(
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.h),
                                ),
                                child: GoogleMap(
                                  myLocationEnabled: true,
                                  scrollGesturesEnabled: false,
                                  myLocationButtonEnabled: false,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    currentLocationProvider.mapController =
                                        controller;
                                  },
                                  zoomControlsEnabled: false,
                                  markers: Set.from(provider.markers),
                                  initialCameraPosition: CameraPosition(
                                    zoom: 12.0,
                                    target: LatLng(
                                      latitude ?? 0.0,
                                      longitude ?? 0.0,
                                    ),
                                  ),
                                  gestureRecognizers: <Factory<
                                      OneSequenceGestureRecognizer>>{
                                    Factory<OneSequenceGestureRecognizer>(
                                      () => EagerGestureRecognizer(),
                                    ),
                                  },
                                ),
                              ),
                              SizedBox(height: 2.h),
                              provider.isLoading == false
                                  ? appButton(
                                      height: 5.h,
                                      context: context,
                                      width: double.infinity,
                                      color: context.theme.colorScheme.primary,
                                      onTap: () =>
                                          provider.trackingMap(context),
                                      child: AppText(
                                        title: 'Save',
                                        color: context
                                            .theme.colorScheme.background,
                                      ),
                                    )
                                  : const Center(child: SpinKitLoader()),
                            ],
                          );
                        }),
                      ),
                    );
            },
          ),
        ),
      );
    },
  );
}
