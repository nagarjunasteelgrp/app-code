import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'app_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool leadingArrow;
  final double titleFontSize; // Added font size parameter
  final double? elevation; // Added font size parameter
  VoidCallback? onTap;
   CommonAppBar({
    super.key,
    this.title,
    this.elevation,
    this.onTap,
    this.leadingArrow = false,
    this.titleFontSize = 20, // Default font size
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 1,
      leading: leadingArrow == false
          ? Transform.scale(
              scale: 0.55, child: SvgPicture.asset(AppAssets.APP_PROFILE_SVG))
          : GestureDetector(
        onTap: onTap,
        child: Icon(Icons.arrow_back_ios_new,color: Theme.of(context).colorScheme.secondary,size: 5.w,),
      ),
      title: AppText(
        title: title ?? Constants.APP_NAME,
        fontWeight: FontWeight.w600,
        fontSize: titleFontSize, // Using the passed font size
        color: Theme.of(context).colorScheme.secondary,
      ),
      actions: actions ??
          [
            SvgPicture.asset(AppAssets.APP_SEARCH_SVG),
            SizedBox(
              width: 1.5.h,
            ),
            SvgPicture.asset(AppAssets.APP_NOTIFICATION_SVG),
            SizedBox(
              width: 1.h,
            ),
          ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
