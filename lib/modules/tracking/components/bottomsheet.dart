import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void contactBottomSheet(
    BuildContext context, TrackingProvider trackingProviders) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: trackingProvider,
          child: SizedBox(
            height: 12.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  AppText(
                    title: Constants.select_Image_Source,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withValues(alpha: 0.5),
                  ),
                  SizedBox(height: 1.3.h),
                  Consumer<TrackingProvider>(
                    builder: (BuildContext context, provider, Widget? child) {
                      return GestureDetector(
                        onTap: () {
                          trackingProviders.getImage(
                              context, ImageSource.camera);
                        },
                        child: AppText(
                          fontSize: 1.7.h,
                          title: Constants.use_Camera,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
