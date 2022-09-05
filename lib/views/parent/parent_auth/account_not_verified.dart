import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class AccountNotVerified extends StatelessWidget {
  const AccountNotVerified({Key? key}) : super(key: key);

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
                "assets/images/otp_not_verified.png",
                width: Get.width * 0.4,
                fit: BoxFit.fitHeight,
              ),
            ),
            TextWidget(
              "Wrong OTP",
              styles: TextStyles.size32_400,
              color: AppColors.greyText,
              maxLines: 5,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15.h,
            ),
            TextWidget(
              "Check your message.",
              styles: TextStyles.size16_400,
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
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    radius: 24.r,
                    backgroundColor: AppColors.blue,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
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
