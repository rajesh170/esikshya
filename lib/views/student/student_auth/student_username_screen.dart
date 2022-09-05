import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/student/student_sign_up_controller.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/custom_widgets/k_form_field.dart';
import 'package:esikshya/custom_widgets/k_form_field_2.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/utils/text_widget.dart';

class StudentAskUsernameScreen extends StatelessWidget {
  const StudentAskUsernameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentSignUpController _studentSignUpController =
        Get.put(StudentSignUpController());

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkThemeBackground,
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  TextWidget(
                    "esikshya Registration\nfor Student",
                    styles: TextStyles.size20_400,
                    color: AppColors.white,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextWidget(
                    "Username",
                    styles: TextStyles.size14_400,
                    color: AppColors.greyText,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Obx(
                    () => _studentSignUpController.checkValidation.value ||
                            !_studentSignUpController.checkValidation.value
                        ? CustomFormField2(
                            // onTap: () {
                            //   _studentSignUpController.isFormTapped.value =
                            //       true;
                            // },

                            controller:
                                _studentSignUpController.usernameController,
                            prefixIcon: Icons.person,
                            hintText: "",
                            keyboardType: TextInputType.text,
                            errorBorderStyle: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: _studentSignUpController
                                        .isUserNameEmpty.value
                                    ? Colors.red
                                    : AppColors.lightGreen,
                                width: 0.7.w,
                              ),
                            ),
                            borderStyle: _studentSignUpController
                                    .isUserNameEmpty.value
                                ? null
                                : OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide(
                                      color: _studentSignUpController
                                              .checkValidation.value
                                          ? Colors.greenAccent
                                          : AppColors.red,
                                      width: 0.7.w,
                                    ),
                                  ),
                            onChanged: (value) async {
                              if (value.isNotEmpty) {
                                _studentSignUpController.isUserNameEmpty.value =
                                    false;
                                await _studentSignUpController.checkUserName();
                              } else {
                                _studentSignUpController.isUserNameEmpty.value =
                                    true;
                              }
                            },
                            suffixIcon: _studentSignUpController
                                    .isUserNameEmpty.value
                                ? null
                                : Padding(
                                    padding:
                                        EdgeInsets.only(right: 5.w, top: 15.h),
                                    child: TextWidget(
                                      _studentSignUpController
                                              .checkValidation.value
                                          ? "Available"
                                          : "Not Available",
                                      styles: TextStyles.size10_400,
                                      color: AppColors.greyText,
                                    ),
                                  ),

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Cannot be empty";
                              }
                              if (value.contains(" ")) {
                                return "Please avoid space";
                              }
                            },
                          )
                        : const SizedBox(),
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
                      controller: _studentSignUpController.passwordController,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: InkWell(
                        onTap: () {
                          _studentSignUpController.showPassword.value =
                              !_studentSignUpController.showPassword.value;
                        },
                        child: Icon(
                          Icons.visibility,
                          color: AppColors.white,
                          size: 20.sp,
                        ),
                      ),
                      hintText: "",
                      obscureText: !_studentSignUpController.showPassword.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Cannot be empty";
                        }
                        if (value.length < 6) {
                          return "password must be greater than 6";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  ButtonWidget(
                    width: Get.width,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_studentSignUpController.checkValidation.value) {
                          try {
                            var _checkingUsername =
                                await _studentSignUpController.checkUserName();
                            if (_checkingUsername) {
                              await _studentSignUpController
                                  .studentSignUp(context);
                            }
                          } catch (e) {
                            AppWidgets.showSnackBar(
                                context, "Username is already taken");
                          }
                        } else {
                          AppWidgets.showSnackBar(
                              context, "Username is already taken");
                        }
                      }
                    },
                    buttonText: "Register",
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
