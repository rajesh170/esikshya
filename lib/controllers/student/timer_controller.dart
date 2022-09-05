import 'dart:async';

import 'package:get/get.dart';

class CountController extends GetxController {
  int count = 59;

  void startCounter() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count > 0) {
        count--;
        update();
      }
    });
  }
}
