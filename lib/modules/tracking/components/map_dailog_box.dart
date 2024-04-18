import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/global.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
          insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          elevation: 5,
          insetAnimationCurve: Curves.bounceIn,
          backgroundColor: Theme.of(context).colorScheme.background,
          child: Consumer<TrackingProvider>(
            builder: (context, provider, _) {
              return latitude == 0.0 || longitude == 0.0
                  ? const Center(
                child: SpinKitLoader(),
              )
                  : Padding(
                padding: EdgeInsets.all(2.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title: 'Address',
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    SizedBox(height: 0.5.h),
                    (addressPlacement != "")
                        ? AppText(
                      title: addressPlacement,
                      color: Theme.of(context).colorScheme.secondary,
                      textOverflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    )
                        : const SizedBox(),
                    SizedBox(height: 1.0.h),
                    Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                      child: GoogleMap(
                        scrollGesturesEnabled: false,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          provider.mapController = controller;
                        },
                        onTap: (LatLng latLng) async {},
                        markers: Set.from(provider.markers),
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude ?? 0.0, longitude ?? 0.0),
                          zoom: 12.0,
                        ),
                     zoomControlsEnabled: false,
                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                          Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer(),
                          ),
                        },
                      ),
                    ),
                    SizedBox(height: 2.h),
                    provider.isLoading == false
                        ? appButton(
                      color: Theme.of(context).colorScheme.primary,
                      context: context,
                      onTap: () {

                        provider.trackingMap(context);
                      },
                      child: AppText(
                        title: 'Save',
                        color: Theme.of(context).colorScheme.background,
                      ),
                      width: double.infinity,
                      height: 5.h,
                    )
                        : const Center(
                      child: SpinKitLoader(),
                    ),
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
