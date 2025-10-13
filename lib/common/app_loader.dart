import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sizer/sizer.dart';

class SpinKitLoader extends StatelessWidget {
  const SpinKitLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      size: 3.h,
      color: context.theme.colorScheme.primary,
    );
  }
}
