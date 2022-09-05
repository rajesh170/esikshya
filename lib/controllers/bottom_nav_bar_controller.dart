import 'dart:developer';

import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;
  var changeState = true.obs;
  var changeStateOfNotification = true.obs;
  var changeStateOfHomeScreen = true.obs;
  onseleceted(int index) {
    currentIndex.value = index;
    changeState.value = false;
    changeState.value = true;
    if (index == 0) {
      changeStateOfHomeScreen.value = false;
      changeStateOfHomeScreen.value = true;
    }
    if (index == 1) {
      changeStateOfNotification.value = false;
      changeStateOfNotification.value = true;
    }

    log("state changed");
  }
}
