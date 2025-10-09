import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_dropdown_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_outline_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:digital_lync/modules/contacts/screen/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void showContactUpdateDialog(
  BuildContext context, {
  String? selectedValue,
  VoidCallback? onTapSave,
  VoidCallback? onTapCancel,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider.value(
        value: contactProvider,
        child: Dialog(
          elevation: 5,
          insetAnimationCurve: Curves.bounceIn,
          backgroundColor: Theme.of(context).colorScheme.background,
          insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Consumer<ContactProvider>(builder: (context, provider, _) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 5.w,
                        children: [
                          appCircleIcon(
                            width: 6.w,
                            height: 6.w,
                            radius: 0.5.h,
                            context: context,
                            colors: Theme.of(context).colorScheme.primary,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(
                                AppAssets.APP_CREATE_SVG,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          AppText(title: 'Update Contact', fontSize: 2.h),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.close, size: 2.h),
                        onPressed: () {
                          Get.back();
                          provider.resMessage = '';
                          provider.selectedContactIndex = -1;
                        },
                      )
                    ],
                  ),
                  appDivider(context: context, vertical: 0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          fontSize: 1.5.h,
                          fontWeight: FontWeight.w400,
                          title: Constants.contact_Type,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        SizedBox(height: 0.5.h),
                        dropdownWidget(
                          context: context,
                          value: provider.selectedValue.toString(),
                          items: [
                            ...List.generate(
                              provider.dropDown.length,
                              (index) {
                                var data = provider.dropDown[index];
                                var value = data.toString();
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0.5.w),
                                    child: AppText(title: data),
                                  ),
                                );
                              },
                            )
                          ],
                          onChanged: (newValue) {
                            provider.dropDownSelectedValue(newValue);
                            provider.contactTypeController =
                                TextEditingController(
                              text: newValue ?? 'dealer',
                            );
                            provider.selectedValue = newValue;
                            provider.notifyListeners();
                          },
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          spacing: 2,
                          children: [
                            AppText(
                              fontSize: 1.5.h,
                              fontWeight: FontWeight.w400,
                              title: Constants.company_Name,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            AppText(
                              title: "*",
                              fontSize: 2.h,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        appTextField(
                          context: context,
                          controller: provider.companyNameController,
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          spacing: 2,
                          children: [
                            AppText(
                              fontSize: 1.5.h,
                              fontWeight: FontWeight.w400,
                              title: Constants.person_Name,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            AppText(
                              title: "*",
                              fontSize: 2.h,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        appTextField(
                          context: context,
                          controller: provider.personNameController,
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          spacing: 2,
                          children: [
                            AppText(
                              fontSize: 1.5.h,
                              fontWeight: FontWeight.w400,
                              title: Constants.phone_Number,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            AppText(
                              title: "*",
                              fontSize: 2.h,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        appTextField(
                            context: context,
                            controller: provider.phoneNumberController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ]),
                        SizedBox(height: 1.5.h),
                        AppText(
                            title: Constants.phone_Number2,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 1.5.h),
                        SizedBox(height: 0.5.h),
                        appTextField(
                            context: context,
                            keyboardType: TextInputType.phone,
                            controller: provider.phoneNumber2Controller,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ]),
                        SizedBox(height: 1.5.h),
                        AppText(
                          fontSize: 1.5.h,
                          title: Constants.landLine,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        SizedBox(height: 0.5.h),
                        appTextField(
                          context: context,
                          keyboardType: TextInputType.phone,
                          controller: provider.landlineController,
                        ),
                        SizedBox(height: 1.5.h),
                        AppText(
                          fontSize: 1.5.h,
                          title: Constants.gstNumber,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        SizedBox(height: 0.5.h),
                        appTextField(
                            context: context,
                            controller: provider.gstNumberController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                            ]),
                        SizedBox(height: 1.5.h),
                        Row(
                          spacing: 2,
                          children: [
                            AppText(
                              fontSize: 1.5.h,
                              title: Constants.email,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            AppText(
                              title: "*",
                              fontSize: 2.h,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        appTextField(
                          context: context,
                          controller: provider.emailController,
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          spacing: 2,
                          children: [
                            AppText(
                              fontSize: 1.5.h,
                              title: Constants.address,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            AppText(
                              title: "*",
                              fontSize: 2.h,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        appTextField(
                          context: context,
                          controller: provider.addressController,
                        ),
                        SizedBox(height: 1.5.h),
                        AppText(
                          fontSize: 1.5.h,
                          fontWeight: FontWeight.w400,
                          title: Constants.description,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        SizedBox(height: 0.5.h),
                        appTextField(
                          context: context,
                          controller: provider.descriptionController,
                        ),
                      ],
                    ),
                  ),
                  appDivider(context: context),
                  provider.resMessage == ''
                      ? const SizedBox()
                      : Center(
                          child: AppText(
                          title: provider.resMessage,
                          color: Theme.of(context).colorScheme.error,
                        )),
                  provider.resMessage == ''
                      ? const SizedBox()
                      : SizedBox(
                          height: 2.h,
                        ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.h),
                    child: (provider.isAddContactButton == false)
                        ? Row(
                            spacing: 2.h,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    provider.resMessage = '';
                                    Get.back();
                                  },
                                  child: Center(
                                    child: appOutlineButton(
                                      boxColor: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withValues(alpha: 0.3),
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
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    provider.contactUpdate(context);
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
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Center(child: SpinKitLoader()),
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
