import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';


class SpinKitLoader extends StatelessWidget {
  const SpinKitLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Theme.of(context).colorScheme.primary,
      size: 3.h,
    );
  }
}

