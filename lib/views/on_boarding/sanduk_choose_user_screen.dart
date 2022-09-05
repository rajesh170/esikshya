import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/parent/parent_auth/parent_login_screen.dart';
import 'package:esikshya/views/parent/parent_auth/parent_sign_up_screen.dart';
import 'package:esikshya/views/student/student_auth/student_login_screen.dart';
import 'package:esikshya/views/student/student_auth/student_sign_up_screen.dart';

class EsikshyaChooseUserScreen extends StatelessWidget {
  const EsikshyaChooseUserScreen({Key? key, this.isRegister}) : super(key: key);
  final bool? isRegister;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackground,
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: TextWidget(
                "Esikshya",
                color: Colors.white,
                styles: TextStyles.size32_700,
              ),
            ),
            SizedBox(
              height: Get.height * 0.2,
            ),
            InkWell(
              onTap: () {
                isRegister == true
                    ? Get.to(() => const StudentSignUpScreen())
                    : Get.to(() => const StudentLoginScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/student_auth.png",
                    height: Get.height * 0.25,
                    width: Get.width * 0.3,
                    fit: BoxFit.contain,
                  ),
                  TextWidget(
                    "Students",
                    styles: TextStyles.size18_600,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            InkWell(
              onTap: () {
                isRegister == true
                    ? Get.to(() => const ParentSignUpWithNumberScreen())
                    : Get.to(() => const ParentLoginScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextWidget(
                    "Parents",
                    styles: TextStyles.size18_600,
                    color: AppColors.white,
                  ),
                  Image.asset(
                    "assets/images/parent_auth.png",
                    height: Get.height * 0.25,
                    width: Get.width * 0.3,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
