// ignore_for_file: must_be_immutable

import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
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
        child: Container(
            height: 8.h,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).colorScheme.onBackground,
                      offset: const Offset(0, 1),
                      blurRadius: 2)
                ]),
            child: GestureDetector(
              
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
                        child: Image.asset(
                          icon,
                          height: iconHeight ?? 4.h,
                          color: Theme.of(context).colorScheme.background,
                        )),
                    SizedBox(
                      width: 2.w,
                    ),
                    AppText(
                      fontWeight: FontWeight.w600,
                      title: title,
                      fontSize: 1.4.h,
                      isPoppins: true,
                    )
                  ],
                ),
              ),
            )),
      );
    });
  }
}
