import 'dart:io';
import 'package:digital_lync/constants/app_assets.dart';
import 'package:digital_lync/constants/constants.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'app_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool leadingArrow;
  final double titleFontSize;
  final double? elevation;
  final VoidCallback? onTap;
  final VoidCallback? onTapLogo;

  const CommonAppBar({
    super.key,
    this.title,
    this.elevation,
    this.onTap,
    this.onTapLogo,
    this.leadingArrow = false,
    this.titleFontSize = 20,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 1,
      leading: leadingArrow == false
          ? Consumer<HomeProvider>(
              builder: (context, provider, child) {
                return GestureDetector(
                  onTap: onTapLogo,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Transform.scale(
                        scale: 0.5,
                        child: provider.profilePicture != 'null' &&
                                provider.profilePicture != null
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage: provider.profilePicture!
                                        .startsWith('http')
                                    ? NetworkImage(provider.profilePicture!)
                                    : FileImage(File(provider.profilePicture!))
                                        as ImageProvider)
                            : SvgPicture.asset(AppAssets.APP_PROFILE_SVG)),
                  ),
                );
              },
            )
          : GestureDetector(
              onTap: onTap,
              child: Icon(
                size: 5.w,
                Icons.arrow_back_ios_new,
                color: context.theme.colorScheme.secondary,
              ),
            ),
      actions: actions ?? [],
      title: AppText(
        fontSize: titleFontSize,
        fontWeight: FontWeight.w600,
        title: title ?? Constants.APP_NAME,
        color: context.theme.colorScheme.secondary,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
