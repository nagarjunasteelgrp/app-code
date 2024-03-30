// ignore_for_file: must_be_immutable

import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MenuTile extends StatelessWidget {
  String icon;
  String title;
  int index;
  Color color;
  double? iconHeight;
  MenuTile(
      {super.key,
      required this.icon,
      this.iconHeight,
      required this.index,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, _) {
      return GestureDetector(
        onTap: () {
          value.setSelectedIndex(index);
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
                        child: SvgPicture.asset(icon, height: iconHeight ?? 4.h,
                            fit:  BoxFit.fill,
                            color: Theme.of(context).colorScheme.background,)
                        // Image.asset(
                        //   icon,
                        //   height: iconHeight ?? 4.h,
                        //   fit:  BoxFit.fill,
                        //   color: Theme.of(context).colorScheme.background,
                        // )
                    ),
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
            appDivider(context: context ,vertical: 0.4.h, colors: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
          ],
        ),
      );
    });
  }
}
