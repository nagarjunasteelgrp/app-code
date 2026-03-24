import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showMapDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 350),
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return ChangeNotifierProvider.value(
        value: CurrentLocationProvider(),
        child: Builder(
          builder: (context) {
            // Start location fetching immediately when dialog opens
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<CurrentLocationProvider>().startLocationFetching();
            });

            return ChangeNotifierProvider.value(
              value: trackingProvider,
              child: Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 2.w),
                backgroundColor: context.theme.colorScheme.surface,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(title: 'Address', fontWeight: FontWeight.w600),
                      SizedBox(height: 0.5.h),
                      Consumer<CurrentLocationProvider>(
                        builder: (_, value, __) {
                          return AppText(
                            maxLines: 3,
                            fontWeight: FontWeight.w700,
                            textOverflow: TextOverflow.ellipsis,
                            title: value.address ?? 'Fetching location...',
                          );
                        },
                      ),
                      SizedBox(height: 1.5.h),
                      SizedBox(
                        height: 35.h,
                        width: double.infinity,
                        child: Consumer<CurrentLocationProvider>(
                          builder: (context, currentLocationProvider, _) {
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                GoogleMap(
                                  myLocationEnabled: true,
                                  zoomControlsEnabled: false,
                                  onMapCreated: (controller) {
                                    currentLocationProvider.mapController =
                                        controller;

                                    if (currentLocationProvider.latitude !=
                                            null &&
                                        currentLocationProvider.longitude !=
                                            null) {
                                      controller.animateCamera(
                                        CameraUpdate.newLatLngZoom(
                                          LatLng(
                                            currentLocationProvider.latitude!,
                                            currentLocationProvider.longitude!,
                                          ),
                                          15,
                                        ),
                                      );
                                    }
                                  },
                                  initialCameraPosition: CameraPosition(
                                    zoom: 5,
                                    target: LatLng(
                                      currentLocationProvider.latitude ?? 0,
                                      currentLocationProvider.longitude ?? 0,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: currentLocationProvider
                                          .isFetchingLocation
                                      ? Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: context
                                                .theme.colorScheme.surface,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator
                                                .adaptive(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: currentLocationProvider
                                              .fetchLiveLocation,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: context
                                                  .theme.colorScheme.surface,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.satellite_alt_rounded,
                                              color: context
                                                  .theme.colorScheme.primary,
                                            ),
                                          ),
                                        ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Consumer2<TrackingProvider, CurrentLocationProvider>(
                        builder:
                            (context, trackingProvider, locationProvider, _) {
                          return locationProvider.isFetchingLocation
                              ? appButton(
                                  height: 5.h,
                                  width: double.infinity,
                                  context: context,
                                  onTap: null,
                                  child: AppText(
                                    title: 'Getting Location...',
                                    fontWeight: FontWeight.w900,
                                    color: context.theme.colorScheme.surface,
                                  ),
                                )
                              : !locationProvider.isLocationValid
                                  ? appButton(
                                      height: 5.h,
                                      width: double.infinity,
                                      context: context,
                                      onTap: () {
                                        locationProvider.fetchLiveLocation();
                                      },
                                      child: AppText(
                                        title: 'Try Again',
                                        fontWeight: FontWeight.w900,
                                        color:
                                            context.theme.colorScheme.surface,
                                      ),
                                    )
                                  : appButton(
                                      height: 5.h,
                                      width: double.infinity,
                                      context: context,
                                      onTap: () {
                                        trackingProvider.trackingMap(
                                          context,
                                          latitude:
                                              locationProvider.latitude ?? 0.0,
                                          longitude:
                                              locationProvider.longitude ?? 0.0,
                                          addressPlacement:
                                              locationProvider.address ?? '',
                                        );
                                      },
                                      child: AppText(
                                        title: 'Save',
                                        fontWeight: FontWeight.w900,
                                        color:
                                            context.theme.colorScheme.surface,
                                      ),
                                    );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
