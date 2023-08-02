import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double calc(int x) {
    return screenHeight / (844 / x);
  }

  static double calcW(int x) {
    return screenWidth / (393 / x);
  }
}
