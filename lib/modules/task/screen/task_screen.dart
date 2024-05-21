import 'package:digital_lync/modules/task/components/task_container_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Column(
            children: List.generate(
                10,
                (index) => taskContainerUI(
                      context,
                      title: 'Meeting Dealer at this location in 3 hours',
                      type: 'notification',
                    )),
          ),
        ),
      ),
    );
  }
}
