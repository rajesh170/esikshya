import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

import 'payment_method_screen.dart';

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkModeOn
            ? AppColors.darkThemeBackground
            : AppColors.scaffoldColor,
        appBar: CustomAppBar(
          title: "Payment Failed",
          leadingIcon: Icons.arrow_back,
          appBarBackgroundColor: isDarkModeOn
              ? AppColors.darkThemeBackground
              : AppColors.scaffoldColor,
          centerTitle: true,
          txtColor: isDarkModeOn ? AppColors.white : AppColors.black,
          // trailingIcon: Icons.settings,
          iconColor: isDarkModeOn ? AppColors.white : AppColors.blackGrey,
          iconSize: 20.sp,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  isDarkModeOn
                      ? "assets/images/unhappy_pink.png"
                      : "assets/images/unhappy.png",
                  height: 170.h,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextWidget(
                "Unfortunately!",
                styles: TextStyles.size28_700,
                color: isDarkModeOn ? AppColors.white : AppColors.black,
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: TextWidget(
                  "Your Payment failed, Please try Again.",
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  styles: TextStyles.size15_400,
                  color:
                      isDarkModeOn ? AppColors.greyText : AppColors.blueishGrey,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              ButtonWidget(
                onPressed: () {
                  Get.off(() => PaymentMethodScreen());
                },
                buttonText: "Try Again",
                color: isDarkModeOn ? AppColors.darkBlue : AppColors.lightPink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
