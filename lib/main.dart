import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo/app/services/database/shared_preference_todo.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding();
  await SharedPreferenceTodo.init();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
