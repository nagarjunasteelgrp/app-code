import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showMapDialogGoogleMap(
    BuildContext context, latitude, longitude, address) {
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
                  : Container(
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: GoogleMap(
                        compassEnabled: false,
                        mapType: MapType.normal,
                        mapToolbarEnabled: false,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        initialCameraPosition: CameraPosition(
                          zoom: 15,
                          target: LatLng(latitude!, longitude!),
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId(address.toString()),
                            position: LatLng(latitude, longitude),
                            infoWindow: InfoWindow(title: address),
                          ),
                        },
                      ),
                    );
            },
          ),
        ),
      );
    },
  );
}
