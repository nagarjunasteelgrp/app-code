import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/contact_topbar.dart';
import 'package:digital_lync/modules/contacts/provider/releated_contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RelatedContactScreen extends StatelessWidget {
  const RelatedContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: Constants.APP_NAME,
        leadingArrow: true,
        actions: const [],
        onTap: () {
          Get.back();
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          contactTopBar(context: context),
          appDivider(context: context, vertical: 1.h),
          AppText(
              title: Constants.related_Contacts,
              fontWeight: FontWeight.w600,
              fontSize: 1.6.h),
          appDivider(context: context, vertical: 1.h),
          Consumer<RelatedContactProvider>(builder: (context, provider, _) {
            return Expanded(
              child: (provider.isLoading)
                  ? const Center(
                      child: SpinKitLoader(),
                    )
                  : Column(
                      children: List.generate(
                          provider.relatedContactList.length, (index) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5.h),
                              child: Row(
                                spacing: 5.w,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  Column(
                                    spacing: 1.0.h,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        title: provider
                                            .relatedContactList[index]['name'],
                                        fontSize: 1.6.h,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            context.theme.colorScheme.onPrimary,
                                      ),
                                      AppText(
                                        title: provider
                                            .relatedContactList[index]['phone'],
                                        fontSize: 1.6.h,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        title: provider
                                            .relatedContactList[index]['email'],
                                        fontSize: 1.6.h,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        title: 'Admin',
                                        fontSize: 1.6.h,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            appDivider(context: context, vertical: 1.h),
                          ],
                        );
                      }),
                    ),
            );
          }),
        ],
      ),
    );
  }
}
