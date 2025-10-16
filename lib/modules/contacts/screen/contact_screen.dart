import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_dropdown_button_contacts.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/common/app_textfield.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/contacts/components/contact_update_dialog.dart';
import 'package:digital_lync/modules/contacts/components/dialog_box.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:digital_lync/modules/tracking/screen/tracking_screen.dart';
import 'package:digital_lync/routes/routes_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

ContactProvider contactProvider = ContactProvider();

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    contactProvider.listOfContacts();
    return ChangeNotifierProvider.value(
      value: contactProvider,
      child: Scaffold(
        body: Consumer<ContactProvider>(builder: (context, value, _) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(top: 1.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                appDivider(context: context, vertical: 0.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => contactProvider.toggleListOrder(),
                      child: Column(
                        spacing: 0.7.h,
                        children: [
                          appCircleIcon(
                            context: context,
                            colors: context.theme.colorScheme.scrim,
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.APP_SORT_ARROW_SVG,
                                colorFilter: ColorFilter.mode(
                                  context.theme.primaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          const AppText(
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
                            provider.clearData();
                            showCreateContactDialog(context);
                          },
                          child: Column(
                            spacing: 0.7.h,
                            children: [
                              appCircleIcon(
                                context: context,
                                colors: context.theme.colorScheme.onPrimary,
                                child: SvgPicture.asset(
                                  AppAssets.APP_CONTACTS_SVG,
                                  colorFilter: ColorFilter.mode(
                                    context.theme.primaryColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              AppText(
                                fontWeight: FontWeight.w500,
                                title: Constants.new_Contact,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    Consumer<ContactProvider>(
                      builder: (context, provider, child) {
                        return GestureDetector(
                          onTap: () {
                            if (provider.contactId != null) {
                              provider.contactDetailsAPI();
                              showContactUpdateDialog(context,
                                  selectedValue: provider.selectedValue);
                            }
                          },
                          child: Column(
                            spacing: 0.7.h,
                            children: [
                              appCircleIcon(
                                context: context,
                                colors:
                                    context.theme.colorScheme.inversePrimary,
                                child: Icon(
                                  Icons.edit,
                                  color: context.theme.primaryColor,
                                ),
                              ),
                              AppText(
                                title: Constants.edit,
                                fontWeight: FontWeight.w500,
                                color: provider.contactId != null
                                    ? context.theme.textTheme.bodyLarge!.color
                                    : context.theme.disabledColor,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                appDivider(context: context, vertical: 0.5.h),
                Consumer<ContactProvider>(
                  builder: (context, provider, child) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                      child: appTextField(
                        context: context,
                        hint: ' Search...',
                        suffixIcon: Icon(
                          size: 3.h,
                          Icons.search,
                          color: context.theme.colorScheme.secondary,
                        ),
                        controller: contactProvider.searchController,
                        onChanged: (query) {
                          provider.searchContacts(query);
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 1.h),
                Consumer<ContactProvider>(
                  builder: (context, provider, _) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                      child: dropdownContactsWidget(
                        title: 'Type',
                        context: context,
                        value: provider.selectedValue.toString(),
                        items: provider.dropDown.map((data) {
                          return DropdownMenuItem<String>(
                            value: data,
                            child: AppText(
                              title:
                                  "${data[0].toUpperCase()}${data.substring(1)}",
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          provider.contactId = null;
                          provider.dropDownSelectedValue(newValue);
                          provider.selectedContactIndex = -1;
                          provider.contactTypeController.text =
                              newValue ?? 'customer';
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 1.h),
                Consumer<ContactProvider>(
                  builder: (context, provider, _) {
                    return (value.isLoading)
                        ? Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: const Center(child: SpinKitLoader()),
                          )
                        : provider.contactList.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Center(
                                  child: AppText(
                                    title: Constants.result_not_found,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: provider.displayList.length,
                                itemBuilder: (context, index) {
                                  final contactIndex = provider.isListReversed
                                      ? provider.displayList.length - 1 - index
                                      : index;
                                  final contact =
                                      provider.displayList[contactIndex];

                                  return InkWell(
                                    onLongPress: () {
                                      provider.contactId = contact['id'];
                                      provider.selectContactIndex(contactIndex);
                                    },
                                    onTap: () {
                                      Get.toNamed(
                                        RoutesName.TRACKING,
                                        arguments: {
                                          'id': contact['id'],
                                          'companyName': contact['companyName'],
                                          'contactType': contact['contactType'],
                                        },
                                      );

                                      trackingProvider.contactTypeId =
                                          contact['id'];
                                      trackingProvider.contactTypeCompanyName =
                                          contact['companyName'];
                                      trackingProvider.contactTypeName =
                                          contact['contactType'];
                                      trackingProvider.trackingInfoAPI();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(1.h),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 0.5.h, horizontal: 1.5.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1.h),
                                        border: Border.all(
                                          color:
                                              provider.selectedContactIndex ==
                                                      contactIndex
                                                  ? context.theme.colorScheme
                                                      .secondary
                                                  : context.theme.colorScheme
                                                      .secondary
                                                      .withValues(alpha: 0.2),
                                        ),
                                      ),
                                      child: Row(
                                        spacing: 2.w,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              spacing: 2.h,
                                              children: [
                                                Container(
                                                  padding:
                                                      EdgeInsets.all(1.5.h),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      1.5.h,
                                                    ),
                                                    border: Border.all(
                                                      color: provider
                                                                  .selectedContactIndex ==
                                                              contactIndex
                                                          ? context
                                                              .theme
                                                              .colorScheme
                                                              .secondary
                                                          : context
                                                              .theme
                                                              .colorScheme
                                                              .secondary
                                                              .withValues(
                                                                  alpha: 0.5),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    size: 2.h,
                                                    CupertinoIcons.person_alt,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: AppText(
                                                    fontSize: 2.h,
                                                    title:
                                                        contact['companyName'],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward_ios_rounded),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
