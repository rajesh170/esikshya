import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/on_boarding/esikshya.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({
    Key? key,
  }) : super(key: key);

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
                  "assets/images/onboarding3_1.png",
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                  left: 55.w,
                  top: 25.h,
                  child: Image.asset(
                    "assets/images/onboarding3_2.png",
                    height: Get.height * 0.3,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 88.h,
            ),
            TextWidget(
              "Play Quiz",
              styles: TextStyles.size24_600,
              color: AppColors.blue,
              maxLines: 5,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Center(
              child: TextWidget(
                "Play quiz with random friends",
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
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Get.offAll(() => const EsikshyaBoarding());
              },
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
