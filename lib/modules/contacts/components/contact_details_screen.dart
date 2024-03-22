import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/modules/contacts/components/contact%20details/conatct_extra_details_screen.dart';
import 'package:digital_lync/modules/contacts/components/contact%20details/contact_details_list.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                            AppAssets.APP_POST_SVG,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    AppText(
                      title: 'Post',
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),

                Column(
                  children: [
                    appCircleIcon(
                        context: context,
                        colors: Theme.of(context).colorScheme.onPrimary,
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.APP_FILE_SVG,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    AppText(
                      title: 'File',
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                Column(
                  children: [
                    appCircleIcon(
                        context: context,
                        colors: Theme.of(context).colorScheme.error,
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.APP_NEW_TASK_SVG,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    AppText(
                      title: 'New Tasks',
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
                          child: Icon(Icons.more_horiz_outlined,color: Theme.of(context).primaryColor),
                        )),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    AppText(
                      title: 'More',
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Consumer<ContactProvider>(builder: (context, value, _) {
            return value.isDetails
                ? const ContactExtraDetailsScreen()
                : const ContactDetailsListScreen();
          }),
        ],
      ),
    );
  }
}
