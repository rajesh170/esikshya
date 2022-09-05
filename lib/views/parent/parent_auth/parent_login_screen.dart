import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/parent/parent_login_controller.dart';
import 'package:esikshya/controllers/parent/parent_set_password_controller.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/custom_widgets/k_form_field.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ParentLoginScreen extends StatelessWidget {
  const ParentLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ParentLoginController _parentLoginController =
        Get.put(ParentLoginController());
    ParentSetPasswordController _parentSetPasswordController =
        Get.put(ParentSetPasswordController());
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackground,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: ButtonWidget(
      //   width: Get.width,
      //   onPressed: () async {
      //     await _parentLoginController.parentLogin(context);
      //   },
      //   buttonText: "Login",
      // ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                TextWidget(
                  "Welcome to",
                  styles: TextStyles.size28_800,
                  color: AppColors.white,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextWidget(
                  "  esikshya",
                  styles: TextStyles.size44_900,
                  color: AppColors.white,
                ),
                SizedBox(
                  height: 50.h,
                ),
                // Image.asset(
                //   "assets/images/login_screen.png",
                //   height: Get.height * 0.4,
                //   width: Get.width,
                // ),
                TextWidget(
                  "Phone number",
                  color: AppColors.white,
                  styles: TextStyles.size18_400,
                  maxLines: 5,
                ),
                SizedBox(height: Get.height * 0.01),
                CustomFormField(
                  controller: _parentLoginController.phoneController,
                  prefixIcon: Icons.phone,
                  hintText: "",
                  validator: (value) {
                    if (value!.length < 10) {
                      return "Invalid phone number";
                    }
                    if (value.length > 10) {
                      return "Invalid phone number";
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: Get.height * 0.03),
                TextWidget(
                  "Password",
                  color: AppColors.white,
                  styles: TextStyles.size18_400,
                  maxLines: 5,
                ),
                SizedBox(height: Get.height * 0.01),
                Obx(
                  () => CustomFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _parentSetPasswordController.showEyeButton.value = true;
                      }
                    },
                    obscureText: _parentSetPasswordController.isObscure.value,
                    controller: _parentLoginController.passwordController,
                    prefixIcon: Icons.lock,
                    suffixIcon: _parentSetPasswordController
                                .showEyeButton.value ==
                            true
                        ? IconButton(
                            onPressed: () {
                              _parentSetPasswordController.isObscure.value =
                                  !_parentSetPasswordController.isObscure.value;
                            },
                            icon:
                                _parentSetPasswordController.isObscure.value ==
                                        true
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                          )
                        : null,
                    hintText: "",
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
                ButtonWidget(
                  width: Get.width,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _parentLoginController.parentLogin(context);
                    }
                  },
                  buttonText: "Login",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
