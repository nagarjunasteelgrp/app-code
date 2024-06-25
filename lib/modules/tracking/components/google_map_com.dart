


import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
Widget googleMapCom(latitude,longitude,address) {
  print("=================$latitude");
  return SizedBox(
    height: 200,
    child:
    GoogleMap(
      initialCameraPosition:
      CameraPosition(
        target: LatLng(
            latitude,
          longitude),
        zoom: 15,
      ),
      zoomControlsEnabled: false,
      compassEnabled: false,
      myLocationButtonEnabled:
      false,
      mapToolbarEnabled: false,
      mapType: MapType.normal,
      markers: {
        Marker(
          markerId: MarkerId(address.toString()),
          position: LatLng(
            latitude,
             longitude),
          infoWindow: InfoWindow(
              title: address),
        ),
      },
    ),
  );
}*/


Widget googleMapAddress (address) {
  return SizedBox(
    height: 200,
    child: AppText()
  );
}
