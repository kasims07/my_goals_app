import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygoals/app/core/utils/extention.dart';

import '../../home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
    homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? Column(
      children: [
        Image.asset('assets/images/task.jpg',
        fit: BoxFit.cover,
        height: 65.0.wp,),
        Text('Add Task', style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),)
      ],
    ): ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        ...homeCtrl.doingTodos.map((element) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.0.wp, vertical: 3.0.wp),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  fillColor: MaterialStateProperty.resolveWith((states) => Colors.grey),
                  value: element['done'],
                  onChanged: (value){
                    homeCtrl.doneTodo(element['title']);
                  },
                ),

              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                  child: Text(element['title'], overflow: TextOverflow.fade,),
                ),
              )
            ],
          ),
        )).toList(),
        if(homeCtrl.doingTodos.isNotEmpty) Padding(
          padding:EdgeInsets.symmetric(horizontal: 5.0.wp),
          child: const Divider(thickness: 2,),
        )
      ],
    ));
  }
}
