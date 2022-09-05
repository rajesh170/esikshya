import 'package:esikshya/views/on_boarding/esikshya.dart';
import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/views/common/bottom_nav_bar_screen.dart';
import 'package:esikshya/views/common/welcome_screen.dart';
import 'package:esikshya/views/parent/parent_dashboard/parent_dashboard.dart';
import 'package:esikshya/views/student/home/student_home_screen.dart';

class SplashController extends GetxController {
  final _sharedPref = Get.find<AppSharedPreferences>();
  userWelcomed() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    var _isUserWelcomed = await _sharedPref.getUserWelcomed();
    if (_isUserWelcomed == true) {
      var pName = await _sharedPref.getParentName();
      if (pName != "") {
        // Get.off(
        //   () => ParentDashBoard(
        //     name: pName,
        //   ),
        // );
        Get.off(
          () => const BottomNavBarScreen(
            isUserChild: false,
          ),
        );
      } else {
        var _childName = await _sharedPref.getChildUserName();
        if (_childName != "") {
          // Get.off(
          //   () => const StudentHomeScreen(),
          // );
          Get.off(
            () => const BottomNavBarScreen(
              isUserChild: true,
            ),
          );
        } else {
          Get.off(() => const EsikshyaBoarding());
        }
      }
    } else {
      Get.to(() => const WelComeScreen());
    }
  }
}
