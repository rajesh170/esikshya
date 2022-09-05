import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/edit_profile_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/models/network_models/request/student/student_details_request.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_constants_list.dart';
import 'package:esikshya/utils/on_tap_bottom_sheet.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/student_tell_us_more/student_tell_us_more.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    Key? key,
    required this.fullname,
    required this.childGrade,
    required this.childState,
    required this.childSchool,
    required this.childGender,
    required this.childCountry,
  }) : super(key: key);
  final String fullname;
  final int childGrade;
  final String childState;
  final String childSchool;
  final String childGender;
  final String? childCountry;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    StudentEditProfileController _editProfileController =
        Get.put(StudentEditProfileController());
    final TextEditingController fullNameController =
        TextEditingController(text: fullname);

    final TextEditingController school =
        TextEditingController(text: childSchool);
    final TextEditingController state = TextEditingController(text: childState);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkThemeBackground,
        appBar: CustomAppBar(
          appBarBackgroundColor: AppColors.darkThemeBackground,
          title: "Edit Profile",
          txtColor: AppColors.white,
          leadingIcon: Icons.arrow_back_ios,
          iconColor: AppColors.white,
          // trailingIcon: Icons.cancel,
          onTapBack: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: FutureBuilder(
                future: _editProfileController.getChildDetails(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: Get.height * 0.85,
                      width: Get.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                      child: Column(
                        children: [
                          // EditAccountInfoContainer(
                          //   subtitle:
                          //       snapshot.data[0]['full_name'].toString(),
                          //   // readOnly: _editProfileController.readOnly.value,
                          //   title: "Full name",
                          //   textEditingController: fullNameController,
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return "Cannot be Empty";
                          //     }
                          //   },
                          // ),
                          EditProfileItems(
                            controller: fullNameController,
                            title: "Student's Full Name",
                            imagePath: "assets/images/profile.png",
                            maxLines: 1,
                            validator: (value) {},
                          ),
                          Obx(
                            () => EditProfileItemsWithBottomSheet(
                              title: "Class",
                              imagePath: "assets/images/toggler_icon.png",
                              onTap: () {
                                OnTapBottomSheet.openBottomSheet(
                                  AppConstantsList.grade,
                                  _editProfileController.grade,
                                  _editProfileController.grade.value.toString(),
                                  "Select Class",
                                  isDarkModeOn: true,
                                );
                              },
                              value: _editProfileController.grade.value
                                          .toString() ==
                                      ""
                                  ? childGrade.toString()
                                  : _editProfileController.grade.value
                                      .toString(),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).requestFocus();
                            },
                            child: EditProfileItems(
                              controller: school,
                              title: "School Name",
                              height: 40.h,
                              maxLines: 1,
                              imagePath: "assets/images/home.png",
                              validator: (value) {},
                            ),
                          ),
                          Obx(
                            () => EditProfileItemsWithBottomSheet(
                              title: "State",
                              imagePath: "assets/images/location.png",
                              onTap: () {
                                OnTapBottomSheet.openBottomSheet(
                                  AppConstantsList.state,
                                  _editProfileController.state,
                                  _editProfileController.state.value,
                                  "Select State",
                                  isDarkModeOn: true,
                                );
                              },
                              value: _editProfileController.state.value == ""
                                  ? childState
                                  : _editProfileController.state.value,
                            ),
                          ),
                          Obx(
                            () => EditProfileItemsWithBottomSheet(
                              title: "Country",
                              imagePath: "assets/images/globe.png",
                              onTap: () {
                                OnTapBottomSheet.openBottomSheet(
                                  AppConstantsList.country,
                                  _editProfileController.country,
                                  _editProfileController.country.value,
                                  "Select Country",
                                  isDarkModeOn: true,
                                );
                              },
                              value: _editProfileController.country.value == ""
                                  ? childCountry.toString()
                                  : _editProfileController.country.value,
                            ),
                          ),
                          Obx(
                            () => EditProfileItemsWithBottomSheet(
                              title: "Gender",
                              imagePath: "assets/images/toggler_icon.png",
                              onTap: () {
                                OnTapBottomSheet.openBottomSheet(
                                  AppConstantsList.gender,
                                  _editProfileController.gender,
                                  _editProfileController.gender.value,
                                  "Gender",
                                );
                              },
                              value: _editProfileController.gender.value == ""
                                  ? childGender
                                  : _editProfileController.gender.value,
                            ),
                          ),

                          SizedBox(
                            height: 40.h,
                          ),
                          Center(
                            child: ButtonWidget(
                                width: Get.width,
                                onPressed: () async {
                                  // CustomDialogesikshya.openesikshyaDialog(context);

                                  if (_formKey.currentState!.validate()) {
                                    ChildDetail childDetailRequest =
                                        ChildDetail(
                                      fullName: fullNameController.text.isEmpty
                                          ? fullname
                                          : fullNameController.text,
                                      country: _editProfileController
                                                  .country.value ==
                                              ""
                                          ? childCountry
                                          : _editProfileController
                                              .country.value,
                                      grade:
                                          _editProfileController.grade.value ==
                                                  ""
                                              ? childGrade
                                              : int.parse(_editProfileController
                                                  .grade.value),
                                      gender: _editProfileController
                                                  .gender.value ==
                                              ""
                                          ? childGender
                                          : _editProfileController.gender.value,
                                      state: _editProfileController
                                                  .state.value ==
                                              ""
                                          ? childState
                                          : _editProfileController.state.value,
                                      school: school.text.isEmpty
                                          ? childSchool
                                          : school.text,
                                    );
                                    await _editProfileController
                                        .editStudentDetails(
                                            context, childDetailRequest);
                                  }
                                },
                                buttonText: "Update Profile"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text('Loading...');
                  }
                }),
          ),
        ),
      ),
    );
  }
}

class EditAccountInfoContainer extends StatelessWidget {
  const EditAccountInfoContainer({
    Key? key,
    this.textEditingController,
    required this.title,
    this.labelText,
    this.subtitle,
    this.hintText,
    required this.validator,
    this.textInputType,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String title;
  final String? labelText;
  final String? subtitle;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 0),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.greyText, width: 0.5.sp),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            title,
            styles: TextStyles.size12_400,
            color: AppColors.darkGrey,
          ),
          Expanded(
            child: TextFormField(
              autofocus: false,
              validator: validator,
              keyboardType: textInputType ?? TextInputType.text,
              controller: textEditingController,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14.sp,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                labelText: labelText ?? "",
                hintText: hintText ?? "",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerForEditWithBottomSheet extends StatelessWidget {
  const ContainerForEditWithBottomSheet(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 0),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.greyText, width: 0.5.sp),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            title,
            styles: TextStyles.size12_400,
            color: AppColors.darkGrey,
          ),
          SizedBox(
            height: 20.h,
          ),
          TextWidget(
            value,
            styles: TextStyles.size14_500,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }
}
