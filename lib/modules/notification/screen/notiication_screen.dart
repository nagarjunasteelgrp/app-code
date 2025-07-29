import 'package:digital_lync/common/app_bar.dart';
import 'package:digital_lync/common/app_loader.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/notification/common/delete_notification_dailog.dart';
import 'package:digital_lync/modules/notification/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Notification',
        leadingArrow: true,
        actions: [
          GestureDetector(
            onTap: (){
              customDialogBoxNotification(context);
            },
            child: Icon(Icons.delete_outline,color: Theme.of(context).colorScheme.inverseSurface,),
          ),
          SizedBox(width: 4.w),
        ],
        onTap: () {
          Get.back();
        },
      ),
      body: ChangeNotifierProvider.value(
        value: NotificationProvider(),
        child: Consumer<NotificationProvider>(
          builder: (context, provider, child) {
            return (provider.isLoading == true) ? const Center(child: SpinKitLoader()) : provider.notificationList.isEmpty ? const Center(child: Text("No Notification"),) : Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h,),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(provider.notificationList.length, (index) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(
                          horizontal: 4.w,vertical: 1.h
                        ),
                        child: Container(padding: EdgeInsets.symmetric(vertical: 1.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.3))
                          ),
                          child: ListTile(
                           title: AppText(title: "${provider.notificationList[index]['dealerName']}",fontSize: 12,fontWeight: FontWeight.bold,),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: AppText(title: "${provider.notificationList[index]['notes']}",fontSize: 12,maxLines: 5,),
                                ),
                                AppText(title: "${provider.notificationList[index]['formattedFollowUpDate']}",fontSize: 12,),

                              ],
                            ),
                            trailing: AppText(title: provider.notificationList[index]['status'],fontSize: 12,),
                          ),
                        )
                      );
                    }),
                  ),
                )
            );
          }
        )
    ));
  }
}
