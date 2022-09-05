import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:esikshya/controllers/bottom_nav_bar_controller.dart';
import 'package:esikshya/controllers/student/student_home_screen_controller.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/models/network_models/response/videos_response/fectch_videos_by_class_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_constants_list.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/quiz_with_friends/quiz_dashboard.dart';
import 'package:esikshya/views/student/student_profile/student_profile.dart';
import 'package:esikshya/views/student/student_subject_details/student_subject_details.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  // MainDashBoardController _mainDashboardController = MainDashBoardController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _checkVersion();
  }

  // void _checkVersion() async {
  //   final newVersion = NewVersion(
  //     // iOSId: 'com.google.Vespa',
  //     androidId: 'com.snapchat.android',
  //     // androidId: 'np.net.gaadibazaar',
  //   );
  //   var versionStatus = await newVersion.getVersionStatus();
  //   print(versionStatus!.localVersion.toString());
  //   print(versionStatus.releaseNotes.toString());
  //   print(versionStatus.storeVersion.toString());
  //   var localVersion = getExtendedVersionNumber(versionStatus.localVersion);
  //   var storeVersion = getExtendedVersionNumber(versionStatus.storeVersion);
  //   log(localVersion.toString());
  //   log(storeVersion.toString());

  //   if (localVersion < storeVersion) {
  //     newVersion.showUpdateDialog(
  //       context: context,
  //       versionStatus: versionStatus,
  //     );
  //   }
  // }

  int getExtendedVersionNumber(String version) {
    // Note that if you want to support bigger version cells than 99,
    // just increase the returned versionCells multipliers
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 10000 + versionCells[1] * 100 + versionCells[2];
  }

  final List _subjectImagelist = [
    "assets/images/phy_icon.png",
    "assets/images/math_icon.png",
    "assets/images/bio_icon.png",
    "assets/images/phy_icon.png",
    "assets/images/math_icon.png",
    "assets/images/bio_icon.png",
  ];

  final _sharedPref = Get.find<AppSharedPreferences>();
  final StudentHomeScreenController _studentHomeScreenController =
      Get.put(StudentHomeScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Obx(
          () => Get.find<BottomNavController>().changeStateOfHomeScreen.value
              ? SingleChildScrollView(
                  // height: ScreenUtil.defaultSize.height,
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 25.h,
                      // ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 0, 10.w, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                // mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  FutureBuilder(
                                      future: _sharedPref.getChildUserName(),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        return snapshot.data != ""
                                            ? TextWidget(
                                                "Hi, ${snapshot.data.toString().capitalizeFirst}",
                                                styles: TextStyles.size18_600,
                                              )
                                            : TextWidget(
                                                "Hi, Anonymous",
                                                styles: TextStyles.size18_600,
                                              );
                                      }),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  // snapshot.data[1] == "0" ?
                                  TextWidget(
                                    "What would you  like to learn today?",
                                    styles: TextStyles.size12_500,
                                    color: AppColors.black,
                                    maxLines: 2,
                                  )
                                  // Text("Glad, you are teaching today!",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "Montserrat",color: AppColors.grey),)
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              flex: 0,
                              child: Image.asset(
                                "assets/images/red_guy.png",
                                height: 100.h,
                                width: 50.w,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 30.h,
                      // ),
                      Container(
                        color: AppColors.scaffoldColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 15.h),
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.h,
                              crossAxisSpacing: 10.w,
                              childAspectRatio: 2.5.h,
                            ),
                            itemCount: 6,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // Get.to(
                                  //   () => SubjectDetails(
                                  //     subject: AppConstantsList.timeTableSubjects[index],
                                  //   ),
                                  // );
                                  Get.to(
                                    // () => MySubjectDetails(),
                                    () => StudentSubjectDetails(
                                      subjectName: AppConstantsList
                                          .esikshyaSubjects[index],
                                      imagePath: AppConstantsList
                                          .scientistImage[index],
                                      scientistName:
                                          AppConstantsList.scientistName[index],
                                      scientistContribution: AppConstantsList
                                          .scientistContribution[index],
                                    ),
                                  );
                                },
                                child: SubjectWidget(
                                  name:
                                      AppConstantsList.esikshyaSubjects[index],
                                  image: _subjectImagelist[index],
                                  containerColor: index == 0
                                      ? AppColors.lightOrange
                                      : index == 1
                                          ? AppColors.blueishGrey
                                          : index == 2
                                              ? AppColors.blue
                                              : index == 3
                                                  ? AppColors.lightGreen
                                                  : index == 4
                                                      ? AppColors.purpleBlue
                                                      : index == 5
                                                          ? AppColors.aqua
                                                          : AppColors.blue,
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 12.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: TextWidget(
                                  "My Time tables for today",
                                  styles: TextStyles.size12_500,
                                  color: AppColors.whitishGrey,
                                )),
                                TextWidget(
                                  "17 Aug, 2021",
                                  styles: TextStyles.size12_600,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    AppConstantsList.timeTableSubjects.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 0.9.h,
                                ),
                                itemBuilder: (context, index) {
                                  return index == 0
                                      ? TimeTableContainer(
                                          circularBorder: "left",
                                          subject: AppConstantsList
                                              .timeTableSubjects[index])
                                      : (index ==
                                              AppConstantsList.timeTableSubjects
                                                      .length -
                                                  1
                                          ? TimeTableContainer(
                                              circularBorder: "right",
                                              subject: AppConstantsList
                                                  .timeTableSubjects[index])
                                          : (index % 4 == 0
                                              ? Container()
                                              : TimeTableContainer(
                                                  circularBorder: "",
                                                  subject: AppConstantsList
                                                          .timeTableSubjects[
                                                      index])));
                                }),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget("Latest videos",
                                    styles: TextStyles.size12_600,
                                    color: AppColors.whitishGrey),
                                TextWidget("SEE ALL",
                                    styles: TextStyles.size12_600,
                                    color: AppColors.lightPink),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: 150.h,
                              width: Get.width,
                              child: FutureBuilder(
                                  future: _studentHomeScreenController
                                      .fetchVideosByClass(context),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        itemCount: snapshot.data.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          FetchVideoByClassResponse
                                              _snapshotData =
                                              snapshot.data[index];
                                          return Center(
                                            child: Container(
                                              height: 100.h,
                                              width: Get.width * 0.45,
                                              margin: EdgeInsets.only(
                                                right: 5.w,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.scaffoldColor,
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                              ),
                                              child: Column(
                                                children: [
                                                  TextWidget(_snapshotData.grade
                                                      .toString()),
                                                  TextWidget(_snapshotData.topic
                                                      .toString()),
                                                  TextWidget(_snapshotData.url
                                                      .toString()),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return TextWidget("");
                                    }
                                  }),
                              //
                            ),
                            SizedBox(height: 15.h),
                            InkWell(
                              onTap: () {
                                Get.to(() => const QuizDashboard());
                              },
                              child: Stack(children: [
                                Container(
                                  // width: Get.width,
                                  // height: Get.height * 0.15,
                                  padding:
                                      EdgeInsets.fromLTRB(16.w, 20.h, 16, 20.h),
                                  decoration: BoxDecoration(
                                    gradient: const RadialGradient(
                                      radius: 5,
                                      colors: [
                                        Color(0xff2889EB),
                                        Color(0xff0B56CB),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextWidget(
                                        "Quiz challenge",
                                        styles: TextStyles.size14_600,
                                        color: AppColors.white,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      TextWidget(
                                        "Play quiz challange with other random students and see where you rank overall ",
                                        styles: TextStyles.size12_500,
                                        color: AppColors.yellow,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 55.h,
                                  child: Image.asset(
                                    "assets/images/dots.png",
                                    color: AppColors.white,
                                    height: 30.h,
                                    width: 35.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  right: 5.h,
                                  child: Column(children: [
                                    Image.asset(
                                      "assets/images/dots.png",
                                      color: AppColors.white,
                                      height: 30.h,
                                      width: 35.h,
                                      fit: BoxFit.fill,
                                    ),
                                    Image.asset(
                                      "assets/images/dots.png",
                                      color: AppColors.white,
                                      height: 30.h,
                                      width: 35.h,
                                      fit: BoxFit.fill,
                                    ),
                                    Image.asset(
                                      "assets/images/dots.png",
                                      color: AppColors.white,
                                      height: 30.h,
                                      width: 35.h,
                                      fit: BoxFit.fill,
                                    ),
                                  ]),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ImageIconWidget(
                                        imagePath: "assets/images/event.png",
                                        title: "Event",
                                        onTap: () async {},
                                      ),
                                      ImageIconWidget(
                                        imagePath:
                                            "assets/images/black_board.png",
                                        title: "My Classes",
                                        onTap: () {
                                          // Get.to(() => const MyQuizScreen());
                                        },
                                      ),
                                      ImageIconWidget(
                                        imagePath: "assets/images/people.png",
                                        title: "Quiz",
                                        onTap: () {
                                          Get.to(() => const QuizDashboard());
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ImageIconWidget(
                                          imagePath:
                                              "assets/images/document.png",
                                          title: "E-Library",
                                          onTap: () {}),
                                      ImageIconWidget(
                                          imagePath: "assets/images/intern.png",
                                          title: "Online Classes",
                                          onTap: () {}),
                                      ImageIconWidget(
                                          imagePath:
                                              "assets/images/vip_icon.png",
                                          title: "Subscibe",
                                          onTap: () {}),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/invite.png",
                                      height: 80.h,
                                      width: 80.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.3,
                                          child: TextWidget(
                                            "Refer this app to your \nfriends",
                                            styles: TextStyles.size12_400,
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 10.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            color: AppColors.blue,
                                          ),
                                          child: TextWidget(
                                            "Invite Now!",
                                            styles: TextStyles.size12_700,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      "assets/images/alien2.png",
                                      height: 80.h,
                                      width: 80.h,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

class ImageIconWidget extends StatelessWidget {
  const ImageIconWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.25,
      height: Get.height * 0.09,
      // color: AppColors.aqua,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 32.h,
              width: 32.h,
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: TextWidget(
                title,
                styles: TextStyles.size10_400,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectWidget extends StatelessWidget {
  final String name;
  final String image;
  final Color containerColor;

  const SubjectWidget({
    Key? key,
    required this.name,
    required this.image,
    required this.containerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.2,
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: containerColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.white,
            // backgroundImage: AssetImage(image),
            child: Container(
              padding: EdgeInsets.all(5.h),
              child: Center(
                child: Image.asset(
                  image,
                  height: 25.h,
                  width: 25.h,
                  fit: BoxFit.fill,
                  color: containerColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: TextWidget(
              name,
              styles: TextStyles.size12_400,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}

class TimeTableContainer extends StatelessWidget {
  final String subject;
  final String circularBorder;
  const TimeTableContainer(
      {Key? key, required this.circularBorder, required this.subject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 3.h, 2.w, 0),
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
          color: const Color(0xFFFCE2B6),
          borderRadius: circularBorder == "left"
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
              : (circularBorder == "right"
                  ? const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))
                  : null)),
      child: SizedBox(
        height: 30.h,
        width: Get.width * 0.01,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              subject,
              styles: TextStyles.size12_600,
              font: "Montserrat",
              color: subject == "Break" ? AppColors.lightPink : AppColors.black,
              textOverflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 2,
            ),
            Expanded(
              child: TextWidget(
                "9:00-10:00 ",
                styles: TextStyles.size8_400,
              ),
            ),

            // Align(
            //     alignment: Alignment.centerRight,
            //     child: TextWidget(
            //       "class 5A",
            //       styles: TextStyles.size10_500,
            //     )),
          ],
        ),
      ),
    );
  }
}

// class MyActivityWidget extends StatelessWidget {
//   final String imageUrl;
//   final String title1;
//   final String title2;
//   // ignore: use_key_in_widget_constructors
//   const MyActivityWidget(
//       {required this.imageUrl, required this.title1, required this.title2});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 3,
//               blurRadius: 5),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//               flex: 2,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     bottomLeft: Radius.circular(12)),
//                 child: Image.asset(
//                   imageUrl,
//                   height: 130,
//                   fit: BoxFit.fill,
//                 ),
//               )),
//           SizedBox(width: 12.w),
//           Expanded(
//             flex: 3,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 12.h),
//                 TextWidget(
//                   title1,
//                   styles: TextStyles.size16_700,
//                   font: "Montserrat",
//                 ),
//                 SizedBox(
//                   height: 8.h,
//                 ),
//                 TextWidget(
//                   title2,
//                   styles: TextStyles.size12_400,
//                   font: "Montserrat",
//                   maxLines: 3,
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class IconTextWidget extends StatelessWidget {
//   final Icon icon;
//   final Color color;
//   final String text;
//   const IconTextWidget(
//       {Key? key, required this.icon, required this.text, required this.color})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(8.h),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(shape: BoxShape.circle, color: color),
//             padding: const EdgeInsets.all(8),
//             child: icon,
//           ),
//           SizedBox(
//             width: 12.w,
//           ),
//           TextWidget(
//             text,
//             styles: TextStyles.size14_400,
//           ),
//           const Spacer(),
//           const Icon(
//             Icons.navigate_next,
//             color: AppColors.darkGrey,
//           )
//         ],
//       ),
//     );
//   }
// }
