import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfiled.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showMapDialog(BuildContext context,
    {VoidCallback? onTapSave}) {
  showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: TrackingCurrentLocationProvider(),
          child: Dialog(insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              elevation: 5,
              insetAnimationCurve: Curves.bounceIn,
              backgroundColor: Theme.of(context).colorScheme.background,
              child: Consumer<TrackingCurrentLocationProvider>(
                  builder: (context, provider, _) {
                    return  provider.latitude == 0.0 || provider.longitude == 0.0  ? const Center(
                      child: SpinKitLoader(),
                    ) :  Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(title: 'Address',color: Theme.of(context).colorScheme.onSecondary,),
                          SizedBox(height: 0.5.h),
                          (provider.address != "") ?
                          AppText(title: provider.address,color: Theme.of(context).colorScheme.secondary,textOverflow: TextOverflow.ellipsis,maxLines: 5,) : SizedBox(),
                          SizedBox(height: 1.0.h),
                          Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.h),
                            ),
                            child: GoogleMap(
                              onMapCreated: (GoogleMapController controller) {
                                provider.mapController = controller;
                              },
                              onTap: (LatLng latLng) async{
                                List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
                                Placemark place = placemarks[0];
                                provider.address = "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
                                provider.latitude = latLng.latitude;
                                provider.longitude = latLng.longitude;
                                print("Address:----------------------- ${provider.address} && "
                                    "Latitude: *********************${provider.latitude} && Longitude: **********************${provider.longitude}");
                                provider.addMarker(latLng, provider.address);
                              },
                              markers: Set.from(provider.markers),
                              initialCameraPosition: CameraPosition(
                                target: LatLng(provider.latitude!, provider.longitude!),
                                zoom: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          provider.isLoading == false ? appButton(
                            context: context, onTap: (){
                            provider.trackingMap(context);
                          },child: AppText(title: 'Save',color: Theme.of(context).colorScheme.background,),
                            width: double.infinity,
                            height: 5.h,
                          ) : const Center(
                            child: SpinKitLoader(),
                          ),
                        ],
                      ),
                    );
                  }
              )
          ),
        );
      });
}
