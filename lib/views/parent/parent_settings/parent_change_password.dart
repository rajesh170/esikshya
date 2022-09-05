import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/custom_widgets/k_form_field.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/parent/parent_settings/parent_settings.dart';

class ParentChangePassword extends StatelessWidget {
  const ParentChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _currentPassword = TextEditingController();
    TextEditingController _newPassword = TextEditingController();
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkModeOn
            ? AppColors.darkThemeBackground
            : AppColors.scaffoldColor,
        appBar: CustomAppBar(
          title: "Change Password",
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
        body: SingleChildScrollView(
          child: Obx(
            () => Container(
              height: Get.height,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
              color: Get.find<DarkModecontroller>().isDarkModeOn.value
                  ? AppColors.darkThemeBackground
                  : AppColors.scaffoldColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Image.asset(
                    "assets/images/auth2.png",
                    height: Get.height * 0.3,
                  ),
                  TextWidget(
                    "Password",
                    styles: TextStyles.size14_400,
                    color: isDarkModeOn ? AppColors.greyText : AppColors.black,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomFormField(
                    controller: _currentPassword,
                    prefixIcon: Icons.lock_outline,
                    hintText: "Enter password 8 - 12 characters",
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  TextWidget(
                    "CONFIRM PASSWORD",
                    styles: TextStyles.size14_400,
                    color: isDarkModeOn ? AppColors.greyText : AppColors.black,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomFormField(
                    controller: _newPassword,
                    prefixIcon: Icons.lock_outline,
                    hintText: "Re-enter your password",
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  ButtonWidget(
                    width: Get.width,
                    onPressed: () {
                      Get.off(() => const ParentSettings());
                    },
                    buttonText: "Continue",
                    color:
                        isDarkModeOn ? AppColors.darkBlue : AppColors.lightPink,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
