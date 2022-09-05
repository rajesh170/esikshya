import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/parent/parent_set_password_controller.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/custom_widgets/k_form_field.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ParentSetPasswordScreen extends StatelessWidget {
  const ParentSetPasswordScreen({Key? key, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    ParentSetPasswordController _parentSetPasswordController =
        Get.put(ParentSetPasswordController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackground,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ButtonWidget(
        width: Get.width * 0.9,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await _parentSetPasswordController.parentSetPassword(
                context, phoneNumber);
          }
        },
        buttonText: "Next",
      ),
      body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  // Stack(
                  //   children: [
                  //     Image.asset(
                  //       "assets/images/onboarding1_1.png",
                  //       width: MediaQuery.of(context).size.width,
                  //     ),
                  //     Positioned(
                  //       left: 100.w,
                  //       top: 80.h,
                  //       child: Image.asset(
                  //         "assets/images/onboarding1_2.png",
                  //         height: Get.height * 0.2,
                  //         fit: BoxFit.fitHeight,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  TextWidget(
                    "Please set your pasword",
                    color: AppColors.greyText,
                    styles: TextStyles.size18_400,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(
                    () => CustomFormField(
                        // autoFocus: true,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _parentSetPasswordController.showEyeButton.value =
                                true;
                          }
                        },
                        obscureText:
                            _parentSetPasswordController.isObscure.value,
                        controller: _parentSetPasswordController.password,
                        hintText: "password",
                        suffixIcon: _parentSetPasswordController
                                    .showEyeButton.value ==
                                true
                            ? IconButton(
                                onPressed: () {
                                  _parentSetPasswordController.isObscure.value =
                                      !_parentSetPasswordController
                                          .isObscure.value;
                                },
                                icon: _parentSetPasswordController
                                            .isObscure.value ==
                                        true
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              )
                            : null,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "cannot be empty";
                          }
                          if (value.length < 6) {
                            return "password length must be greater  than 6";
                          }
                        }),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Obx(
                    () => CustomFormField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _parentSetPasswordController.showEyeButton.value =
                              true;
                        }
                      },
                      controller: _parentSetPasswordController.confirmPassword,
                      hintText: "confirm password",
                      suffixIcon: _parentSetPasswordController
                                  .showEyeButton.value ==
                              true
                          ? IconButton(
                              onPressed: () {
                                _parentSetPasswordController.isObscure.value =
                                    !_parentSetPasswordController
                                        .isObscure.value;
                              },
                              icon: _parentSetPasswordController
                                          .isObscure.value ==
                                      true
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            )
                          : null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "cannot be empty";
                        }
                        if (value !=
                            _parentSetPasswordController.password.text) {
                          return "Password did not  matched";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),

                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  // Obx(
                  //   () => Container(
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: AppColors.darkBlue,
                  //         width: 0.5.w,
                  //       ),
                  //       borderRadius: BorderRadius.circular(10.r),
                  //     ),
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(10.r),rt
                  //       child: ExpansionTile(
                  //         iconColor: AppColors.white,
                  //         key: GlobalKey(),
                  //         collapsedIconColor: AppColors.white,
                  //         collapsedBackgroundColor:
                  //             AppColors.darkThemeCardColor,
                  //         backgroundColor: AppColors.darkThemeCardColor,
                  //         title: TextWidget(
                  //           _parentTellUsMoreController.noOfChildren.value
                  //               .toString(),
                  //           color: AppColors.white,
                  //         ),
                  //         children: [
                  //           ListView.builder(
                  //               shrinkWrap: true,
                  //               itemCount: 10,
                  //               physics: const NeverScrollableScrollPhysics(),
                  //               itemBuilder: (context, index) {
                  //                 return InkWell(
                  //                   onTap: () {
                  //                     _parentTellUsMoreController
                  //                         .noOfChildren.value = index;
                  //                   },
                  //                   child: Padding(
                  //                     padding: EdgeInsets.symmetric(
                  //                         vertical: 10.h, horizontal: 15.w),
                  //                     child: TextWidget(
                  //                       index.toString(),
                  //                       color: AppColors.white,
                  //                     ),
                  //                   ),
                  //                 );
                  //               }),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
