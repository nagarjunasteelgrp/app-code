import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Widget travelSummary() {
  return Consumer<DashboardProvider>(
    builder: (context, provider, child) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.5.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.WHITE_COLOR,
          borderRadius: BorderRadius.circular(1.4.h),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          spacing: 2.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                    fontSize: 20,
                    title: "Travel Summary",
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightBlackColor),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 0.4.h),
                  decoration: BoxDecoration(
                    color: AppColors.WHITE_COLOR,
                    borderRadius: BorderRadius.circular(1.5.h),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                        color:
                            AppColors.lightBlackColor.withValues(alpha: 0.05),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: context.theme.copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: AppColors.purpleColor,
                                onPrimary: Colors.white,
                                onSurface: AppColors.lightBlackColor,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.purpleColor,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        provider
                            .updateActivityLocationForSelectedDate(pickedDate);
                      }
                    },
                    child: const Row(
                      children: [
                        AppText(
                          title: "Date",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.purpleColor,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          size: 20,
                          color: AppColors.purpleColor,
                          Icons.keyboard_arrow_down_sharp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const AppText(
                title: "Activity ",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.lightBlackColor),
            Row(
              children: [
                Expanded(
                  child: Row(
                    spacing: 2.w,
                    children: [
                      SvgPicture.asset(AppAssets.dateSvg),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                              title: "Date",
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightBlackColor,
                              fontSize: 14),
                          const SizedBox(height: 5),
                          AppText(
                              title: provider.dateSelectedActivityLocation
                                  .toString(),
                              fontSize: 12,
                              color: AppColors.tooLightBlackColor),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    spacing: 2.w,
                    children: [
                      SvgPicture.asset(AppAssets.startTimeSvg),
                      Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            fontSize: 14,
                            title: "Start Time",
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightBlackColor,
                          ),
                          AppText(
                            fontSize: 12,
                            color: AppColors.tooLightBlackColor,
                            title: provider.startTimeSelectedActivityLocation ==
                                    null
                                ? "not time"
                                : provider.startTimeSelectedActivityLocation
                                    .toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    spacing: 2.w,
                    children: [
                      SvgPicture.asset(AppAssets.distanceCoveredSvg),
                      Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            fontSize: 14,
                            title: "Distance Covered",
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightBlackColor,
                          ),
                          AppText(
                            fontSize: 12,
                            color: AppColors.tooLightBlackColor,
                            title: provider
                                        .totalDistanceCoveredActivityLocation ==
                                    null
                                ? "not distance"
                                : provider.totalDistanceCoveredActivityLocation
                                    .toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    spacing: 2.w,
                    children: [
                      SvgPicture.asset(AppAssets.locationsVisitedSvg),
                      Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            fontSize: 14,
                            title: "Locations Visited",
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightBlackColor,
                          ),
                          AppText(
                            fontSize: 12,
                            color: AppColors.tooLightBlackColor,
                            title:
                                provider.totalLocationActivityLocation == null
                                    ? "not location"
                                    : provider.totalLocationActivityLocation
                                        .toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            provider.points.isNotEmpty
                ? SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1.5.h),
                      child: GoogleMap(
                        myLocationEnabled: false,
                        tiltGesturesEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        scrollGesturesEnabled: true,
                        rotateGesturesEnabled: true,
                        myLocationButtonEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          provider.mapController = controller;
                        },
                        initialCameraPosition: CameraPosition(
                          zoom: 7.5,
                          target: provider.points.isNotEmpty
                              ? provider.points[0]
                              : const LatLng(0, 0),
                        ),
                        markers: {
                          for (int i = 0; i < provider.points.length; i++)
                            Marker(
                              markerId: MarkerId(i.toString()),
                              position: provider.points[i],
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue),
                              infoWindow: InfoWindow(
                                  title: '${i + 1}',
                                  snippet: provider.addresses[i]),
                            )
                        },
                        polylines: {
                          Polyline(
                            width: 4,
                            color: AppColors.blueColor2,
                            polylineId: const PolylineId('route'),
                            points: provider.routePoints.isNotEmpty
                                ? provider.routePoints
                                : provider.points,
                          )
                        },
                        gestureRecognizers: <Factory<
                            OneSequenceGestureRecognizer>>{
                          Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer()),
                        },
                      ),
                    ),
                  )
                : const Center(
                    child: AppText(
                      title: "No route available for selected date",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.tooLightBlackColor,
                    ),
                  )
          ],
        ),
      );
    },
  );
}
