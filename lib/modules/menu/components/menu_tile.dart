import 'package:digital_lync/common/app_circle_icon.dart';
import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dialog_box_profile _pic.dart';

class MenuTile extends StatelessWidget {
  final int index;
  final Color color;
  final String title;
  final IconData? icon;
  final String? svgImage;
  final double? iconHeight;

  MenuTile({
    this.icon,
    super.key,
    this.svgImage,
    this.iconHeight,
    required this.index,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, _) {
        return InkWell(
          onTap: () async {
            if (index == 4) {
              showDialog(
                context: context,
                builder: (context) {
                  return profilePckDialogBox(value);
                },
              );
            } else if (index == 5) {
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
                    spacing: 2.w,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      appCircleIcon(
                        width: 4.h,
                        height: 4.h,
                        radius: 1.w,
                        colors: color,
                        context: context,
                        child: icon != null
                            ? Icon(icon, color: AppColors.WHITE_COLOR)
                            : SvgPicture.asset(
                                svgImage!,
                                height: iconHeight ?? 4.h,
                                fit: BoxFit.fill,
                                colorFilter: ColorFilter.mode(
                                  context.theme.colorScheme.surface,
                                  BlendMode.srcIn,
                                ),
                              ),
                      ),
                      AppText(
                        title: title,
                        fontSize: 1.4.h,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
              ),
              appDivider(
                vertical: 0.4.h,
                context: context,
                colors:
                    context.theme.colorScheme.secondary.withValues(alpha: 0.3),
              ),
            ],
          ),
        );
      },
    );
  }
}
