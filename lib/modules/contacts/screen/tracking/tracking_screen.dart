import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/add_notes_dailog.dart';
import 'package:digital_lync/modules/contacts/components/bottomsheet.dart';
import 'package:digital_lync/modules/contacts/components/map_dailog_box.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:digital_lync/modules/contacts/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TrackingCurrentLocationProvider(),
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
            return provider.isLoading == false ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appOutlineButton(
                        context: context,
                        onTap: () {
                          showMapDialog(context);
                          // if (!provider.geoLocationBtn) {
                          //   provider.geoLocationBtn = true;
                          // }
                        },
                        height: 5.5.h,
                        radius: 1.h,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.APP_GEO_LOCATIONS_SVG,
                                color:
                                provider.geoLocationBtn == true ? Theme.of(context)
                                    .colorScheme
                                    .primary.withOpacity(0.5): Theme.of(context)
                                    .colorScheme
                                    .primary),
                            SizedBox(width: 2.w),
                            AppText(
                              title: 'Capture geo location',
                              color: provider.geoLocationBtn == true ? Theme.of(context).colorScheme.primary.withOpacity(0.5) : Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        )),
                    SizedBox(height: 2.h),
                    Consumer<TrackingCurrentLocationProvider>(builder: (context, provider, child) {
                      return appButton(
                          context: context,
                          onTap: () => contactBottomSheet(context,cameraOnTap: (){
                            provider.getImage(context,ImageSource.camera);
                            Get.back();
                          }, galleryOnTap: () {
                            provider.getImage(context,ImageSource.gallery);
                            Get.back();
                          }),
                          height: 5.5.h,
                          radius: 1.h,
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.primary,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppAssets.APP_CAPTURE_IMAGE_SVG,
                                  color: Theme.of(context).colorScheme.background),
                              SizedBox(width: 2.w),
                              AppText(
                                title: 'Capture image',
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ],
                          ));
                    }),
                    SizedBox(height: 2.h),
                    appOutlineButton(
                        context: context,
                        onTap: () {
                          showAddNotesDialog(context);
                        },
                        height: 5.5.h,
                        radius: 1.h,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.APP_ADD_NOTES_SVG,
                                color: Theme.of(context).colorScheme.onPrimary),
                            SizedBox(width: 2.w),
                            AppText(
                              title: 'Add Notes',
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ],
                        )),
                    SizedBox(height: 3.h),
                    provider.geoLocationBtn == true ? Consumer<TrackingCurrentLocationProvider>(builder: (context, provider, child) {
                      print("TrackingCurrentLocationProvider Latitude: ${provider.latitude}");
                      print("TrackingCurrentLocationProvider Longitude: ${provider.longitude}");
                      return provider.latitude == 0.0 || provider.longitude == 0.0  ? const Center(
                        child: SpinKitLoader(),
                      ) :  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(title: 'Address',color: Theme.of(context).colorScheme.onSecondary,),
                          SizedBox(height: 0.5.h),
                          (provider.address != "") ?
                          AppText(title: provider.address,color: Theme.of(context).colorScheme.secondary,textOverflow: TextOverflow.ellipsis,maxLines: 5,) : SizedBox(),
                          SizedBox(height: 1.0.h),
                          Container(
                            height: 25.h,
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
                        ],
                      );
                    }) : SizedBox(),
                    SizedBox(height: 2.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.onBackground),
                        borderRadius: BorderRadius.circular(1.h),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AppAssets.APP_ADD_NOTES_SVG,
                                color: Theme.of(context).colorScheme.secondary),
                            SizedBox(
                              width: 2.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                AppText(
                                  title: 'Note:',
                                  color: Theme.of(context).colorScheme.onSecondary,
                                ),
                                SizedBox(
                                  width: 80.w,
                                  child: AppText(
                                    maxLines: 3,
                                    textOverflow: TextOverflow.ellipsis,
                                    title:
                                    'I met him discuss ms Tata Structural but he need Gp pipes',
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    // AppText(title: 'Address',color: Theme.of(context).colorScheme.onSecondary,),
                    // SizedBox(height: 0.5.h),
                    // AppText(title: 'Manuguru, Manuguru mandal, Bhadradri Kothagudem District, Telangana, 507125, India',color: Theme.of(context).colorScheme.secondary,textOverflow: TextOverflow.ellipsis,maxLines: 5,),
                    // SizedBox(height: 0.5.h),
                    // Image.asset(AppAssets.DUMMY_MAP,scale: 0.1.h,),
                    // SizedBox(height: 3.h),
                    Consumer<TrackingCurrentLocationProvider>(
                      builder: (context, provider, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              title: 'Images',
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            SizedBox(height: 1.h),
                            Container(
                              height: 25.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.3),
                                border: DashedBorder.fromBorderSide(
                                  dashLength: 10,
                                  side: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.4),
                                    width: 2,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(1.h),
                              ),
                              child: provider.image != null ? Image.file(provider.image!,fit: BoxFit.fill) : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 5.h,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.5),
                                    ),
                                    AppText(
                                      title: 'Add Image',
                                      fontSize: 2.5.h,
                                    ),
                                    AppText(
                                      title: 'Less than 1mb, png, jpeg',
                                      fontSize: 2.h,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    // SizedBox(height: 2.h),
                    // Row(
                    //   children: [
                    //     Expanded(child: Center(
                    //       child: appOutlineButton(
                    //         boxColor: Theme.of(context)
                    //             .colorScheme
                    //             .onBackground.withOpacity(0.3),
                    //         width: double.infinity,
                    //         height: 4.h,
                    //         context: context,
                    //         radius: 1.w,
                    //         child: AppText(
                    //             title: Constants.cancel,
                    //             fontSize: 1.5.h,
                    //             color: Theme.of(context)
                    //                 .colorScheme
                    //                 .primary,
                    //             fontWeight:
                    //             FontWeight.w600),
                    //       ),
                    //     ),),
                    //     SizedBox(width: 2.h,),
                    //     Expanded(child: Center(
                    //       child: appButton(
                    //         width: double.infinity,
                    //         height: 4.h,
                    //         context: context,
                    //         radius: 1.w,
                    //         child: AppText(
                    //             title: Constants.submit,
                    //             fontSize: 1.5.h,
                    //             color: Theme.of(context)
                    //                 .colorScheme
                    //                 .background,
                    //             fontWeight:
                    //             FontWeight.w600),
                    //       ),
                    //     ),),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ) : const Center(
              child: SpinKitLoader(),
            );
          }
        ),
      ),
    );
  }
}
