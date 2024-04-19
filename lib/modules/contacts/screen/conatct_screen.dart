import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_dropdown_button_contacts.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfiled.dart';
import 'package:digital_lync/modules/contacts/components/dailog_box.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
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
                                  colors: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
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
                          GestureDetector(
                            onTap: () {
                              contactProvider.toggleListOrder();
                            },
                            child: Column(
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
                          ),
                          Consumer<ContactProvider>(
                              builder: (context, provider, _) {
                            return GestureDetector(
                              onTap: () {
                                showContactDialog(context);
                              },
                              child: Column(
                                children: [
                                  appCircleIcon(
                                      context: context,
                                      colors: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
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
                    appDivider(context: context, vertical: 0.6.h),
                    Consumer<ContactProvider>(
                      builder: (context, provider, child) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                          child: appTextField(
                            context: context,
                            suffixIcon: Icon(Icons.search,
                                size: 3.h,
                                color: Theme.of(context).colorScheme.secondary),
                            controller: contactProvider.searchController,
                            hint: 'Search...',
                            onChanged: (query){
                                provider.searchContacts(query);
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 1.h),
                    Consumer<ContactProvider>(builder: (context, provider, _) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                        child: dropdownContactsWidget(
                          title: 'Type',
                          context: context,
                          value: provider.selectedValue.toString(),
                          items:
                              List.generate(provider.dropDown.length, (index) {
                            var data = provider.dropDown[index];
                            var value = data.toString();
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.only(left: 0.5.w),
                                child: AppText(
                                  title:
                                      "${data[0].toUpperCase()}${data.substring(1)}",
                                ),
                              ),
                            );
                          }),
                          onChanged: (newValue) {
                            provider.dropDownSelectedValue(newValue);
                            provider.contactTypeController =
                                TextEditingController(
                                    text: newValue ?? 'customer');
                            provider.listOfContacts();
                          },
                        ),
                      );
                    }),
                    SizedBox(height: 1.h),
                    Consumer<ContactProvider>(builder: (context, provider, _) {
                      provider.displayList = provider.searchQuery.isNotEmpty ? provider.filteredContactList : provider.contactList;
                      print("PROVIDER LIST: ${provider.filteredContactList}");
                      return provider.contactList.length < 0
                          ? Padding(
                              padding: EdgeInsets.only(top: 30.h),
                              child: Center(
                                child: AppText(
                                  title: Constants.result_not_found,
                                ),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  provider.displayList.length, (index) {
                                final contactIndex = provider.isListReversed
                                    ? provider.displayList.length - 1 - index
                                    : index;
                                final contact =
                                    provider.displayList[contactIndex];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.5.h, vertical: 0.5.h),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(RoutesName.TRACKING,
                                              arguments: {
                                                'id': contact['id'],
                                                'companyName':
                                                    contact['companyName'],
                                                'contactType':
                                                    contact['contactType'],
                                              });
                                          trackingProvider.contactTypeId =
                                              contact['id'];
                                          trackingProvider
                                                  .contactTypeCompanyName =
                                              contact['companyName'];
                                          trackingProvider.contactTypeName =
                                              contact['contactType'];
                                          trackingProvider.trackingInfoAPI();
                                          // Get.toNamed(RoutesName.CONTACTS_LIST , arguments: {
                                          //   'id': contact['id'],
                                          // })!.then((value) {
                                          //   provider.listOfContacts();
                                          // });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(1.h),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.2)),
                                            borderRadius:
                                                BorderRadius.circular(1.h),
                                          ),
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(1.5.h),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        1.5.h),
                                                    border: Border.all(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.5))),
                                                child: const Icon(Icons.person),
                                              ),

                                              SizedBox(width: 2.h),
                                              Flexible(child: Text(contact['companyName'],style: TextStyle(fontSize: 2.h)),),
                                              // AppText(
                                              //   title:
                                              //   fontSize: 2.h,
                                              // ),
                                              const Spacer(),
                                              const Icon(Icons
                                                  .arrow_forward_ios_rounded),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );
                    }),
                  ],
                ),
              ),
              if (value.isLoading)
                const Center(
                  child: SpinKitLoader(),
                )
            ],
          );
        }),
      ),
    );
  }
}
