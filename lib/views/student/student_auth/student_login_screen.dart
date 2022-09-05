import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/student/student_login_controller.dart';
import 'package:esikshya/custom_widgets/k_form_field.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class StudentLoginScreen extends StatelessWidget {
  const StudentLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentLoginController _studentLoginController =
        Get.put(StudentLoginController());
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.darkThemeBackground,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Form(
            key: _studentLoginController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // height: screenHeight * 0.06,
                  height: 20.h,
                ),
                TextWidget(
                  "Welcome to",
                  styles: TextStyles.size28_800,
                  color: AppColors.white,
                ),
                SizedBox(
                  // height: screenHeight * 0.01,
                  height: 20.h,
                ),
                TextWidget(
                  "  esikshya",
                  styles: TextStyles.size44_900,
                  color: AppColors.white,
                ),
                SizedBox(
                  // height: screenHeight * 0.1,
                  height: 50.h,
                ),
                // Center(
                //   child: Image.asset(
                //     "assets/images/auth.png",
                //     height: screenHeight * 0.2,
                //     width: Get.width * 0.7,
                //     fit: BoxFit.fill,
                //   ),
                // ),
                TextWidget(
                  "Username",
                  styles: TextStyles.size14_400,
                  color: AppColors.greyText,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomFormField(
                  controller: _studentLoginController.usernameController,
                  prefixIcon: Icons.email_outlined,
                  hintText: "",
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide a valid username";
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextWidget(
                  "Password",
                  styles: TextStyles.size14_400,
                  color: AppColors.greyText,
                ),
                SizedBox(
                  height: 5.h,
                ),

                Obx(
                  () => CustomFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _studentLoginController.showEyeButton.value = true;
                      }
                    },
                    obscureText: _studentLoginController.isObscure.value,
                    validator: (value) {
                      if (value!.length < 8) {
                        return "Please provide a valid password";
                      }
                    },
                    controller: _studentLoginController.passwordController,
                    prefixIcon: Icons.lock_outline,
                    hintText: "",
                    suffixIcon: _studentLoginController.showEyeButton.value ==
                            true
                        ? IconButton(
                            onPressed: () {
                              _studentLoginController.isObscure.value =
                                  !_studentLoginController.isObscure.value;
                            },
                            icon:
                                _studentLoginController.isObscure.value == true
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                          )
                        : null,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      // Get.to(() => const StudentHomeScreen());
                      if (_studentLoginController.formKey.currentState!
                          .validate()) {
                        await _studentLoginController.studentLogin(context);
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.darkBlue,
                      radius: 24.r,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextWidget(
                    "Forgot Password?",
                    styles: TextStyles.size14_600,
                    color: AppColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
