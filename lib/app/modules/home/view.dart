import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mygoals/app/core/utils/values/colors.dart';
import 'package:mygoals/app/data/models/task.dart';
import 'package:mygoals/app/modules/home/controller.dart';
import 'package:mygoals/app/core/utils/extention.dart';
import 'package:mygoals/app/modules/home/widgets/add_card.dart';
import 'package:mygoals/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                "My List",
                style:
                    TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.tasks
                      .map((element) => LongPressDraggable(
                          data: element,
                          onDragStarted: () => controller.changeDeleting(true),
                          onDragEnd: (_) => controller.changeDeleting(false),
                          onDraggableCanceled: (_, __) =>
                              controller.changeDeleting(false),
                          feedback: Opacity(
                            opacity: 0.8,
                            child: TaskCard(task: element),
                          ),
                          child: TaskCard(task: element)))
                      .toList(),
                  AddCard()
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_,__,___){
          return Obx(
                () => FloatingActionButton(
              onPressed: () {},
              backgroundColor: controller.deleting.value ? Colors.red : blue,
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task){
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Sucess');
        },
      ),
    );
  }
}
