import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/contact_topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


class RelatedContactScreen extends StatelessWidget {
  const RelatedContactScreen({super.key});

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
          children: [
            SizedBox(
              height: 3.h,
            ),
            contactTopBar(context: context),
            appDivider(context: context,vertical: 1.h),
            AppText(title: Constants.related_Contacts,fontWeight: FontWeight.w600,fontSize: 1.6.h),
            appDivider(context: context,vertical: 1.h),
            Column(
              children: List.generate(10, (index) {
                return  Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                title: '${Constants.person_Name} :',
                                fontSize: 1.6.h,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              AppText(
                                title: '${Constants.phone_Number} :',
                                fontSize: 1.6.h,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              AppText(
                                title: '${Constants.email_Id} :',
                                fontSize: 1.6.h,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              AppText(
                                title: '${Constants.designation} :',
                                fontSize: 1.6.h,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                  title: 'Venkat',
                                  fontSize: 1.6.h,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              AppText(
                                title: '+91 9876543210',
                                fontSize: 1.6.h,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              AppText(
                                title: 'debra.holt@example.com',
                                fontSize: 1.6.h,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ), AppText(
                                title: 'Admin',
                                fontSize: 1.6.h,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    appDivider(context: context,vertical: 1.h),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
