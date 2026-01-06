import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/notification/common/delete_notification_dialog.dart';
import 'package:digital_lync/modules/notification/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        elevation: 0.5,
        leadingArrow: true,
        title: 'Notification',
        onTap: () => Get.back(),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            color: context.theme.iconTheme.color,
            onPressed: () => customDialogBoxNotification(context),
          )
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: NotificationProvider(),
        child: Consumer<NotificationProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading == true) {
              return const Center(child: SpinKitLoader());
            }

            if (provider.notificationList.isEmpty) {
              return const Center(child: AppText(title: "No Notification"));
            }

            return ListView.builder(
              itemCount: provider.notificationList.length,
              padding: EdgeInsets.symmetric(vertical: 1.h),
              itemBuilder: (context, index) {
                final notification = provider.notificationList[index];

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  margin:
                      EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: context.theme.colorScheme.secondary
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: ListTile(
                    title: AppText(
                      title: "${notification['dealerName']}",
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: AppText(
                            maxLines: 5,
                            fontSize: 12.sp,
                            title: "${notification['notes']}",
                          ),
                        ),
                        AppText(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                          title: "${notification['formattedFollowUpDate']}",
                        ),
                      ],
                    ),
                    trailing: AppText(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                      title: notification['status'],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
