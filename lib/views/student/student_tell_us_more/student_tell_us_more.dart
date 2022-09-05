import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/student/student_sign_up_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_constants_list.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/utils/on_tap_bottom_sheet.dart';
import 'package:esikshya/utils/text_widget.dart';

class StudentTellUsMore extends StatelessWidget {
  const StudentTellUsMore({
    Key? key,
    required this.username,
    required this.password,
  }) : super(key: key);
  final String username;
  final String password;

  @override
  Widget build(BuildContext context) {
    StudentSignUpController _studentSignUpController =
        Get.put(StudentSignUpController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkThemeBackground,
        appBar: const CustomAppBar(
          appBarBackgroundColor: AppColors.darkThemeBackground,
          title: "Add your details",
          txtColor: AppColors.white,
          leadingIcon: Icons.arrow_back,
          iconColor: AppColors.white,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: Get.height * 0.85,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // TextWidget("For Each child Account Creation, you will be charged Rs.50"),
                  EditProfileItems(
                    controller: _studentSignUpController.studentNameController,
                    title: "Student's Full Name",
                    imagePath: "assets/images/profile.png",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Cannot  be Empty";
                      }
                      if (value.length < 5) {
                        return "Invalid full name";
                      }
                    },
                  ),
                  // EditProfileItems(
                  //   controller: _studentSignUpController.emailController,
                  //   title: "Email address",
                  //   imagePath: "assets/images/email.png",
                  //   keyboardType: TextInputType.emailAddress,
                  //   validator: (value) {
                  //     var _emailVerify = RegExp(
                  //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //         .hasMatch(value!);
                  //     if (!_emailVerify) {
                  //       return "Invalid email";
                  //     }
                  //   },
                  // ),
                  Obx(
                    () => EditProfileItemsWithBottomSheet(
                      title: "Date Of Birth",
                      imagePath: "assets/images/dob.png",
                      value: _studentSignUpController.dateOfBirth.value,
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (time) {},
                          minTime: DateTime(1990),
                          maxTime: DateTime.now(),
                          onConfirm: (dateTime) {
                            _studentSignUpController.dateOfBirth.value =
                                dateTime.toString().substring(0, 10);
                          },
                          theme: const DatePickerTheme(
                              backgroundColor: AppColors.darkThemeBackground,
                              containerHeight: 250,
                              cancelStyle: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                              doneStyle: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                              itemStyle: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                              )),
                          currentTime: DateTime.now(),
                          locale: LocaleType.en,
                        );
                      },
                    ),
                  ),
                  Obx(
                    () => EditProfileItemsWithBottomSheet(
                      title: "Gender",
                      imagePath: "assets/images/toggler_icon.png",
                      onTap: () {
                        OnTapBottomSheet.openBottomSheet(
                          AppConstantsList.gender,
                          _studentSignUpController.gender,
                          _studentSignUpController.gender.value,
                          "Select Gender",
                          isDarkModeOn: true,
                        );
                      },
                      value: _studentSignUpController.gender.value.toString(),
                    ),
                  ),
                  Obx(
                    () => EditProfileItemsWithBottomSheet(
                      title: "Class",
                      imagePath: "assets/images/toggler_icon.png",
                      onTap: () {
                        OnTapBottomSheet.openBottomSheet(
                          AppConstantsList.grade,
                          _studentSignUpController.grade,
                          _studentSignUpController.grade.value.toString(),
                          "Select Class",
                          isDarkModeOn: true,
                        );
                      },
                      value: _studentSignUpController.grade.value.toString(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus();
                    },
                    child: EditProfileItems(
                      controller: _studentSignUpController.schoolNameController,
                      title: "School Name",
                      height: 40.h,
                      maxLines: 2,
                      imagePath: "assets/images/home.png",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Cannot  be Empty";
                        }
                      },
                    ),
                  ),
                  Obx(
                    () => EditProfileItemsWithBottomSheet(
                      title: "State",
                      imagePath: "assets/images/location.png",
                      onTap: () {
                        OnTapBottomSheet.openBottomSheet(
                          AppConstantsList.state,
                          _studentSignUpController.state,
                          _studentSignUpController.state.value,
                          "Select State",
                          isDarkModeOn: true,
                        );
                      },
                      value: _studentSignUpController.state.value,
                    ),
                  ),

                  Obx(
                    () => EditProfileItemsWithBottomSheet(
                      title: "Country",
                      imagePath: "assets/images/globe.png",
                      onTap: () {
                        OnTapBottomSheet.openBottomSheet(
                          AppConstantsList.country,
                          _studentSignUpController.country,
                          _studentSignUpController.country.value,
                          "Select Country",
                          isDarkModeOn: true,
                        );
                      },
                      value: _studentSignUpController.country.value,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  // RichText(
                  //     text: TextSpan(children: [
                  //   TextSpan(
                  //     text:
                  //         "For Each child Account Creation, you will be charged ",
                  //     style: TextStyle(
                  //       color: AppColors.greyText,
                  //       fontSize: 12.sp,
                  //       fontStyle: FontStyle.italic,
                  //       fontWeight: FontWeight.w300,
                  //       letterSpacing: 1.w,
                  //     ),
                  //   ),
                  //   TextSpan(
                  //     text: "Rs. 50",
                  //     style: TextStyle(
                  //       color: AppColors.red,
                  //       fontSize: 15.sp,
                  //       fontWeight: FontWeight.w400,
                  //       fontStyle: FontStyle.italic,
                  //     ),
                  //   ),
                  // ])),
                  const Spacer(),

                  ButtonWidget(
                      width: Get.width,
                      onPressed: () async {
                        // _studentSignUpController.checkValidation.value;
                        if (_formKey.currentState!.validate()) {
                          if (_studentSignUpController.dateOfBirth.value ==
                              "") {
                            AppWidgets.showSnackBar(
                                context, "Please provide date of birth");
                          } else if (_studentSignUpController.gender.value ==
                              "") {
                            AppWidgets.showSnackBar(
                                context, "Please provide gender");
                          } else if (_studentSignUpController.grade.value ==
                              "") {
                            AppWidgets.showSnackBar(
                                context, "Please provide grade");
                          } else if (_studentSignUpController.state.value ==
                              "") {
                            AppWidgets.showSnackBar(
                                context, "Please provide state");
                          } else if (_studentSignUpController.country.value ==
                              "") {
                            AppWidgets.showSnackBar(
                                context, "Please provide country");
                          } else {
                            await _studentSignUpController.studentTellUsMore(
                                context, username, password);
                          }
                        }
                      },
                      buttonText: "Start Learning"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditProfileItems extends StatelessWidget {
  const EditProfileItems({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.controller,
    this.keyboardType,
    required this.validator,
    this.maxLines,
    this.height,
  }) : super(key: key);
  final String title;
  final String imagePath;
  final int? maxLines;
  final double? height;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 20.h,
            width: 20.h,
            color: AppColors.blue,
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.white,
                  width: 1.w,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  title,
                  color: AppColors.white,
                  styles: TextStyles.size12_400,
                ),
                SizedBox(
                  height: height ?? 35.h,
                  width: Get.width * 0.8,
                  child: TextFormField(
                    controller: controller,
                    validator: validator,
                    maxLines: maxLines ?? 1,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyText,
                    ),
                    keyboardType: keyboardType ?? TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10.h),
                      fillColor: AppColors.transparent,
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EditProfileItemsWithBottomSheet extends StatelessWidget {
  const EditProfileItemsWithBottomSheet({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    required this.value,
  }) : super(key: key);
  final String title;
  final String imagePath;
  final String value;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 20.h,
              width: 20.h,
              color: AppColors.blue,
            ),
            SizedBox(
              width: 20.w,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.white,
                    width: 1.w,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title,
                    color: AppColors.white,
                    styles: TextStyles.size12_400,
                  ),
                  Container(
                    height: 30.h,
                    width: Get.width * 0.8,
                    padding: EdgeInsets.only(top: 5.h),
                    child: TextWidget(
                      value,
                      color: AppColors.greyText,
                      styles: TextStyles.size12_400,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
