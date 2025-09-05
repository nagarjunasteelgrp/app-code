import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/modules/tracking/components/followup_dailog_box.dart';
import 'package:digital_lync/modules/tracking/components/show_dailog_box_googleMap.dart';
import 'package:digital_lync/modules/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'add_notes_dailog.dart';

class TrackingListScreen extends StatelessWidget {
  const TrackingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingProvider>(builder: (context, provider, child) {
      return provider.trackingInfoList.length < 0
          ? const SizedBox()
          : Column(
              children:
                  List.generate(provider.trackingInfoList.length, (index) {
                DateTime date = DateTime.parse(
                    provider.trackingInfoList[index]['createdAt']);
                String formattedDate =
                    DateFormat('dd MMMM, yyyy').format(date).toString();
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.h),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withValues(alpha: 0.1),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary
                            .withValues(alpha: 0.1),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            showMapDialogGoogleMap(
                                context,
                                provider.trackingInfoList[index]['latitude'],
                                provider.trackingInfoList[index]['longitude'],
                                provider.trackingInfoList[index]['address'] ??
                                    "");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              appCircleIcon(
                                context: context,
                                colors: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withValues(alpha: 0.1),
                                radius: 2.w,
                                height: 5.h,
                                width: 5.h,
                                child: SvgPicture.asset(
                                    AppAssets.APP_GEO_LOCATIONS_SVG,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              SizedBox(width: 2.w),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      title: formattedDate.toString(),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    AppText(
                                      title: provider.trackingInfoList[index]
                                              ['address'] ??
                                          "",
                                      maxLines: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Expanded(
                              child: appOutlineButton(
                                  context: context,
                                  onTap: () {
                                    provider.trackingInfoId =
                                        provider.trackingInfoList[index]['id'];
                                    provider.trackingInfoId != 0
                                        ? showAddNotesDialog(context)
                                        : const SizedBox();
                                  },
                                  height: 5.5.h,
                                  radius: 1.h,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          AppAssets.APP_ADD_NOTES_SVG,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                      SizedBox(width: 2.w),
                                      AppText(
                                        title: 'Add Notes',
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: appOutlineButton(
                                context: context,
                                onTap: () {
                                  followUpDialogBox(context, provider);
                                },
                                height: 5.5.h,
                                radius: 1.h,
                                width: double.infinity,
                                child: AppText(
                                  title: 'Follow ups',
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: List.generate(
                              provider.trackingInfoList[index]['trackingNotes']
                                  .length, (notesIndex) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                                  borderRadius: BorderRadius.circular(1.h),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.w, vertical: 1.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              AppAssets.APP_ADD_NOTES_SVG,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          AppText(
                                            title: 'Note:',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 0.7.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 0.7.w),
                                        child: Text(
                                          provider.trackingInfoList[index]
                                                      ['trackingNotes']
                                                  [notesIndex]['description'] ??
                                              "",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 1.5.h),
                        Consumer<TrackingProvider>(
                            builder: (context, provider, child) {
                          return appButton(
                              context: context,
                              onTap: () {
                                provider.trackingInfoId =
                                    provider.trackingInfoList[index]['id'];
                                if (provider.trackingInfoList[index]['id'] !=
                                    0) {
                                  // contactBottomSheet(context, provider);
                                  provider.getImage(
                                      context, ImageSource.camera);
                                  provider.imageType = 'image';
                                }
                              },
                              height: 5.5.h,
                              radius: 1.h,
                              width: double.infinity,
                              color: Theme.of(context).colorScheme.primary,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      AppAssets.APP_CAPTURE_IMAGE_SVG,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                  SizedBox(width: 2.w),
                                  AppText(
                                    title: 'Capture image',
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ],
                              ));
                        }),
                        SizedBox(height: 1.h),
                        appOutlineButton(
                            context: context,
                            onTap: () {
                              provider.trackingInfoId =
                                  provider.trackingInfoList[index]['id'];
                              if (provider.trackingInfoId != 0) {
                                provider.imageType = 'document';
                                provider.openFileExplorer(context);
                              }
                            },
                            height: 5.5.h,
                            radius: 1.h,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppAssets.APP_UPLOAD_DOC_SVG,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                                SizedBox(width: 2.w),
                                AppText(
                                  title: 'Upload Document',
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            )),
                        SizedBox(height: 2.h),
                        Column(
                          children: List.generate(
                              provider.trackingInfoList[index]['trackingImages']
                                  .length, (imageIndex) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  title: provider.trackingInfoList[index]
                                                  ['trackingImages'][imageIndex]
                                              ['type'] ==
                                          "image"
                                      ? 'Images'
                                      : 'Pdf',
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                SizedBox(height: 0.5.h),
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground
                                                .withValues(alpha: 0.3),
                                            border: DashedBorder.fromBorderSide(
                                              dashLength: 10,
                                              side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withValues(alpha: 0.4),
                                                width: 2,
                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(1.h),
                                          ),
                                          child: CachedNetworkImage(
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.fitWidth,
                                            imageUrl:
                                                provider.trackingInfoList[index]
                                                        ['trackingImages']
                                                    [imageIndex]['imgSrc']!,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child: SpinKitLoader()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                          /* CachedNetworkImage(
                                                                        width: double
                                                                            .infinity,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                        imageUrl:
                                                                            provider.trackingInfoList[index]['trackingImages'][imageIndex]['imgSrc']!,
                                                                        placeholder: (BuildContext
                                                                                context,
                                                                            String
                                                                                url) {
                                                                          return const Center(
                                                                              child: SpinKitLoader());
                                                                        },
                                                                        errorWidget: (BuildContext context,
                                                                            String
                                                                                url,
                                                                            dynamic
                                                                                error) {
                                                                          return const Icon(
                                                                              Icons.error);
                                                                        },
                                                                      ),*/
                                          // Image.network(
                                          //     provider.trackingInfoList[index]['trackingImages'][imageIndex]['imgSrc']!,
                                          //     fit: BoxFit.fill),
                                        )
                                      : AppText(
                                          title:
                                              provider.trackingInfoList[index]
                                                      ['trackingImages']
                                                  [imageIndex]['imgSrc']),
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
    });
  }
}
