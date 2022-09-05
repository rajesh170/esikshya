import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/student/student_profile_controller.dart';
import 'package:esikshya/custom_widgets/k_container_with_icon_text_arrow.dart';
import 'package:esikshya/custom_widgets/k_container_with_icons.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/parent/parent_settings/parent_settings.dart';
import 'package:esikshya/views/parent/parent_settings/parent_support_screen.dart';
import 'package:esikshya/views/parent/parent_time_table.dart';
import 'package:esikshya/views/student/edit_profile/edit_profile.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blue,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 271.h,
              backgroundColor: AppColors.blue,
              flexibleSpace: PreferredSize(
                preferredSize: const Size(double.infinity, kToolbarHeight),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 79.h),
                      CircleAvatar(
                        radius: 48.r,
                        backgroundImage: const AssetImage(
                          "assets/images/sardar.png",
                        ),
                        backgroundColor: const Color(0xff36DEED),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      FutureBuilder(
                          future: Get.find<AppSharedPreferences>()
                              .getChildUserName(),
                          builder: (context, AsyncSnapshot snapshot) {
                            return TextWidget(
                              snapshot.hasData ? snapshot.data.toString() : " ",
                              styles: TextStyles.size24_600,
                              color: AppColors.white,
                            );
                          }),
                      SizedBox(
                        height: 5.h,
                      ),
                      FutureBuilder(
                        future: Get.find<AppSharedPreferences>().getChildName(),
                        builder: (context, AsyncSnapshot snapshot) {
                          return TextWidget(
                            snapshot.hasData ? snapshot.data.toString() : "",
                            styles: TextStyles.size14_400,
                            color: AppColors.white,
                          );
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buildBody(context)
          ],
        ),
      ),
    );
  }
}

Widget buildBody(BuildContext context) {
  StudentProfileController studentProfileController =
      Get.put(StudentProfileController());
  return SliverToBoxAdapter(
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(23.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              "Main Categories",
              styles: TextStyles.size17_600,
              color: const Color(0xff112950),
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              children: [
                CustomContainerWithIcons(
                  color: AppColors.blue,
                  imgPath: "assets/images/Calendar.png",
                  imgBackgroundColor: const Color(0xffC8FBFF),
                  containerName: "Time Table",
                  onTap: () {
                    Get.to(() => const ParentTimeTable());
                  },
                ),
                const Spacer(),
                CustomContainerWithIcons(
                  color: const Color(0xffFEAA48),
                  imgPath: "assets/images/Stopwatch.png",
                  imgBackgroundColor: const Color(0xffF5E3FB),
                  containerName: "Progress",
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                CustomContainerWithIcons(
                  color: const Color(0xffFD586B),
                  imgPath: "assets/images/Contact.png",
                  imgBackgroundColor: AppColors.white,
                  containerName: "Assignment",
                  onTap: () {},
                ),
                const Spacer(),
                CustomContainerWithIcons(
                  color: const Color(0xff36DEED),
                  imgPath: "assets/images/Heart Rate.png",
                  imgBackgroundColor: AppColors.white,
                  containerName: "Health Tracking",
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            Padding(
              padding: EdgeInsets.all(0.h),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      Map data =
                          await studentProfileController.getChildDetail();
                      log(data.toString());
                      Get.to(
                        () => EditProfileScreen(
                            fullname: data['full_name'],
                            childCountry: data['country'],
                            childGrade: data['grade'],
                            childGender: data['gender'],
                            childState: data['state'],
                            childSchool: data['school']),
                      );
                    },
                    child: const ContainerWithIConTextAndArrow(
                      text: "Edit Profile",
                      circleColor: Color(0xffFFCC00),
                      icon: Icons.save,
                    ),
                  ),
                  const Divider(),
                  const ContainerWithIConTextAndArrow(
                      text: "My level",
                      circleColor: Color(0xff5AC8FA),
                      icon: Icons.bar_chart),
                  const Divider(),
                  ContainerWithIConTextAndArrow(
                    text: "Contact us",
                    circleColor: const Color(0xff7ED321),
                    icon: Icons.person_add,
                    onTap: () {
                      Get.to(() => const ParentSupportScreen());
                    },
                  ),
                  const Divider(),
                  ContainerWithIConTextAndArrow(
                      text: "Rate us",
                      circleColor: const Color(0xffFF8C00),
                      onTap: () {},
                      icon: Icons.description),
                  const Divider(),
                  ContainerWithIConTextAndArrow(
                    text: "Settings",
                    circleColor: const Color(0xff000000),
                    icon: Icons.settings,
                    onTap: () {
                      Get.to(() => const ParentSettings());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 84.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        "Privacy    ",
                        color: const Color(0xff666E7A),
                        styles: TextStyles.size12_600,
                      ),
                      TextWidget(
                        "|    ",
                        color: const Color(0xff666E7A),
                        styles: TextStyles.size12_600,
                      ),
                      TextWidget(
                        "About Us   ",
                        color: const Color(0xff666E7A),
                        styles: TextStyles.size12_600,
                      ),
                      TextWidget(
                        "|    ",
                        color: const Color(0xff666E7A),
                        styles: TextStyles.size12_600,
                      ),
                      FittedBox(
                        child: TextWidget(
                          "Logout   ",
                          color: const Color(0xff666E7A),
                          styles: TextStyles.size12_600,
                        ),
                      ),
                    ],
                  ),
                  TextWidget(
                    "App version 0.1",
                    styles: TextStyles.size12_400,
                    color: const Color(0xff666E7A),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
