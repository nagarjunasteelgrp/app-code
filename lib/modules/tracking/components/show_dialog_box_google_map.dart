import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showMapDialogGoogleMap(
  BuildContext context,
  double? latitude,
  double? longitude,
  String? address,
) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 300),
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder: (context, animation, secondaryAnimation) {
      return ChangeNotifierProvider.value(
        value: trackingProvider,
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
          child: Consumer<TrackingProvider>(
            builder: (context, provider, _) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: context.theme.colorScheme.surface,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 12,
                      offset: Offset(0, 6),
                      color: Colors.black26,
                    ),
                  ],
                ),
                child: latitude == null ||
                        longitude == null ||
                        latitude == 0.0 ||
                        longitude == 0.0
                    ? SizedBox(
                        height: 30.h,
                        child: const Center(child: SpinKitLoader()),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔹 Header
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            child: Row(
                              spacing: 2.w,
                              children: [
                                Icon(Icons.location_on, color: Colors.red),
                                AppText(
                                  fontSize: 16,
                                  title: 'Selected Location',
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),

                          /// 🔹 Address
                          if (address != null && address.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: AppText(
                                  maxLines: 3,
                                  fontSize: 13,
                                  title: address,
                                  fontWeight: FontWeight.w500,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          SizedBox(height: 2.h),
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(16),
                            ),
                            child: SizedBox(
                              height: 30.h,
                              child: GoogleMap(
                                mapToolbarEnabled: false,
                                zoomControlsEnabled: false,
                                myLocationButtonEnabled: false,
                                initialCameraPosition: CameraPosition(
                                  zoom: 15,
                                  target: LatLng(latitude, longitude),
                                ),
                                markers: {
                                  Marker(
                                    markerId: MarkerId(
                                        address ?? 'selected_location'),
                                    position: LatLng(latitude, longitude),
                                    infoWindow: InfoWindow(title: address),
                                  ),
                                },
                              ),
                            ),
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
