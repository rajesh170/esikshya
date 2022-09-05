import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class StudentSubscriptionInfoScreen extends StatelessWidget {
  const StudentSubscriptionInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "esikshya",
          leadingIcon: Icons.arrow_back,
          appBarBackgroundColor: AppColors.darkThemeBackground,
          txtColor: AppColors.white,
          iconColor: AppColors.white,
        ),
        backgroundColor: AppColors.darkThemeBackground,
        body: SizedBox(
          height: Get.height * 0.86,
          width: Get.width,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  "Start your subscription",
                  color: AppColors.darkBlue,
                  styles: TextStyles.size18_600,
                ),
                TextWidget(
                  "Rs 9997 / year",
                  color: AppColors.greyText,
                  styles: TextStyles.size14_400,
                ),
                TextWidget(
                  "Your subscription will renew on",
                  color: AppColors.greyText,
                  styles: TextStyles.size14_400,
                ),
                SizedBox(height: Get.height * 0.06),
                TextWidget(
                  "Unlimited Access",
                  color: AppColors.darkBlue,
                  styles: TextStyles.size18_600,
                ),
                TextWidget(
                  "Get all-access to over 100 videos",
                  color: AppColors.greyText,
                  styles: TextStyles.size14_400,
                ),
                SizedBox(height: Get.height * 0.06),
                TextWidget(
                  "We'll remind you",
                  color: AppColors.darkBlue,
                  styles: TextStyles.size18_600,
                ),
                TextWidget(
                  "We will email before your",
                  color: AppColors.greyText,
                  styles: TextStyles.size14_400,
                  maxLines: 2,
                ),
                TextWidget(
                  "subscription renews",
                  color: AppColors.greyText,
                  styles: TextStyles.size14_400,
                  maxLines: 2,
                ),
                SizedBox(height: Get.height * 0.06),
                ButtonWidget(
                  width: Get.width * 0.9,
                  color: AppColors.lightPink,
                  onPressed: () {},
                  buttonText: "CONFIRM SUBSCRIPTION",
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                  child: TextWidget(
                    "By tapping the 'CONFIRM SUBSCRIPTION' button, you agree to enroll in our subscription plan and to our Terms and Policy. All-Access Pass is an auto-recurring subscription. You can cancel your subscription listed under profile (no refunds or credits issued for partial subscription periods)",
                    color: AppColors.greyText,
                    styles: TextStyles.size14_400,
                    maxLines: 8,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
