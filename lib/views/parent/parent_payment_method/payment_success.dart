import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/common/bottom_nav_bar_screen.dart';
import 'package:esikshya/views/parent/parent_dashboard/parent_dashboard.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkModeOn
            ? AppColors.darkThemeBackground
            : AppColors.scaffoldColor,
        appBar: CustomAppBar(
          title: "Payment Successful",
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
                      ? "assets/images/happy_pink.png"
                      : "assets/images/happy.png",
                  height: 170.h,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextWidget(
                "Congratulations!",
                styles: TextStyles.size28_700,
                color: isDarkModeOn ? AppColors.white : AppColors.black,
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: TextWidget(
                  "You successfully maked a payment, enjoy our service!",
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
                  // Get.offAll(() => const ParentDashBoard());
                  Get.offAll(() => const BottomNavBarScreen(
                        isUserChild: false,
                      ));
                },
                buttonText: "Go to home",
                color: isDarkModeOn ? AppColors.darkBlue : AppColors.lightPink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
