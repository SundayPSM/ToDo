import 'package:get/get.dart';

class AppConstrains extends GetxController {
  RxBool isWeb = false.obs;
  RxDouble sw = 0.0.obs;
  RxDouble sh = 0.0.obs;
  init(double width, double height) {
    double screenWidth = width;
    double screenHeight = height;
    sw(width);
    sh(height);
    if (screenWidth > 450) {
      isWeb.value = true;
    } else {
      isWeb.value = false;
    }
  }
}
