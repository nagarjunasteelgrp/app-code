import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget reportCard ({Color? color, String? title, String? noOfTile}){
  return Container(
    width: 19.h,
    padding: EdgeInsets.symmetric(vertical: 2.5.h,horizontal: 1.5.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1.4.h),
      color: color,
    ),
    child: Column(
      children: [
        AppText(title: title,fontWeight: FontWeight.w600,fontSize: 1.8.h,color: Colors.white,),
        SizedBox(height: 1.h,),
        AppText(title: noOfTile,fontWeight: FontWeight.w600,fontSize: 1.8.h,color: Colors.white,),
      ],
    ),
  );
}