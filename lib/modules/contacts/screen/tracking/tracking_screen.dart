import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:sizer/sizer.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Philip',
        leadingArrow: true,
        actions: [],
        onTap: () {
          Get.back();
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 4.w),
        child: appButton(context: context,radius: 1.h,height: 5.5.h,child: AppText(title: 'Submit',isPoppins: true,fontWeight: FontWeight.w600,fontSize: 1.8.h,color: Theme.of(context)
            .colorScheme
            .background,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appOutlineButton(
                  context: context,
                  onTap: () {},
                  height: 5.5.h,
                  radius: 1.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.APP_GEO_LOCATIONS_SVG,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5)),
                      SizedBox(width: 2.w),
                      AppText(
                          title: 'Capture geo location',

                          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                          isPoppins: true),
                    ],
                  )),
              SizedBox(height: 2.h),
              appButton(
                  context: context,
                  onTap: () {},
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
                        isPoppins: true,
                      ),
                    ],
                  )),
              SizedBox(height: 2.h),
              appOutlineButton(
                  context: context,
                  onTap: () {},
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
                          isPoppins: true),
                    ],
                  )),
              SizedBox(height: 3.h),
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
                                isPoppins: true),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              AppText(title: 'Address',color: Theme.of(context).colorScheme.onSecondary,),
              SizedBox(height: 0.5.h),
              AppText(title: 'Manuguru, Manuguru mandal, Bhadradri Kothagudem District, Telangana, 507125, India',color: Theme.of(context).colorScheme.secondary,textOverflow: TextOverflow.ellipsis,maxLines: 5,),
              SizedBox(height: 0.5.h),
              Image.asset(AppAssets.DUMMY_MAP,scale: 0.1.h,),
              SizedBox(height: 3.h),
              AppText(title: 'Images',color: Theme.of(context).colorScheme.onSecondary,),
              SizedBox(height: 1.h),
              Container(
                height: 25.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                    border: DashedBorder.fromBorderSide(
                        dashLength: 10, side: BorderSide(color:Theme.of(context).colorScheme.secondary.withOpacity(0.4), width: 2)),
                  borderRadius: BorderRadius.circular(1.h),
                   ),
                child:  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add,size: 5.h,color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),),
                      AppText(title: 'Add Image',fontSize: 2.5.h),
                      AppText(title: 'Less then 1mb, png,jpeg',fontSize: 2.h,color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
