import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';

class DarkModecontroller extends GetxController {
  @override
  void onInit() {
    Get.put(AppSharedPreferences()).saveIsDarkModeOn(isDarkModeOn.value);
    checkIsDarkModeOn();
    super.onInit();
  }

  checkIsDarkModeOn() async {
    isDarkModeOn.value = await Get.find<AppSharedPreferences>().getDarkMode();
  }

  var isDarkModeOn = true.obs;
  var isToggled = true.obs;
}
