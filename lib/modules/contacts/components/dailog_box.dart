import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfiled.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/screen/conatct_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

void showContactDialog(BuildContext context,
    TextEditingController companyNameController,
    TextEditingController emailController,
    TextEditingController personNameController,
    TextEditingController contactTypeController,
    TextEditingController phoneNumberController,
    TextEditingController addressController,
    TextEditingController taxIdController,
    TextEditingController descriptionController
    ) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        elevation: 5,
        insetAnimationCurve: Curves.bounceIn,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 5.w),
                      appCircleIcon(
                        context: context,
                        colors: Theme.of(context).colorScheme.primary,
                        radius: 0.5.h,
                        height: 6.w,
                        width: 6.w,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SvgPicture.asset(AppAssets.APP_CREATE_SVG,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      AppText(
                        title: 'Create Contact',
                        fontSize: 2.h),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,
                        size: 2.h),
                  )
                ],
              ),
              appDivider(context: context,vertical: 0.h),
              Padding(padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                        title: Constants.company_Name,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context,controller: companyNameController,),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: Constants.person_Name,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context,controller: personNameController,),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: Constants.contact_Type,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context,controller: contactTypeController,),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: Constants.phone_Number,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context,controller: phoneNumberController,),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: Constants.email,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context,controller: emailController,),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: Constants.address,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context,controller: addressController,),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: Constants.tax_ID,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context,controller: taxIdController,),
                    SizedBox(height: 1.5.h),
                    AppText(
                        title: Constants.description,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 1.5.h),
                    SizedBox(height: 0.5.h),
                    appTextfield(context: context,controller: descriptionController,),
                  ],
                ),
              ),
              appDivider(context: context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
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
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      );
    },
  );
}
