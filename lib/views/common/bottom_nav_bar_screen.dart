import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/bottom_nav_bar_controller.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/notifications_screen/notification_screen.dart';
import 'package:esikshya/views/parent/parent_dashboard/parent_dashboard.dart';
import 'package:esikshya/views/student/home/student_home_screen.dart';
import 'package:esikshya/views/student/student_profile/student_profile.dart';
import 'package:badges/badges.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({Key? key, required this.isUserChild, this.index})
      : super(key: key);
  final bool isUserChild;
  final int? index;

  @override
  Widget build(BuildContext context) {
    BottomNavController _bottomController = Get.put(BottomNavController());
    if (index != null) {
      _bottomController.currentIndex.value = index!;
    }
    final screens = isUserChild
        ? [
            const StudentHomeScreen(),
            NotificationScreen(
              isUserChild: isUserChild,
            ),
            const StudentProfile(),
          ]
        : [
            const ParentDashBoard(),
            NotificationScreen(
              isUserChild: isUserChild,
            ),
            const SizedBox(),
          ];

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: _bottomController.currentIndex.value,
          children: screens,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              _bottomController.onseleceted(index);
            },
            currentIndex: _bottomController.currentIndex.value,
            selectedItemColor: AppColors.darkBlue,
            unselectedItemColor: AppColors.greyText,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Badge(
                    badgeContent: TextWidget(
                      '3',
                      styles: TextStyles.size10_400,
                      color: AppColors.white,
                    ),
                    child: const Icon(Icons.notifications),
                  ),
                  label: "Notifications"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.notifications), label: "Notifications"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ]),
      ),
    );
  }
}
