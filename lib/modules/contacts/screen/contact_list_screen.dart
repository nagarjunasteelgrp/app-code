import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/contact_topbar.dart';
import 'package:digital_lync/modules/contacts/provider/contacts_details_provider.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ContactDetailsProvider(),
      child: Scaffold(
        appBar: CommonAppBar(
          title: Constants.APP_NAME,
          leadingArrow: true,
          actions: const [],
          onTap: () {
            Get.back();
          },
        ),
        body: Consumer<ContactDetailsProvider>(builder: (context, provider, _) {
          return Column(
            children: [
              SizedBox(height: 3.h),
              contactTopBar(context: context),
              SizedBox(height: 2.h),
              Container(
                height: 9.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: context.theme.colorScheme.onBackground),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Row(
                    spacing: 2.w,
                    children: [
                      appCircleIcon(
                        width: 8.w,
                        height: 8.w,
                        radius: 0.5.h,
                        context: context,
                        colors: context.theme.colorScheme.primary,
                        child: SvgPicture.asset(
                          AppAssets.APP_CONTACTS_SVG,
                          color: context.theme.primaryColor,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            fontSize: 1.5.h,
                            title: Constants.contacts,
                            fontWeight: FontWeight.w500,
                          ),
                          AppText(
                            fontSize: 1.4.h,
                            fontWeight: FontWeight.w500,
                            title: provider.contactId.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: (provider.isLoading)
                    ? const SpinKitLoader()
                    : Column(
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
                                )),
                                Expanded(
                                    child: AppText(
                                  fontSize: 1.5.h,
                                  fontWeight: FontWeight.w600,
                                  title: provider.companyName,
                                )),
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
                                )),
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
                                    fontWeight: FontWeight.w600,
                                    title: provider.contactType,
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
                                    title: Constants.email_Id,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: AppText(
                                    fontSize: 1.5.h,
                                    title: provider.email,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          appDivider(context: context),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RoutesName.CONTACT_DETAILS,
                                        arguments: {
                                      'id': provider.contactId,
                                    })!
                                    .then((value) {
                                  provider.contactDetailsAPI();
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    fontSize: 1.5.h,
                                    title: Constants.details,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 2.h),
                                ],
                              ),
                            ),
                          ),
                          appDivider(context: context),
                          GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    fontSize: 1.5.h,
                                    title: Constants.activities,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 2.h),
                                ],
                              ),
                            ),
                          ),
                          appDivider(context: context),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutesName.TRACKING);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    fontSize: 1.5.h,
                                    title: Constants.tracking,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 2.h),
                                ],
                              ),
                            ),
                          ),
                          appDivider(context: context),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutesName.RELATED_CONTACT);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    fontSize: 1.5.h,
                                    fontWeight: FontWeight.w600,
                                    title: Constants.related_Contacts,
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 2.h),
                                ],
                              ),
                            ),
                          ),
                          appDivider(context: context),
                        ],
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
