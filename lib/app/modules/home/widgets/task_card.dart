import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygoals/app/core/utils/extention.dart';
import 'package:mygoals/app/modules/detail/view.dart';
import 'package:mygoals/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../data/models/task.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;

  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squarWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: (){
        homeCtrl.changeTask(task);
        homeCtrl.changeTodo(task.todos ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        width: squarWidth / 2,
        height: squarWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey[300]!, blurRadius: 7, offset: const Offset(0, 7))
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: homeCtrl.isTodoEmpty(task) ? 1 : task.todos!.length,
              currentStep: homeCtrl.isTodoEmpty(task) ? 0 : homeCtrl.getDoneTodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color]),
              unselectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white]),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0.sp,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(height: 2.0.wp,),
                  Text('${task.todos?.length ?? 0} Task', style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
