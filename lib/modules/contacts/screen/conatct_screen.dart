import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/contacts/components/dailog_box.dart';
import 'package:flutter/material.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
ContactProvider contactProvider = ContactProvider();
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: contactProvider,
      child: Scaffold(
        body: Consumer<ContactProvider>(builder: (context, value, _) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
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
                                title: Constants.filter,
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
                                title: Constants.sort,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                          Consumer<ContactProvider>(builder: (context, provider, _) {
                            return  GestureDetector(
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
                                          AppAssets.APP_CONTACTS_SVG,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 0.7.h,
                                  ),
                                  AppText(
                                    title: Constants.new_Contact,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                    appDivider(context: context,vertical: 0.6.h),
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
                            child: SvgPicture.asset(AppAssets.APP_CONTACTS_SVG,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(width: 2.w),
                          AppText(
                              title: Constants.contacts,
                              fontSize: 1.8.h,
                              fontWeight: FontWeight.w500,
                              ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Consumer<ContactProvider>(builder: (context, provider, _) {
                      return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(provider.contactList.length, (index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Get.toNamed(RoutesName.CONTACTS_LIST , arguments: {
                                    'id': provider.contactList[index]['id'],
                                  });
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  title: '${Constants.company_Name} :',
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 0.8.h,
                                                ),
                                                AppText(
                                                  title: '${Constants.person_Name} :',
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 0.8.h,
                                                ),
                                                AppText(
                                                  title: '${Constants.contact_Type} :',
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 0.8.h,
                                                ),
                                                AppText(
                                                  title: '${Constants.phone_Number} :',
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 0.8.h,
                                                ),
                                                AppText(
                                                  title: '${Constants.email_Id} :',
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 0.8.h,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                    title: provider.contactList[index]['companyName'],
                                                    fontSize: 1.6.h,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary),
                                                SizedBox(
                                                  height: 0.8.h,
                                                ),
                                                AppText(
                                                    title: provider.contactList[index]['personName'],
                                                    fontSize: 1.6.h,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary),
                                                SizedBox(
                                                  height: 0.8.h,
                                                ),
                                                AppText(
                                                  title: provider.contactList[index]['contactType'],
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(
                                                  height: 0.8.h,
                                                ),
                                                AppText(
                                                  title: provider.contactList[index]['phone'],
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(
                                                  height: 0.8.h,
                                                ),
                                                AppText(
                                                  title: provider.contactList[index]['email'],
                                                  fontSize: 1.6.h,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(
                                                  height: 0.8.h,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              index == 4 ? SizedBox() : appDivider(context: context),
                              // index == contactList.length - 1 ? SizedBox() : appDivider(context: context),
                            ],
                          );
                        }),
                      );
                    }),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              if (value.isLoading)
               Center(
                 child: SpinKitLoader(),
               )
            ],
          );
        }),
      ),
    );
  }
}
