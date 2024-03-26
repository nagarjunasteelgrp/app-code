import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/contact_topbar.dart';
import 'package:flutter/material.dart';
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
            AppText(title: 'Details',fontWeight: FontWeight.w500,fontSize: 1.6.h,isPoppins: true),
            appDivider(context: context,vertical: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(title: 'Address',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,),
                  SizedBox(width: 3.w,),
                  Expanded(child: AppText(title: '2972 Westheimer Rd.\nSanta Ana, Illinois 85486 ',fontWeight: FontWeight.w400, fontSize: 1.5.h,color: Theme.of(context)
                      .colorScheme
                      .secondary,isPoppins: true,)),
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
                  Expanded(child: AppText(title: 'Tax Id',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true)),
                  Expanded(child: AppText(title: '',fontWeight: FontWeight.w500, fontSize: 1.5.h,color: Theme.of(context)
                      .colorScheme
                      .onPrimary,isPoppins: true)),
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
                  Expanded(child: AppText(title: 'Additional info ',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true)),
                  Expanded(child: AppText(title: '',fontWeight: FontWeight.w500, fontSize: 1.5.h,color: Theme.of(context)
                      .colorScheme
                      .onPrimary)),
                ],
              ),
            ),
            appDivider(context: context),
          ],
        ),
      ),
    );
  }
}
