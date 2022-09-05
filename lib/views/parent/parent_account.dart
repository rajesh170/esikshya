import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/controllers/parent/parent_account_controller.dart';
import 'package:esikshya/controllers/parent/parent_edit_profile_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ParentAccount extends StatelessWidget {
  const ParentAccount(
      {Key? key, required this.parentName, required this.parentPhone})
      : super(key: key);
  final String parentName;
  final String parentPhone;

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    ParentAccountController _parentAccountController =
        Get.put(ParentAccountController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkModeOn
            ? AppColors.darkThemeBackground
            : const Color(0xffF8FAFB),
        appBar: CustomAppBar(
          title: "Account",
          leadingIcon: Icons.arrow_back,
          appBarBackgroundColor: isDarkModeOn
              ? AppColors.darkThemeBackground
              : const Color(0xffF8FAFB),
          centerTitle: true,
          txtColor: isDarkModeOn ? AppColors.white : AppColors.black,
          trailingIcon: Icons.settings,
          iconColor: isDarkModeOn ? AppColors.white : AppColors.blackGrey,
          iconSize: 20.sp,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageAndName(
                  isDarkModeOn: isDarkModeOn,
                  parentName: parentName,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isDarkModeOn
                        ? AppColors.darkThemeCardColor
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        "Subscription Details",
                        styles: TextStyles.size14_500,
                        color: isDarkModeOn ? AppColors.white : AppColors.black,
                      ),
                      Divider(
                        color: isDarkModeOn
                            ? AppColors.greyText
                            : AppColors.darkGrey,
                      ),
                      TextWidget(
                        "10th Sept, 2021",
                        styles: TextStyles.size12_400,
                        color: isDarkModeOn ? AppColors.white : AppColors.black,
                      ),
                      TextWidget(
                        "Joined date",
                        styles: TextStyles.size10_400,
                        color: isDarkModeOn
                            ? AppColors.greyText
                            : AppColors.blackGrey,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isDarkModeOn
                        ? AppColors.darkThemeCardColor
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        "Secret Code",
                        styles: TextStyles.size14_500,
                        color: isDarkModeOn ? AppColors.white : AppColors.black,
                      ),
                      Divider(
                        color: isDarkModeOn
                            ? AppColors.greyText
                            : AppColors.darkGrey,
                      ),
                      FutureBuilder(
                          future:
                              _parentAccountController.fetchParentCode(context),
                          builder: (context, AsyncSnapshot snapshot) {
                            return TextWidget(
                              snapshot.hasData ? snapshot.data.toString() : " ",
                              styles: TextStyles.size12_400,
                              color: isDarkModeOn
                                  ? AppColors.white
                                  : AppColors.black,
                            );
                          }),
                      TextWidget(
                        "Use this code for child registration",
                        styles: TextStyles.size10_400,
                        color: isDarkModeOn
                            ? AppColors.greyText
                            : AppColors.blackGrey,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isDarkModeOn
                        ? AppColors.darkThemeCardColor
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        "Login Details",
                        styles: TextStyles.size14_500,
                        color: isDarkModeOn ? AppColors.white : AppColors.black,
                      ),
                      Divider(
                        color: isDarkModeOn
                            ? AppColors.greyText
                            : AppColors.darkGrey,
                      ),
                      TextWidget(
                        parentPhone,
                        styles: TextStyles.size12_400,
                        color: isDarkModeOn ? AppColors.white : AppColors.black,
                      ),
                      TextWidget(
                        "Registered mobile Number",
                        styles: TextStyles.size10_400,
                        color: isDarkModeOn
                            ? AppColors.greyText
                            : AppColors.blackGrey,
                      ),
                      Divider(
                        color: isDarkModeOn
                            ? AppColors.greyText
                            : AppColors.darkGrey,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isDarkModeOn
                        ? AppColors.darkThemeCardColor
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        "Children Details",
                        styles: TextStyles.size14_500,
                        color: isDarkModeOn ? AppColors.white : AppColors.black,
                      ),
                      Divider(
                        color: isDarkModeOn
                            ? AppColors.greyText
                            : AppColors.darkGrey,
                      ),
                      FutureBuilder(
                          // future: DatabaseHelper.instance.getChildDetails(),
                          future:
                              _parentAccountController.getChildDetails(context),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 25.h,
                                    horizontal: Get.width * 0.4,
                                  ),
                                  height: 30.w,
                                  width: 30.w,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.lightPink,
                                  ));
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, index) {
                                    return ChildDetailText(
                                      isDarkModeOn: isDarkModeOn,
                                      childName: snapshot.data[index].fullName,
                                      username: snapshot.data[index].username,
                                      grade: snapshot.data[index].grade,
                                    );
                                  });
                            }
                            return const Text(
                                'No Child Account has been created');
                          }),
                      // TextWidget(
                      //   "Profile Name",
                      //   styles: TextStyles.size10_400,
                      //   color: isDarkModeOn
                      //       ? AppColors.greyText
                      //       : AppColors.blackGrey,
                      // ),
                      // Divider(
                      //   color: isDarkModeOn
                      //       ? AppColors.greyText
                      //       : AppColors.darkGrey,
                      // ),
                      // TextWidget(
                      //   "senoritagomez789@gmail.com",
                      //   styles: TextStyles.size12_400,
                      //   color: isDarkModeOn ? AppColors.white : AppColors.black,
                      // ),
                      // TextWidget(
                      //   "Email",
                      //   styles: TextStyles.size10_400,
                      //   color: isDarkModeOn
                      //       ? AppColors.greyText
                      //       : AppColors.blackGrey,
                      // ),
                      // Divider(
                      //   color: isDarkModeOn
                      //       ? AppColors.greyText
                      //       : AppColors.darkGrey,
                      // ),
                      // TextWidget(
                      //   "Kathmandu",
                      //   styles: TextStyles.size12_400,
                      //   color: isDarkModeOn ? AppColors.white : AppColors.black,
                      // ),
                      // TextWidget(
                      //   "Location",
                      //   styles: TextStyles.size10_400,
                      //   color: isDarkModeOn
                      //       ? AppColors.greyText
                      //       : AppColors.blackGrey,
                      // ),
                    ],
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

class ChildDetailText extends StatelessWidget {
  const ChildDetailText({
    Key? key,
    required this.isDarkModeOn,
    required this.childName,
    required this.username,
    required this.grade,
  }) : super(key: key);

  final bool isDarkModeOn;
  final String childName;
  final String username;
  final int grade;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          childName,
          styles: TextStyles.size12_400,
          color: isDarkModeOn ? AppColors.white : AppColors.black,
        ),
        TextWidget(
          username,
          styles: TextStyles.size12_400,
          color: isDarkModeOn ? AppColors.white : AppColors.black,
        ),
        TextWidget(
          'Grade: $grade',
          styles: TextStyles.size12_400,
          color: isDarkModeOn ? AppColors.white : AppColors.black,
        ),
        Divider(
          color: isDarkModeOn ? AppColors.greyText : AppColors.darkGrey,
        ),
      ],
    );
  }
}

class ImageAndName extends StatelessWidget {
  const ImageAndName({
    Key? key,
    required this.isDarkModeOn,
    required this.parentName,
  }) : super(key: key);
  final bool isDarkModeOn;
  final String parentName;

  @override
  Widget build(BuildContext context) {
    final _sharedPref = Get.find<AppSharedPreferences>();
    ParentEditProfileController _parentEditProfileController =
        Get.put(ParentEditProfileController());
    TextEditingController parentFullNameController =
        TextEditingController(text: parentName);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: isDarkModeOn ? AppColors.darkThemeCardColor : AppColors.white,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35.r,
            backgroundImage: const AssetImage("assets/images/alien2.png"),
            backgroundColor: AppColors.white,
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextWidget(
                //   _sharedPref.getParentName.toString(),
                //   styles: TextStyles.size14_500,
                //   color: isDarkModeOn ? AppColors.white : AppColors.black,
                // ),
                FutureBuilder(
                    future: _sharedPref.getParentName(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return TextFormField(
                          style: TextStyle(
                              color: isDarkModeOn
                                  ? AppColors.white
                                  : AppColors.black),
                          controller: parentFullNameController,
                          decoration: InputDecoration(
                            // hintText: snapshot.data.toString(),
                            hintStyle: TextStyle(
                                color: isDarkModeOn
                                    ? AppColors.white
                                    : AppColors.black),
                          ),
                          onFieldSubmitted: (value) async {
                            await _parentEditProfileController
                                .editParentProfile(context, value);
                          },
                        );
                      }
                      return const Text('Loading...');
                    }),

                // TextWidget(
                //   "5th Grade",
                //   styles: TextStyles.size12_400,
                //   color: AppColors.blackGrey,
                // ),
              ],
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 15.sp,
            color: AppColors.blackGrey,
          ),
        ],
      ),
    );
  }
}
