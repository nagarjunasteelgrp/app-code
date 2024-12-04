import 'dart:io';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

Widget profilePckDialogBox(value) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // Add rounded corners
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0), // Add some padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Profile Picture',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16), // Space between title and image
          CircleAvatar(
            radius: 80,
            backgroundImage: value.profilePicture != 'null' &&
                    value.profilePicture != null
                ? value.profilePicture!.startsWith('http')
                    ? NetworkImage(value.profilePicture!)
                    : FileImage(File(value.profilePicture!)) as ImageProvider
                : const AssetImage('assets/images/dummy_person.png'),
          ),
          const SizedBox(height: 16), // Space between image and button
          appButton(
            child: AppText(
              title: 'Upload',
              fontSize: 1.7.h,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            context: Get.context!,
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                value.updateProfilePicture(image.path);
                Navigator.of(Get.context!).pop();
              }
            },
            height: 4.h,
          ),
        ],
      ),
    ),
  );
}
