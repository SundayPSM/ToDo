import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/models/todo_model.dart';
import 'package:todo/app/modules/home/controllers/home_controller.dart';
import 'package:todo/app_constrain.dart';
import 'package:todo/app_style.dart';

class ListTileCard extends GetView<HomeController> {
  ListTileCard({super.key, required this.task});
  final TodoModel task;

  final AppConstrains appConsContoller = Get.isRegistered<AppConstrains>()
      ? Get.find<AppConstrains>()
      : Get.put(AppConstrains());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: EdgeInsets.symmetric(
            vertical: appConsContoller.sh * 0.02,
            // horizontal: appConsContoller.sw * 0.03,
          ),
          decoration: BoxDecoration(
            color: task.isCompleted
                ? Colors.green.shade100
                : Color.fromRGBO(224, 224, 224, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Dismissible(
            key: Key(task.id),
            direction: DismissDirection.startToEnd,
            background: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            onDismissed: (value) {
              log(" Dismissible Value ");
              controller.deleteTask(task);
              // TODO: on swipe please delete it
            },
            child: ListTile(
              leading: Checkbox(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  checkColor: task.isCompleted ? Colors.white : Colors.black,
                  hoverColor: primaryColor,
                  fillColor: MaterialStateColor.resolveWith(
                    (states) => task.isCompleted ? Colors.black : primaryColor,
                  ),
                  value: task.isCompleted,
                  onChanged: (value) {
                    log("value  $value");
                    TodoModel t = task.copyWith(isCompleted: value);
                    controller.updateTask(t);
                    print(task.toString());
                  }),
              title: Text(
                task.description,
                style: kPromptMedium.copyWith(
                  color: Colors.black,
                ),
              ),
              // style: ListTileStyle.drawer,
            ),
          ),
        ));
  }
}
