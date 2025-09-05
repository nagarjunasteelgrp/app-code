// ignore_for_file: must_be_immutable
import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dialog_box_profile _pic.dart';

class MenuTile extends StatelessWidget {
  String? svgImage;
  String title;
  int index;
  Color color;
  double? iconHeight;
  IconData? icon;

  MenuTile(
      {super.key,
      this.svgImage,
      this.iconHeight,
      this.icon,
      required this.index,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, _) {
      return InkWell(
        onTap: () async {
          print("Profile Pic Clicked $index");
          if (index == 4) {
            showDialog(
              context: context,
              builder: (context) {
                return profilePckDialogBox(value);
              },
            );
          } else if (index == 5) {
            // showLocationDisclosureDialog(context);
            await launchUrl(
              Uri.parse('https://www.nagarjunasteel.com/privacy-policy'),
            );
          } else {
            value.setSelectedIndex(index, tabIndex: false);
          }
        },
        child: Column(
          children: [
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    appCircleIcon(
                        context: context,
                        colors: color,
                        radius: 1.w,
                        height: 4.h,
                        width: 4.h,
                        child: icon != null
                            ? Icon(icon, color: AppColors.WHITE_COLOR)
                            : SvgPicture.asset(
                                svgImage!,
                                height: iconHeight ?? 4.h,
                                fit: BoxFit.fill,
                                color: Theme.of(context).colorScheme.background,
                              )),
                    SizedBox(
                      width: 2.w,
                    ),
                    AppText(
                      fontWeight: FontWeight.w600,
                      title: title,
                      fontSize: 1.4.h,
                    )
                  ],
                ),
              ),
            ),
            appDivider(
                context: context,
                vertical: 0.4.h,
                colors: Theme.of(context)
                    .colorScheme
                    .secondary
                    .withValues(alpha: 0.3)),
          ],
        ),
      );
    });
  }
}
