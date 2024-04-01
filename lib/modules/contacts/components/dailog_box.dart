import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_dropdown_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfiled.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:digital_lync/modules/contacts/screen/conatct_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showContactDialog(BuildContext context,
{VoidCallback? onTapCancel, VoidCallback? onTapSave}) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
        value: contactProvider,
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          elevation: 5,
          insetAnimationCurve: Curves.bounceIn,
          backgroundColor: Theme.of(context).colorScheme.background,
          child: Consumer<ContactProvider>(builder: (context, provider, _) {
            print("DROPDOWN VALUE:-------${provider.selectedValue}");
            return SingleChildScrollView(
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
                        appTextfield(context: context,controller: provider.companyNameController,),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: Constants.person_Name,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextfield(context: context,controller: provider.personNameController,),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: Constants.phone_Number,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextfield(context: context,controller: provider.phoneNumberController,),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: Constants.email,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextfield(context: context,controller: provider.emailController,),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: Constants.contact_Type,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        dropdownWidget(
                          context: context,
                          value: provider.selectedValue
                              .toString(),
                          items: List.generate(
                              provider.dropDown.length,
                                  (index) {
                                var data =
                                provider.dropDown[index];
                                var value =
                                data.toString();
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.5.w),
                                    child: AppText(
                                      title: data,
                                    ),
                                  ),
                                );
                              }),
                          onChanged: (newValue) {
                            provider.dropDownSelectedValue(newValue);
                            provider.contactTypeController = TextEditingController(text: newValue ?? 'customer');
                          },
                        ),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: Constants.address,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextfield(context: context,controller: provider.addressController,),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: Constants.tax_ID,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextfield(context: context,controller: provider.taxIdController,),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: Constants.description,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextfield(context: context,controller: provider.descriptionController,),
                      ],
                    ),
                  ),
                  appDivider(context: context),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.h),
                    child:  (provider.isAddContactButton == false) ?  Row(
                      children: [
                        Expanded(child: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Center(
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
                          ),
                        ),),
                        SizedBox(width: 2.h,),
                        Expanded(child: GestureDetector(
                          onTap: (){
                            provider.createContact(context);
                          },
                          child: Center(
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
                          ),
                        ),),
                      ],
                    ) : Center(
                      child: SpinKitLoader(),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            );
          }),

        ),
      );
    },
  );
}
