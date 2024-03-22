import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/common/dailog_box.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    appCircleIcon(
                        context: context,
                        colors: Theme.of(context).colorScheme.inversePrimary,
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.APP_FILTER_SVG,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    AppText(
                      title: 'Filter',
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                Column(
                  children: [
                    appCircleIcon(
                        context: context,
                        colors: Theme.of(context).colorScheme.scrim,
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.APP_SORT_ARROW_SVG,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    AppText(
                      title: 'Sort',
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    showContactDialog(context);
                  },
                  child: Column(
                    children: [
                      appCircleIcon(
                          context: context,
                          colors: Theme.of(context).colorScheme.onPrimary,
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.APP_CREATE_SVG,
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                      SizedBox(
                        height: 0.7.h,
                      ),
                      AppText(
                        title: 'Create',
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          appDivider(context: context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              children: [
                appCircleIcon(
                  context: context,
                  colors: Theme.of(context).colorScheme.primary,
                  radius: 0.5.h,
                  height: 8.w,
                  width: 8.w,
                  child: SvgPicture.asset(AppAssets.APP_CREATE_SVG,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(width: 2.w),
                AppText(
                    title: Constants.contacts,
                    fontSize: 1.8.h,
                    fontWeight: FontWeight.w500,
                    isPoppins: true),
              ],
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Column(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  contactProvider.toggleSelected(false);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                      title: 'Person  Name',
                                      fontSize: 1.6.h,
                                      fontWeight: FontWeight.w500,
                                      isPoppins: true),
                                  AppText(
                                      title: 'Company Name',
                                      fontSize: 1.6.h,
                                      fontWeight: FontWeight.w500,
                                      isPoppins: true),
                                  AppText(
                                      title: 'Contact Type',
                                      fontSize: 1.6.h,
                                      fontWeight: FontWeight.w500,
                                      isPoppins: true),
                                  AppText(
                                      title: 'Phone Number',
                                      fontSize: 1.6.h,
                                      fontWeight: FontWeight.w500,
                                      isPoppins: true),
                                  AppText(
                                      title: 'Email Id',
                                      fontSize: 1.6.h,
                                      fontWeight: FontWeight.w500,
                                      isPoppins: true),
                                ],
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                      title: 'Philip',
                                      fontSize: 1.6.h,
                                      fontWeight: FontWeight.w500,
                                      isPoppins: true),
                                  AppText(
                                      title: 'Acme Corporation',
                                      fontSize: 1.6.h,
                                      fontWeight: FontWeight.w500,
                                      isPoppins: true,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                  AppText(
                                      title: 'Fabricator',
                                      fontSize: 1.6.h,
                                      fontWeight: FontWeight.w500,
                                      isPoppins: true),
                                  AppText(
                                      title: '+91 9876543210',
                                      fontSize: 1.6.h,
                                      fontWeight: FontWeight.w500,
                                      isPoppins: true),
                                  AppText(
                                      title: 'debra.holt@example.com',
                                      fontSize: 1.6.h,
                                      fontWeight: FontWeight.w500,
                                      isPoppins: true),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    index == 4 ? SizedBox() : appDivider(context: context),
                    // index == contactList.length - 1 ? SizedBox() : appDivider(context: context),
                  ],
                ),
              );
            }),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}
