import 'package:get/get.dart';
import 'package:esikshya/controllers/bottom_nav_bar_controller.dart';
import 'package:esikshya/controllers/children_details_controller.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/controllers/on_boarding_controller.dart';
import 'package:esikshya/controllers/parent/parent_sign_up_controller.dart';
import 'package:esikshya/controllers/splash_controller.dart';
import 'package:esikshya/controllers/student/student_login_controller.dart';
import 'package:esikshya/controllers/student/student_profile_controller.dart';
import 'package:esikshya/controllers/student/timer_controller.dart';
import 'package:esikshya/data/app_shared_preferences.dart';

class MandatoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<BottomNavController>(() => BottomNavController(), fenix: true);
    Get.lazyPut<ParentSignUpController>(() => ParentSignUpController(),
        fenix: true);
    // Get.lazyPut<DarkModecontroller>(() => DarkModecontroller(), fenix: true);
    Get.put(DarkModecontroller(), permanent: true);
    Get.lazyPut<AppSharedPreferences>(() => AppSharedPreferences(),
        fenix: true);
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
    Get.lazyPut<StudentLoginController>(() => StudentLoginController());
    Get.lazyPut<CountController>(() => CountController());
    Get.lazyPut<ChildrenDetailsController>(() => ChildrenDetailsController());
    Get.lazyPut<StudentProfileController>(() => StudentProfileController());
  }
}
