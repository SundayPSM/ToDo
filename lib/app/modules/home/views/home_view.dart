import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo/app/data/models/todo_model.dart';
import 'package:todo/app/modules/home/views/widgets/empty_list.dart';
import 'package:todo/app/modules/home/views/widgets/list_tile_card.dart';
import 'package:todo/app_constrain.dart';
import 'package:todo/app_style.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final AppConstrains appConsContoller = Get.isRegistered<AppConstrains>()
      ? Get.find<AppConstrains>()
      : Get.put(AppConstrains());

  @override
  Widget build(BuildContext context) {
    appConsContoller.init(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "TO-DO",
          style: kPromptSemiBold.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: appConsContoller.isWeb.value
              ? kPaddingHorizontal * 0.5
              : kPaddingHorizontal,
        ),
        child: Obx(
          () => controller.tasksLen > 0
              ? ListView.builder(
                  // shrinkWrap: true,
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    TodoModel todoModel = controller.tasks[index];
                    return ListTileCard(
                      task: todoModel,
                    );
                  },
                )
              : EmptyListCard(),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.dialog(
            AlertDialog(
              title: Text(
                'Add TO-DO',
                style: kPromptMedium.copyWith(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              content: InputTextBox(),
            ),
          );
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black12,
              width: 2,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class InputTextBox extends GetView<HomeController> {
  const InputTextBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Form(
              key: controller.formKey,
              child: TextFormField(
                controller: controller.textFieldController,
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Please enter To-Do";
                    }
                  }
                  log("TheTextFormValue $value");
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter todo',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              if (controller.formKey.currentState!.validate()) {
                controller.addTask();
                Get.back();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(3)),
              child: Text(
                'ADD',
                style: kPromptMedium.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
