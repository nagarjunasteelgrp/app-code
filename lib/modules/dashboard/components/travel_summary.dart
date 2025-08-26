import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              border: Border.all(color: AppColors.borderColor)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                      title: "Travel Summary",
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: AppColors.lightBlackColor),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.5.h, vertical: 0.4.h),
                    decoration: BoxDecoration(
                      color: AppColors.WHITE_COLOR,
                      borderRadius: BorderRadius.circular(1.5.h),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lightBlackColor.withOpacity(0.05),
                          // very light shadow
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2), // subtle vertical shadow
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
                              data: Theme.of(context).copyWith(
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
                          provider.updateActivityLocationForSelectedDate(
                              pickedDate);
                        }
                      },
                      child: Row(
                        children: [
                          AppText(
                            title: "Date",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.purpleColor,
                          ),
                          const SizedBox(width: 5),
                          const Icon(
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
              SizedBox(height: 2.h),
              AppText(
                  title: "Activity ",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlackColor),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssets.dateSvg),
                        SizedBox(width: 2.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
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
                      children: [
                        SvgPicture.asset(AppAssets.startTimeSvg),
                        SizedBox(width: 2.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                                title: "Start Time",
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightBlackColor,
                                fontSize: 14),
                            const SizedBox(height: 5),
                            AppText(
                                title: provider
                                            .startTimeSelectedActivityLocation ==
                                        null
                                    ? "not time"
                                    : provider.startTimeSelectedActivityLocation
                                        .toString(),
                                fontSize: 12,
                                color: AppColors.tooLightBlackColor),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssets.distanceCoveredSvg),
                        SizedBox(width: 2.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                                title: "Distance Covered",
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightBlackColor,
                                fontSize: 14),
                            const SizedBox(height: 5),
                            AppText(
                                title: provider
                                            .totalDistanceCoveredActivityLocation ==
                                        null
                                    ? "not distance"
                                    : provider
                                        .totalDistanceCoveredActivityLocation
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
                      children: [
                        SvgPicture.asset(AppAssets.locationsVisitedSvg),
                        SizedBox(width: 2.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                                title: "Locations Visited",
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightBlackColor,
                                fontSize: 14),
                            const SizedBox(height: 5),
                            AppText(
                                title: provider.totalLocationActivityLocation ==
                                        null
                                    ? "not location"
                                    : provider.totalLocationActivityLocation
                                        .toString(),
                                fontSize: 12,
                                color: AppColors.tooLightBlackColor),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              provider.points.isNotEmpty
                  ? SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1.5.h),
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            provider.mapController = controller;
                          },
                          initialCameraPosition: CameraPosition(
                            target: provider.points.isNotEmpty
                                ? provider.points[0]
                                : const LatLng(0, 0),
                            zoom: 7.5,
                          ),
                          zoomGesturesEnabled: true,
                          scrollGesturesEnabled: true,
                          rotateGesturesEnabled: true,
                          tiltGesturesEnabled: true,
                          myLocationEnabled: false,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
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
                                onTap: () {
                                  //
                                },
                              )
                          },
                          polylines: {
                            Polyline(
                              polylineId: const PolylineId('route'),
                              points: provider.routePoints.isNotEmpty
                                  ? provider.routePoints
                                  : provider.points,
                              // points: provider.routePoints, // This should be updated after decoding
                              color: AppColors.blueColor2,
                              width: 4,
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
                  : Center(
                      child: AppText(
                        title: "No route available for selected date",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.tooLightBlackColor,
                      ),
                    )
            ],
          ));
    },
  );
}

/*Future<List<LatLng>> getRoutePointsFromDirectionsAPI(
    LatLng origin, LatLng destination, String apiKey) async {
  final String url =
      'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data['routes'].isNotEmpty) {
      final String encodedPolyline =
      data['routes'][0]['overview_polyline']['points'];
      return decodePolyline(encodedPolyline);
    } else {
      throw Exception('No routes found');
    }
  } else {
    throw Exception('Failed to fetch directions');
  }
}*/

List<LatLng> decodePolyline(String encoded) {
  List<LatLng> polylinePoints = [];
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lng += dlng;

    polylinePoints.add(LatLng(lat / 1e5, lng / 1e5));
  }

  return polylinePoints;
}
