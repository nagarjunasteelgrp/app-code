import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/contact_topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({super.key});

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
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            contactTopBar(context: context),
            appDivider(context: context,vertical: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 3.h,),
                AppText(title: Constants.details,fontWeight: FontWeight.w600,fontSize: 1.6.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0.h),
                  child: Image.asset(AppAssets.EDIT),
                ),
              ],
            ),
            appDivider(context: context,vertical: 1.h),
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
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  Expanded(child: AppText(title: Constants.address,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                  Expanded(child: AppText(title: '2972 Westheimer Rd.\nSanta Ana, Illinois 85486 ',fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: AppText(title: Constants.tax_ID,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                  Expanded(child: AppText(title: '',fontWeight: FontWeight.w500, fontSize: 1.5.h,color: Theme.of(context)
                      .colorScheme
                      .onPrimary)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: AppText(title: Constants.description,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                  Expanded(child: AppText(title: ' They serve as their point of contact and lead from initial outreach through the making of the final purchase by them or someone in their household.',fontWeight: FontWeight.w600, fontSize: 1.5.h,maxLines: 5,)),
                ],
              ),
            ),
            appDivider(context: context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.h),
              child: Row(
                children: [
                  Expanded(child: Center(
                    child: appOutlineButton(
                      boxColor: Theme.of(context)
                          .colorScheme
                          .onBackground.withOpacity(0.3),
                      width: double.infinity,
                      height: 4.h,
                      context: context,
                      radius: 1.w,
                      child: AppText(
                          title: Constants.cancel,
                          fontSize: 1.5.h,
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight:
                          FontWeight.w600),
                    ),
                  ),),
                  SizedBox(width: 2.h,),
                  Expanded(child: Center(
                    child: appButton(
                      width: double.infinity,
                      height: 4.h,
                      context: context,
                      radius: 1.w,
                      child: AppText(
                          title: Constants.save,
                          fontSize: 1.5.h,
                          color: Theme.of(context)
                              .colorScheme
                              .background,
                          fontWeight:
                          FontWeight.w600),
                    ),
                  ),),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                  //   child: Center(
                  //     child: appButton(
                  //       width: double.infinity,
                  //       height: 4.h,
                  //       context: context,
                  //       radius: 1.w,
                  //       child: AppText(
                  //           title: Constants.save,
                  //           fontSize: 1.5.h,
                  //           color: Theme.of(context)
                  //               .colorScheme
                  //               .background,
                  //           fontWeight:
                  //           FontWeight.w600),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: 2.h),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                  //   child:
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
