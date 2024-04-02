import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

void contactBottomSheet(BuildContext context,
    {VoidCallback? cameraOnTap, VoidCallback? galleryOnTap}) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 15.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 3.h),
                     AppText(title: Constants.select_Image_Source,color:  Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
                     SizedBox(height: 1.3.h),
                     GestureDetector(
                         onTap: cameraOnTap,
                         child: AppText(title: Constants.use_Camera,color:  Theme.of(context).colorScheme.secondary,fontSize: 1.7.h)),
                SizedBox(height: 1.3.h),
                     GestureDetector(
                         onTap: galleryOnTap,
                         child: AppText(title: Constants.select_from_gallery,color:  Theme.of(context).colorScheme.secondary,fontSize: 1.7.h)),
              ],
            ),
          ),
        );
      });

}