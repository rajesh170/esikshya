import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/parent/parent_set_password/parent_set_password_screen.dart';

class AccountVerified extends StatelessWidget {
  const AccountVerified({Key? key, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkThemeBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/otp_verified.png",
                width: Get.width * 0.4,
                fit: BoxFit.fitHeight,
              ),
            ),
            TextWidget(
              "Your Account\nhas been Verified",
              styles: TextStyles.size32_400,
              color: AppColors.greyText,
              maxLines: 5,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Get.to(() => ParentSetPasswordScreen(
                          phoneNumber: phoneNumber,
                        ));
                  },
                  child: CircleAvatar(
                    radius: 24.r,
                    backgroundColor: AppColors.blue,
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
