import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/app/data/models/todo_model.dart';

class SharedPreferenceTodo {
  SharedPreferenceTodo._();
  static SharedPreferences? _prefs;
  static String nameOfCollection = "tasks";

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    log("Shared Preferences Get Instance");
  }

  static addTask(TodoModel todoModel) {
    List<TodoModel> listOfTodoModel = [];
    if (_prefs!.getString(nameOfCollection) == null) {
      listOfTodoModel.add(todoModel);
    } else {
      listOfTodoModel = getTasks();
      listOfTodoModel.add(todoModel);
    }
    setTasks(listOfTodoModel);
  }

  static updateTask(TodoModel todoModel) {
    if (_prefs!.getString(nameOfCollection) == null) {
      // listOfTodoModel.add(todoModel);
    } else {
      List<TodoModel> listOfTodoModel = getTasks();
      int index = listOfTodoModel.indexWhere((task) {
        return task.id == todoModel.id;
      });
      if (index != -1) {
        listOfTodoModel[index] = todoModel;

        setTasks(listOfTodoModel);
      }
    }
  }

  static deleteTask(TodoModel todoModel) {
    if (_prefs!.getString(nameOfCollection) == null) {
      // listOfTodoModel.add(todoModel);
    } else {
      List<TodoModel> listOfTodoModel = getTasks();
      int index = listOfTodoModel.indexWhere((task) {
        return task.id == todoModel.id;
      });
      if (index != -1) {
        listOfTodoModel.removeAt(index);
        setTasks(listOfTodoModel);
      }
    }
  }

  static List<TodoModel> getTasks() {
    final taskListStr = _prefs!.getString(nameOfCollection);
    List<TodoModel> listOfTodoModel = todoModelsFromJsonList(taskListStr!);
    return listOfTodoModel;
  }

  static List<TodoModel> allTasks() {
    return _prefs!.getString(nameOfCollection) == null ? [] : getTasks();
  }

  static setTasks(List<TodoModel> tasks) {
    _prefs!.setString(
      nameOfCollection,
      todoModelsListToJson(tasks),
    );
  }
}
