import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/contact_topbar.dart';
import 'package:digital_lync/modules/contacts/components/contact_update_dailog.dart';
import 'package:digital_lync/modules/contacts/components/dailog_box.dart';
import 'package:digital_lync/modules/contacts/provider/contacts_details_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

ContactDetailsProvider contactDetailsProvider = ContactDetailsProvider();

class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: contactDetailsProvider,
      child: Scaffold(
        appBar: CommonAppBar(
          title: Constants.APP_NAME,
          leadingArrow: true,
          actions: [],
          onTap: () {
            Get.back();
          },
        ),
        body: Consumer<ContactDetailsProvider>(builder: (context, provider, _) {
       return Column(
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
               GestureDetector(
                 onTap: (){
                   showContactUpdateDialog(context);
                 },
                 child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 1.0.h),
                   child: Image.asset(AppAssets.EDIT),
                 ),
               ),
             ],
           ),
           appDivider(context: context,vertical: 1.h),
             Expanded(
               child: (provider.isLoading) ? Center(
                 child: SpinKitLoader(),
               ) : SingleChildScrollView(
                 child: Column(
                 children: [
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 5.w),
                     child: Row(
                       children: [
                         Expanded(child: AppText(title: Constants.company_Name,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                         Expanded(child: AppText(title: provider.companyName,fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                       ],
                     ),
                   ),
                   appDivider(context: context),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 5.w),
                     child: Row(
                       children: [
                         Expanded(child: AppText(title: Constants.person_Name,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                         Expanded(child: AppText(title: provider.personName,fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                       ],
                     ),
                   ),
                   appDivider(context: context),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 5.w),
                     child: Row(
                       children: [
                         Expanded(child: AppText(title: Constants.contact_Type,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                         Expanded(child: AppText(title: provider.contactType,fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                       ],
                     ),
                   ),
                   appDivider(context: context),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 5.w),
                     child: Row(
                       children: [
                         Expanded(child: AppText(title: Constants.phone_Number,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                         Expanded(child: AppText(title: provider.phoneNumber,fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                       ],
                     ),
                   ),
                   appDivider(context: context),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 4.w),
                     child: Row(
                       children: [
                         Expanded(child: AppText(title: Constants.email_Id,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                         Expanded(child: AppText(title: provider.email,fontWeight: FontWeight.w600, fontSize: 1.5.h)),
                       ],
                     ),
                   ),
                   appDivider(context: context),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 4.w),
                     child: Row(
                       children: [
                         Expanded(child: AppText(title: Constants.address,fontWeight: FontWeight.w500, fontSize: 1.5.h)),
                         Expanded(child: AppText(title: provider.address,fontWeight: FontWeight.w600, fontSize: 1.5.h)),
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
                         Expanded(child: AppText(title: provider.taxId,fontWeight: FontWeight.w500, fontSize: 1.5.h,color: Theme.of(context)
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
                         Expanded(child: AppText(title: provider.description,fontWeight: FontWeight.w600, fontSize: 1.5.h,maxLines: 5,)),
                       ],
                     ),
                   ),
                   appDivider(context: context),
                 ],
                               ),
               ),
             ),
         ],
       );
        }),
      ),
    );
  }
}
