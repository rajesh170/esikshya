import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/common/bottom_nav_bar_screen.dart';
import 'package:esikshya/views/parent/parent_dashboard/parent_dashboard.dart';

class ParentFeedbackSentSuccess extends StatelessWidget {
  const ParentFeedbackSentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkModeOn
            ? AppColors.darkThemeBackground
            : AppColors.scaffoldColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/girl_writing_icon.png",
                height: 170.h,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextWidget(
              "Thanks for your valuable feedback.",
              styles: TextStyles.size14_500,
              color: isDarkModeOn ? AppColors.white : AppColors.black,
            ),
            SizedBox(
              height: 20.h,
            ),
            ButtonWidget(
              onPressed: () {
                // Get.off(() => const ParentDashBoard());
                Get.offAll(() => const BottomNavBarScreen(
                      isUserChild: false,
                    ));
              },
              buttonText: "Go to home",
              color: AppColors.darkBlue,
            ),
          ],
        ),
      ),
    );
  }
}
