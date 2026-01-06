import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/modules/tracking/components/add_notes_dialog.dart';
import 'package:digital_lync/modules/tracking/components/followup_dialog_box.dart';
import 'package:digital_lync/modules/tracking/components/show_dialog_box_google_map.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TrackingListScreen extends StatelessWidget {
  const TrackingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingProvider>(
      builder: (context, provider, child) {
        return provider.trackingInfoList.isEmpty
            ? const SizedBox()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: provider.trackingInfoList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  DateTime date = DateTime.parse(
                    provider.trackingInfoList[index]['createdAt'],
                  );

                  String formattedDate =
                      DateFormat('dd MMMM, yyyy').format(date).toString();

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    padding: EdgeInsets.symmetric(
                      vertical: 2.h,
                      horizontal: 1.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.h),
                      color: context.theme.colorScheme.onSecondary.withValues(
                        alpha: 0.1,
                      ),
                      border: Border.all(
                        color: context.theme.colorScheme.secondary,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                          color: context.theme.colorScheme.onSecondary
                              .withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => showMapDialogGoogleMap(
                            context,
                            provider.trackingInfoList[index]['latitude'],
                            provider.trackingInfoList[index]['longitude'],
                            provider.trackingInfoList[index]['address'] ?? "",
                          ),
                          child: Row(
                            spacing: 2.w,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              appCircleIcon(
                                width: 5.h,
                                height: 5.h,
                                radius: 2.w,
                                context: context,
                                colors: context.theme.colorScheme.onPrimary
                                    .withValues(alpha: 0.1),
                                child: SvgPicture.asset(
                                  AppAssets.APP_GEO_LOCATIONS_SVG,
                                  colorFilter: ColorFilter.mode(
                                    context.theme.colorScheme.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      fontWeight: FontWeight.w600,
                                      title: formattedDate.toString(),
                                    ),
                                    AppText(
                                      maxLines: 10,
                                      title: provider.trackingInfoList[index]
                                              ['address'] ??
                                          "",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          spacing: 2.w,
                          children: [
                            Expanded(
                              child: appOutlineButton(
                                radius: 1.h,
                                height: 5.5.h,
                                context: context,
                                width: double.infinity,
                                onTap: () {
                                  provider.trackingInfoId =
                                      provider.trackingInfoList[index]['id'];
                                  provider.trackingInfoId != 0
                                      ? showAddNotesDialog(context)
                                      : const SizedBox();
                                },
                                child: Row(
                                  spacing: 2.w,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.APP_ADD_NOTES_SVG,
                                      colorFilter: ColorFilter.mode(
                                        context.theme.colorScheme.onPrimary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    AppText(
                                      title: 'Add Notes',
                                      color:
                                          context.theme.colorScheme.onPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: appOutlineButton(
                                radius: 1.h,
                                height: 5.5.h,
                                context: context,
                                width: double.infinity,
                                onTap: () =>
                                    followUpDialogBox(context, provider),
                                child: AppText(
                                  title: 'Follow ups',
                                  color: context.theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider
                              .trackingInfoList[index]['trackingNotes'].length,
                          itemBuilder: (context, notesIndex) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        context.theme.colorScheme.onSecondary,
                                  ),
                                  borderRadius: BorderRadius.circular(1.h),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 1.w,
                                    vertical: 1.h,
                                  ),
                                  child: Column(
                                    spacing: 0.7.h,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        spacing: 2.w,
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.APP_ADD_NOTES_SVG,
                                            colorFilter: ColorFilter.mode(
                                              context
                                                  .theme.colorScheme.secondary,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          AppText(
                                            title: 'Note:',
                                            color: context
                                                .theme.colorScheme.onSecondary,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 0.7.w),
                                        child: AppText(
                                          title:
                                              provider.trackingInfoList[index]
                                                              ['trackingNotes']
                                                          [notesIndex]
                                                      ['description'] ??
                                                  "",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 1.5.h),
                        Consumer<TrackingProvider>(
                          builder: (context, provider, child) {
                            return appButton(
                              radius: 1.h,
                              height: 5.5.h,
                              context: context,
                              width: double.infinity,
                              color: context.theme.colorScheme.primary,
                              onTap: () async {
                                provider.trackingInfoId =
                                    provider.trackingInfoList[index]['id'];
                                if (provider.trackingInfoList[index]['id'] !=
                                    0) {
                                  provider.getImage(ImageSource.camera);
                                  provider.imageType = 'image';
                                }
                              },
                              child: Row(
                                spacing: 2.w,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.APP_CAPTURE_IMAGE_SVG,
                                    colorFilter: ColorFilter.mode(
                                      context.theme.colorScheme.surface,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  AppText(
                                    title: 'Capture image',
                                    color: context.theme.colorScheme.surface,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 1.h),
                        appOutlineButton(
                          radius: 1.h,
                          height: 5.5.h,
                          context: context,
                          width: double.infinity,
                          onTap: () {
                            provider.trackingInfoId =
                                provider.trackingInfoList[index]['id'];
                            if (provider.trackingInfoId != 0) {
                              provider.imageType = 'document';
                              provider.openFileExplorer(context);
                            }
                          },
                          child: Row(
                            spacing: 2.w,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.APP_UPLOAD_DOC_SVG,
                                colorFilter: ColorFilter.mode(
                                  context.theme.colorScheme.onPrimary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              AppText(
                                title: 'Upload Document',
                                color: context.theme.colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider
                              .trackingInfoList[index]['trackingImages'].length,
                          itemBuilder: (context, imageIndex) {
                            return Column(
                              spacing: 0.5.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  color: context.theme.colorScheme.onSecondary,
                                  title: provider.trackingInfoList[index]
                                                  ['trackingImages'][imageIndex]
                                              ['type'] ==
                                          "image"
                                      ? 'Images'
                                      : 'Pdf',
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: provider.trackingInfoList[index]
                                                  ['trackingImages'][imageIndex]
                                              ['type'] ==
                                          "image"
                                      ? Container(
                                          height: 25.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              1.h,
                                            ),
                                            color: context.theme.colorScheme
                                                .onSecondaryFixed
                                                .withValues(alpha: 0.3),
                                            border: DashedBorder.fromBorderSide(
                                              dashLength: 10,
                                              side: BorderSide(
                                                width: 2,
                                                color: context
                                                    .theme.colorScheme.secondary
                                                    .withValues(alpha: 0.4),
                                              ),
                                            ),
                                          ),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                            imageUrl:
                                                provider.trackingInfoList[index]
                                                        ['trackingImages']
                                                    [imageIndex]['imgSrc']!,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: SpinKitLoader(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.hide_image_outlined,
                                            ),
                                          ),
                                        )
                                      : AppText(
                                          title:
                                              provider.trackingInfoList[index]
                                                      ['trackingImages']
                                                  [imageIndex]['imgSrc'],
                                        ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
