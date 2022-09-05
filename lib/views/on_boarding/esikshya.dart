import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

import 'sanduk_choose_user_screen.dart';

class EsikshyaBoarding extends StatelessWidget {
  const EsikshyaBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackground,
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextWidget(
                "Esikshya",
                color: Colors.white,
                styles: TextStyles.size32_700,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Center(
              child: Image.asset(
                "assets/images/login_screen.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                height: Get.height * 0.5,
              ),
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  onPressed: () {
                    Get.to(() => const EsikshyaChooseUserScreen(
                          isRegister: true,
                        ));
                  },
                  buttonText: "Register",
                  needBorder: true,
                  width: Get.width * 0.4,
                  color: AppColors.darkBlue,
                ),
                ButtonWidget(
                  onPressed: () {
                    Get.to(() => const EsikshyaChooseUserScreen());
                  },
                  buttonText: "Login",
                  width: Get.width * 0.4,
                  color: AppColors.darkBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
