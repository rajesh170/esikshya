import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({Key? key, required this.onButtonPressed})
      : super(key: key);
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackground,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.darkThemeBackground,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.1),
            Stack(
              children: [
                Image.asset(
                  "assets/images/onboarding2_1.png",
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                  left: 70.w,
                  top: 40.h,
                  child: Image.asset(
                    "assets/images/onboarding2_2.png",
                    height: Get.height * 0.23,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 88.h,
            ),
            TextWidget(
              "Progress & Performance",
              styles: TextStyles.size24_600,
              color: AppColors.blue,
              maxLines: 5,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Center(
              child: TextWidget(
                "See how your students are Progressing",
                styles: TextStyles.size14_400,
                color: AppColors.greyText,
                maxLines: 2,
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xff224070),
                  radius: 4.r,
                ),
                SizedBox(
                  width: 3.w,
                ),
                CircleAvatar(
                  backgroundColor: const Color(0xff328CE5),
                  radius: 4.r,
                ),
                SizedBox(
                  width: 3.w,
                ),
                CircleAvatar(
                  backgroundColor: const Color(0xff224070),
                  radius: 4.r,
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: onButtonPressed,
              child: CircleAvatar(
                backgroundColor: const Color(0xff224070),
                radius: 24.r,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
