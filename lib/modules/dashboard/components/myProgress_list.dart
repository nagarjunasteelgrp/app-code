import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget myProgressList(DashboardProvider provider) {
  return SizedBox(
    height: 4.h,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: provider.myProgressList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              provider.selectedIndex = index;
              provider.updateDateRange();
              provider.myProgressAPI();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 2.h),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: index == provider.selectedIndex
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(1.8.h),
                  border: index == provider.selectedIndex
                      ? null
                      : Border.all(
                          color: Theme.of(context).colorScheme.secondary),
                ),
                child: Center(
                  child: AppText(
                    title: provider.myProgressList[index],
                    fontWeight: FontWeight.bold,
                    color: index == provider.selectedIndex
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          );
        }),
  );
}
