import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ContactExtraDetailsScreen extends StatelessWidget {
  const ContactExtraDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          appDivider(context: context),
          AppText(title: 'Details',fontWeight: FontWeight.w500,fontSize: 1.6.h,isPoppins: true),
          appDivider(context: context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: AppText(title: 'Address',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true,)),
                Expanded(child: AppText(title: '2972 Westheimer Rd.\nSanta Ana, Illinois 85486 ',fontWeight: FontWeight.w400, fontSize: 1.5.h,color: Theme.of(context)
                    .colorScheme
                    .secondary,isPoppins: true,)),
              ],
            ),
          ),
          appDivider(context: context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: AppText(title: 'Tax Id',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true)),
                Expanded(child: AppText(title: '',fontWeight: FontWeight.w500, fontSize: 1.5.h,color: Theme.of(context)
                    .colorScheme
                    .onPrimary,isPoppins: true)),
              ],
            ),
          ),
          appDivider(context: context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: AppText(title: 'Additional info ',fontWeight: FontWeight.w500, fontSize: 1.5.h,isPoppins: true)),
                Expanded(child: AppText(title: '',fontWeight: FontWeight.w500, fontSize: 1.5.h,color: Theme.of(context)
                    .colorScheme
                    .onPrimary)),
              ],
            ),
          ),
          appDivider(context: context),
        ],
      ),
    );
  }
}
