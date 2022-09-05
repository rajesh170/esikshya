import 'package:get/get.dart';
import 'package:esikshya/views/common/bottom_nav_bar_screen.dart';
import 'package:esikshya/views/on_boarding/esikshya.dart';
import 'package:esikshya/views/parent/parent_dashboard/parent_dashboard.dart';
import 'package:esikshya/views/student/home/student_home_screen.dart';
import 'package:esikshya/views/student/student_tell_us_more/student_tell_us_more.dart';

import '../views/on_boarding/sanduk_choose_user_screen.dart';

class AppRoutes {
  static goToParentDashboard(String name) {
    Get.offAll(
      () => ParentDashBoard(
        name: name,
      ),
    );
  }

  static goToChooseUserScreen() {
    Get.offAll(
      () => const EsikshyaChooseUserScreen(),
    );
  }

  static goToesikshyaBoarding() {
    Get.offAll(
      () => const EsikshyaBoarding(),
    );
  }

  static goToStudentHomeScreen() {
    Get.offAll(
      () => const StudentHomeScreen(),
    );
  }

  static goToBottomNavBar(bool isUserChild) {
    Get.offAll(() => BottomNavBarScreen(
          isUserChild: isUserChild,
        ));
  }

  //   static goToStudentTellUsMore() {
  // Get.to(
  //   () =>  const StudentTellUsMore(),
  // );
  // }

}
