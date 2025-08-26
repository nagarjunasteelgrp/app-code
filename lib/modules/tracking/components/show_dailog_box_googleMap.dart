import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:flutter/material.dart';
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
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 250,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude!, longitude!),
                          zoom: 15,
                        ),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                        mapType: MapType.normal,
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
