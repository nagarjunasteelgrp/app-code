import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/contact_topbar.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              height: 9.h,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.onBackground),
              ),
              // color: Theme.of(context).colorScheme.onBackground,
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
                      child: SvgPicture.asset(AppAssets.APP_CONTACTS_SVG,
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
                            fontWeight: FontWeight.w500),
                        AppText(
                            title: '177897',
                            fontSize: 1.4.h,
                            fontWeight: FontWeight.w500),
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
                  Expanded(child: AppText(title: Constants.company_Name,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                  Expanded(child: AppText(title: 'Acme Corporation',fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Expanded(child: AppText(title: Constants.person_Name,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                  Expanded(child: AppText(title: 'Philip',fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Expanded(child: AppText(title: Constants.contact_Type,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                  Expanded(child: AppText(title: 'Fabricator',fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Expanded(child: AppText(title: Constants.phone_Number,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                  Expanded(child: AppText(title: '+91 9876543210',fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  Expanded(child: AppText(title: Constants.email_Id,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                  Expanded(child: AppText(title: 'debra.holt@example.com',fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(RoutesName.CONTACT_DETAILS);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: Constants.details,fontWeight: FontWeight.w600, fontSize: 1.5.h),
                    Icon(Icons.arrow_forward_ios,size: 2.h),
                  ],
                ),
              ),
            ),
            appDivider(context: context),
            GestureDetector(
              onTap: (){},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: Constants.activities,fontWeight: FontWeight.w600, fontSize: 1.5.h),
                    Icon(Icons.arrow_forward_ios,size: 2.h),
                  ],
                ),
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
                    AppText(title: Constants.tracking,fontWeight: FontWeight.w600, fontSize: 1.5.h),
                    Icon(Icons.arrow_forward_ios,size: 2.h),
                  ],
                ),
              ),
            ),
            appDivider(context: context),
            GestureDetector(
              onTap: (){
                Get.toNamed(RoutesName.RELATED_CONTACT);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: Constants.related_Contacts,fontWeight: FontWeight.w600, fontSize: 1.5.h),
                    Icon(Icons.arrow_forward_ios,size: 2.h),
                  ],
                ),
              ),
            ),
            appDivider(context: context),
          ],
        ),
      ),
    );
  }
}
