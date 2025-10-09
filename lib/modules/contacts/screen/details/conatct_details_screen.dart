import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/contact_topbar.dart';
import 'package:digital_lync/modules/contacts/provider/contacts_details_provider.dart';
import 'package:flutter/material.dart';
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
          onTap: () {
            Get.back();
          },
        ),
        body: Consumer<ContactDetailsProvider>(builder: (context, provider, _) {
          return Column(
            children: [
              SizedBox(height: 3.h),
              contactTopBar(context: context),
              appDivider(context: context, vertical: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 3.h),
                  AppText(
                    fontSize: 1.6.h,
                    title: Constants.details,
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.0.h),
                      child: Image.asset(AppAssets.EDIT),
                    ),
                  ),
                ],
              ),
              appDivider(context: context, vertical: 1.h),
              Expanded(
                child: (provider.isLoading)
                    ? const Center(child: SpinKitLoader())
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      fontWeight: FontWeight.w500,
                                      title: Constants.company_Name,
                                    ),
                                  ),
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      title: provider.companyName,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            appDivider(context: context),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      fontWeight: FontWeight.w500,
                                      title: Constants.person_Name,
                                    ),
                                  ),
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      title: provider.personName,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            appDivider(context: context),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      fontWeight: FontWeight.w500,
                                      title: Constants.contact_Type,
                                    ),
                                  ),
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      title: provider.contactType,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            appDivider(context: context),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      fontWeight: FontWeight.w500,
                                      title: Constants.phone_Number,
                                    ),
                                  ),
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      fontWeight: FontWeight.w600,
                                      title: provider.phoneNumber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            appDivider(context: context),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: AppText(
                                    fontSize: 1.5.h,
                                    title: Constants.email_Id,
                                    fontWeight: FontWeight.w500,
                                  )),
                                  Expanded(
                                      child: AppText(
                                    fontSize: 1.5.h,
                                    title: provider.email,
                                    fontWeight: FontWeight.w600,
                                  )),
                                ],
                              ),
                            ),
                            appDivider(context: context),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      title: Constants.address,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      title: provider.address,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
                                  Expanded(
                                    child: AppText(
                                      title: Constants.tax_ID,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 1.5.h,
                                    ),
                                  ),
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      title: provider.taxId,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
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
                                  Expanded(
                                    child: AppText(
                                      fontSize: 1.5.h,
                                      fontWeight: FontWeight.w500,
                                      title: Constants.description,
                                    ),
                                  ),
                                  Expanded(
                                    child: AppText(
                                      maxLines: 5,
                                      fontSize: 1.5.h,
                                      title: provider.description,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
