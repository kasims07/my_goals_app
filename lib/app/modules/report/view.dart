import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mygoals/app/core/utils/extention.dart';
import 'package:mygoals/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../core/utils/values/colors.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Obx(() {
        var createdTask = homeCtrl.getTotalTask();
        var completedTask = homeCtrl.getTotalDoneTask();
        var liveTask = createdTask - completedTask;
        var percent = (completedTask / createdTask * 100);
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                'My Report',
                style:
                TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
              child: Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 3.0.wp, horizontal: 4.0.wp),
              child: const Divider(
                thickness: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 5.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatud(Colors.green, liveTask, 'Live'),
                  _buildStatud(Colors.orange, completedTask, 'Completed'),
                  _buildStatud(Colors.blue, createdTask, 'Created'),
                ],
              ),
            ),
            SizedBox(height: 8.0.wp,),
            UnconstrainedBox(
              child: SizedBox(
                width: 70.0.wp,
                height: 70.0.wp,
                child: CircularStepProgressIndicator(
                  totalSteps: createdTask == 0 ? 1 : createdTask,
                  currentStep: completedTask,
                  stepSize: 20,
                  selectedColor: green,
                  unselectedColor: Colors.grey[200],
                  padding: 0,
                  width: 150,
                  height: 150,
                  selectedStepSize: 22,
                  roundedCap: (_, __) => true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${createdTask == 0 ? 0 : percent} %', style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 1.0.wp,),
                      Text("Efficiency", style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),)
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    ));
  }

  Row _buildStatud(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 0.5.wp,
                color: color,
              )
          ),
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$number', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16.0.sp),),
            SizedBox(height: 2.0.wp,),
            Text(text,
            style: TextStyle(
              fontSize: 12.0.sp,
              color: Colors.grey
            ),)
          ],
        )
      ],);
  }
}
