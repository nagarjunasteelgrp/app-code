import 'package:digital_lync/common/app_divider.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/dashboard/components/widget_pieChart.dart';
import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
  value: DashboardProvider(),
  child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: 3.h),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.5.h, vertical: 1.5.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(1.4.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title: 'MY PROGRESS',
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 1.5.h),
                      SizedBox(
                        height: 4.h,
                        child: Consumer<DashboardProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: provider.myProgressList.length, itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Provider.of<DashboardProvider>(context, listen: false).selectedIndex = index;
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 2.h),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 0.5.h),
                                    decoration: BoxDecoration(
                                      color: index == provider.selectedIndex ? Theme.of(context).colorScheme.primary : Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(1.8.h),
                                      border: index == provider.selectedIndex ? null :  Border.all(color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    child: Center(
                                      child: AppText(
                                        title: provider.myProgressList[index],fontWeight: FontWeight.bold,
                                        color: index == provider.selectedIndex ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      appDivider(context: context,colors: Theme.of(context).colorScheme.secondary,vertical: 0.5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Column(
                            children: [
                              AppText(title: '22',fontWeight: FontWeight.bold,),
                              SizedBox(height: 0.5.h),
                              AppText(title: 'No. of Visits',color: Theme.of(context).colorScheme.onSecondary,),
                            ],
                          ),
                            Dash(
                                direction: Axis.vertical,
                                length: 60,
                                dashLength: 3,
                                dashColor: Theme.of(context).colorScheme.secondary),
                            Column(
                              children: [
                                AppText(title: '10',fontWeight: FontWeight.bold,),
                                SizedBox(height: 0.5.h),
                                AppText(title: 'New Contacts',color: Theme.of(context).colorScheme.onSecondary,),
                              ],
                            ),
                            Dash(
                                direction: Axis.vertical,
                                length: 60,
                                dashLength: 3,
                                dashColor: Theme.of(context).colorScheme.secondary),
                            Column(
                              children: [
                                AppText(title: '7 hrs',fontWeight: FontWeight.bold,),
                                SizedBox(height: 0.5.h),
                                AppText(title: 'Working hours',color: Theme.of(context).colorScheme.onSecondary,),
                              ],
                            ),
                          ],
                        ),
                      ),
                      appDivider(context: context,colors: Theme.of(context).colorScheme.secondary,vertical: 0.5.h,),
                      Center(child: AppText(title: 'Total No of Contacts 200',fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onSecondary,letterSpacing: 0.5,)),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 1.5.h, vertical: 1.5.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(1.4.h),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: 'New Enrollment',fontWeight: FontWeight.bold,letterSpacing: 0.4,fontSize: 1.8.h,),
                    Consumer<DashboardProvider>(builder: (context, provider, _) {
                      return Container(
                        width: 12.h,
                        height: 3.8.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(1.5.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.h),
                          child: Center(
                            child: Consumer<DashboardProvider>(builder: (context, provider, _) {
                              return   DropdownButton<String>(
                                isDense: true,
                                iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
                                iconDisabledColor: Theme.of(context).colorScheme.onSecondary,
                                isExpanded: true,
                                underline: const SizedBox(),
                                value: provider.selectedValue.toString(),
                                focusColor: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(1.0.w),
                                dropdownColor: Theme.of(context).colorScheme.background,
                                hint: Text(
                                  "--Select--",
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,color: Theme.of(context).colorScheme.inverseSurface,
                                  size: 3.h,
                                ),
                                items: List.generate(provider.dropDown.length, (index) {
                                  var data = provider.dropDown[index];
                                  var value = data.toString();
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 0.5.w),
                                      child: AppText(
                                        title:
                                        "${data[0].toUpperCase()}${data.substring(1)}",fontSize: 1.5.h,color: Theme.of(context).colorScheme.inverseSurface,fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                                style: TextStyle(fontWeight: FontWeight.w800,fontSize: 1.9.h),
                                onChanged: (newValue) {
                                  provider.dropDownSelectedValue(newValue);
                                },
                              );
                            }),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                pieChartWidget(context),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 1.5.h,
                          width: 1.5.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.h),
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        SizedBox(width: 1.h,),
                        AppText(title: 'Dealers',color: Theme.of(context).colorScheme.onSecondary,),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 1.5.h,
                          width: 1.5.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.h),
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        SizedBox(width: 1.h,),
                        AppText(title: 'Fabricator',color: Theme.of(context).colorScheme.onSecondary,),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 1.5.h,
                          width: 1.5.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.h),
                            color: Theme.of(context).colorScheme.onInverseSurface,
                          ),
                        ),
                        SizedBox(width: 1.h,),
                        AppText(title: 'Customer',color: Theme.of(context).colorScheme.onSecondary,),
                      ],
                    ),
                  ],
                ),
              ],
            ),),
              ],
            ),
          ),
        )
    ),
);
  }
}
