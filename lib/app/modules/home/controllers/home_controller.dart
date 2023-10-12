import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/models/todo_model.dart';
import 'package:todo/app/services/database/shared_preference_todo.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  TextEditingController textFieldController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxList<TodoModel> tasks = <TodoModel>[
    TodoModel(
        id: "1", description: "I should complete Task -1", isCompleted: false),
    TodoModel(
        id: "2", description: "I should complete Task -2", isCompleted: false),
    TodoModel(
        id: "3", description: "I should complete Task -3", isCompleted: false),
    TodoModel(
        id: "4", description: "I should complete Task -4", isCompleted: false),
    TodoModel(
        id: "5", description: "I should complete Task -5", isCompleted: false),
    TodoModel(
        id: "6", description: "I should complete Task -6", isCompleted: false),
    TodoModel(
        id: "7", description: "I should complete Task -7", isCompleted: false),
  ].obs;
  RxInt get tasksLen => tasks.length.obs;
  getAllTasks() {
    tasks.value = SharedPreferenceTodo.allTasks();
  }

  addTask() {
    final uuid = Uuid();

    TodoModel task = TodoModel(
        id: uuid.v4(),
        description: textFieldController.text,
        isCompleted: false);
    tasks.add(task);
    SharedPreferenceTodo.addTask(task);
    textFieldController.clear();
  }

  updateTask(TodoModel task) {
    int index = tasks.indexWhere((element) => task.id == element.id);
    if (index != -1) {
      tasks[index] = task;
      SharedPreferenceTodo.updateTask(task);
    }
  }

  deleteTask(TodoModel task) {
    int index = tasks.indexWhere((element) => task.id == element.id);
    if (index != -1) {
      tasks.removeAt(index);
      SharedPreferenceTodo.deleteTask(task);
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getAllTasks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
