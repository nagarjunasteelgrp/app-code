import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/contact_topbar.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';


class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: Constants.APP_NAME,
        leadingArrow: true,
        actions: [],
        onTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            contactTopBar(context: context),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: double.infinity,
              height: 7.h,
              color: Theme.of(context).colorScheme.onBackground,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  children: [
                    appCircleIcon(
                      context: context,
                      colors: Theme.of(context).colorScheme.primary,
                      radius: 0.5.h,
                      height: 8.w,
                      width: 8.w,
                      child: SvgPicture.asset(AppAssets.APP_CREATE_SVG,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(width: 2.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                            title: Constants.contacts,
                            fontSize: 1.5.h,
                            fontWeight: FontWeight.w500,
                            isPoppins: true),
                        AppText(
                            title: '177897',
                            fontSize: 1.4.h,
                            fontWeight: FontWeight.w500,
                            isPoppins: true),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Expanded(child: AppText(title: 'Person  Name',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,)),
                  Expanded(child: AppText(title: 'Philip',fontWeight: FontWeight.w500, fontSize: 1.5.h,color: Theme.of(context)
                      .colorScheme
                      .onPrimary,isPoppins: true,)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Expanded(child: AppText(title: 'Company Name',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,)),
                  Expanded(child: AppText(title: 'Acme Corporation',fontWeight: FontWeight.w500, fontSize: 1.5.h,color: Theme.of(context)
                      .colorScheme
                      .onPrimary,isPoppins: true,)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Expanded(child: AppText(title: 'Contact Type',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,)),
                  Expanded(child: AppText(title: 'Fabricator',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Expanded(child: AppText(title: 'Phone Number',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,)),
                  Expanded(child: AppText(title: '+91 9876543210',fontWeight: FontWeight.w500, fontSize: 1.5.h,color: Theme.of(context)
                      .colorScheme
                      .onPrimary,isPoppins: true,)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  Expanded(child: AppText(title: 'Email Id',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,)),
                  Expanded(child: AppText(title: 'debra.holt@example.com',fontWeight: FontWeight.w500, fontSize: 1.5.h,color: Theme.of(context)
                      .colorScheme
                      .onPrimary,isPoppins: true)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(RoutesName.CONTACT_DETAILS);
                  // contactProvider.toggleDetails(true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: 'Details',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,),
                    Icon(Icons.arrow_forward_ios,size: 2.h),
                  ],
                ),
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(title: 'Activities',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,),
                  Icon(Icons.arrow_forward_ios,size: 2.h),
                ],
              ),
            ),
            appDivider(context: context),
            GestureDetector(
              onTap: (){
                Get.toNamed(RoutesName.TRACKING);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: 'Tracking',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,),
                    Icon(Icons.arrow_forward_ios,size: 2.h),
                  ],
                ),
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(title: 'Company Contacts',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,),
                  Icon(Icons.arrow_forward_ios,size: 2.h),
                ],
              ),
            ),
            appDivider(context: context),
            // Consumer<ContactProvider>(builder: (context, value, _) {
            //   return value.isDetails
            //       ? const ContactDetailsScreen()
            //       : const ContactDetailsListScreen();
            // }),
          ],
        ),
      ),
    );
  }
}
