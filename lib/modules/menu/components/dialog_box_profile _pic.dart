import 'dart:io';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

Widget profilePckDialogBox(value) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppText(
            fontSize: 18,
            title: 'Profile Picture',
            fontWeight: FontWeight.bold,
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: value.profilePicture != 'null' &&
                    value.profilePicture != null
                ? value.profilePicture!.startsWith('http')
                    ? NetworkImage(value.profilePicture!)
                    : FileImage(File(value.profilePicture!)) as ImageProvider
                : const AssetImage('assets/images/dummy_person.png'),
          ),
          appButton(
            height: 4.h,
            context: Get.context!,
            child: AppText(
              title: 'Upload',
              fontSize: 1.7.h,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                value.updateProfilePicture(image.path);
                Get.back();
              }
            },
          ),
        ],
      ),
    ),
  );
}
