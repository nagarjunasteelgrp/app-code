import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

class AppDialogBox {

static Future<void> showConfirmationDialog({
  required BuildContext context,
  required VoidCallback onYes,
  required String headerTitle,
  required String title,
  String? customButtonText,
})
async {
  bool isLoading = false;
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  title: title,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  maxLines: 3,
                  color: AppColors.BLACK_COLOR,
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  title: headerTitle,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  fontSize: 14,
                  maxLines: 2,
                  color: AppColors.BLACK_COLOR,
                ),
                SizedBox(height: 4.h),
                isLoading
                    ? const Center(
                  child: SpinKitLoader(),
                )
                    : Row(
                  children: [
                    Expanded(
                      child: appButton(
                        onTap: () {
                          Get.back();
                        },
                        child: AppText(
                          title: 'Cancel',
                          fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                        context: context,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: appButton(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          Future.delayed(const Duration(seconds: 2), () {
                            onYes();
                            isLoading = false;
                            Get.back();
                          });
                        },
                        child: AppText(
                          title: customButtonText ?? 'yes',
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                        ),
                        context: context,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

}
