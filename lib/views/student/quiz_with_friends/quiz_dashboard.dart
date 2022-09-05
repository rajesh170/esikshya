import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/quiz_dashboard_controller.dart';
import 'package:esikshya/controllers/student/friend_request_send_accept_view_controller.dart';
import 'package:esikshya/controllers/student/leaderboard_controller/leaderboard_controller.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/data/our_questions.dart';
import 'package:esikshya/models/network_models/response/get_friend_list_response.dart';
import 'package:esikshya/models/network_models/response/notification_screen_response.dart';
import 'package:esikshya/models/quiz_models/category_model.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/quiz/leaderboard/leaderboard_screen.dart';
import 'package:esikshya/views/student/quiz_with_friends/quiz_screen.dart';
import 'package:esikshya/views/student/search_view_friends/search_friend_screen.dart';

class QuizDashboard extends StatelessWidget {
  const QuizDashboard({Key? key, this.notificationResponse}) : super(key: key);
  final NotificationResponse? notificationResponse;

  @override
  Widget build(BuildContext context) {
    List _gradients = <Gradient>[
      AppColors.blueGradient,
      AppColors.redPinkGradient,
      AppColors.cyanGradient,
      AppColors.greenGradient,
      AppColors.peachGradient
    ];

    List _imagePath = [
      "assets/images/bio_icon.png",
      "assets/images/math_icon.png",
      "assets/images/phy_icon.png",
      // "assets/images/math_icon.png",
      // "assets/images/bio_icon.png",
    ];
    List _subject = [
      "SCIENCE",
      "MATH",
      "TECH",
      // "Math",
      // "Geography",
    ];

    final QuizDashboardController _quizDashboardController =
        Get.put(QuizDashboardController());
    final FriendRequestSendAcceptViewController _friendController =
        Get.put(FriendRequestSendAcceptViewController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton:
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Column(
              children: [
                const BuildHead(),
                InkWell(
                    onTap: () {
                      Get.to(() => const LeaderBoardScreen());
                    },
                    child: LeaderboardRank()),
                SizedBox(
                  height: 15.h,
                ),
                BuildFriendListContainer(
                    friendController: _friendController,
                    quizDashboardController: _quizDashboardController),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: Get.height * 0.25,
                  width: Get.width,
                  child: ListView.builder(
                      itemCount: _subject.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return QuizSubjects(
                          subjectImage: _imagePath[index],
                          subjectName: _subject[index],
                          gradient: _gradients[index],
                          quizDashboardController: _quizDashboardController,
                          index: index,
                          onTap: () {
                            if (_quizDashboardController.selectedSubject
                                .contains(_subject[index])) {
                              _quizDashboardController.selectedSubject.clear();
                            } else {
                              _quizDashboardController.selectedSubject.clear();
                              _quizDashboardController.selectedSubject
                                  .add(_subject[index]);
                            }
                          },
                        );
                      }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ButtonWidget(
                  onPressed: () async {
                    if (_quizDashboardController.selectedFriendId.isEmpty) {
                      AppWidgets.showSnackBar(context,
                          "Please select a friend you want to play with");
                    } else if (_quizDashboardController
                        .selectedSubject.isEmpty) {
                      AppWidgets.showSnackBar(
                          context, "Please select a subject");
                    } else {
                      // await _quizDashboardController.removeLobby(context,
                      //     _quizDashboardController.selectedFriendId[0]);

                      var childAccessToken =
                          await Get.find<AppSharedPreferences>()
                              .getChildAccessToken();
                      var grade = await Get.find<AppSharedPreferences>()
                          .getChildGrade();
                      log(grade.toString());
                      Get.to(() => QuizScreen(
                            title:
                                "${_quizDashboardController.selectedSubject[0]} quiz",
                            childAccessToken: childAccessToken!,
                            opponentId:
                                _quizDashboardController.selectedFriendId[0],
                            subjectName:
                                _quizDashboardController.selectedSubject[0],
                            grade: int.parse(grade.toString()),
                            connectivityStatus: "waiting",
                            isWithRandom: false,
                          ));
                    }
                  },
                  buttonText: "Play",
                  width: Get.width * 0.9,
                ),
                SizedBox(height: 15.h),
                ButtonWidget(
                  onPressed: () async {
                    if (_quizDashboardController.selectedSubject.isEmpty) {
                      AppWidgets.showSnackBar(
                          context, "Please select a subject");
                    } else {
                      var childAccessToken =
                          await Get.find<AppSharedPreferences>()
                              .getChildAccessToken();
                      var grade = await Get.find<AppSharedPreferences>()
                          .getChildGrade();
                      log(grade.toString());
                      Get.to(() => QuizScreen(
                            title:
                                "${_quizDashboardController.selectedSubject[0]} quiz",
                            childAccessToken: childAccessToken!,
                            subjectName:
                                _quizDashboardController.selectedSubject[0],
                            grade: int.parse(grade.toString()),
                            isWithRandom: true,
                            isFromNotificationScreen: true,
                          ));
                    }
                  },
                  buttonText: "Play With Random",
                  color: AppColors.darkBlue,
                  width: Get.width * 0.9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildFriendListContainer extends StatelessWidget {
  const BuildFriendListContainer({
    Key? key,
    required FriendRequestSendAcceptViewController friendController,
    required QuizDashboardController quizDashboardController,
  })  : _friendController = friendController,
        _quizDashboardController = quizDashboardController,
        super(key: key);

  final FriendRequestSendAcceptViewController _friendController;
  final QuizDashboardController _quizDashboardController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.2,
      width: Get.width,
      decoration: const BoxDecoration(
        color: AppColors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.greyText, width: 1.w),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget("Play with a friend"),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: TextWidget(
                    "SHOW ALL",
                    styles: TextStyles.size14_600,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Get.height * 0.1,
            color: AppColors.transparent,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const SearchFriendScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.purpleBlue,
                        child: Icon(
                          Icons.add,
                          size: 20.sp,
                          color: AppColors.white,
                        )),
                  ),
                ),
                FutureBuilder(
                  future: _friendController.getFriendList(context),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: SizedBox(
                          height: 30.h,
                          width: 30.h,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.lightPink,
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.data.length < 0) {
                      return TextWidget("");
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              GetFriendListResponse _getFriendListResponse =
                                  snapshot.data[index];
                              return InkWell(
                                splashColor: AppColors.transparent,
                                onTap: () {
                                  _quizDashboardController.friendTapped.value =
                                      true;
                                  if (_quizDashboardController.selectedFriendId
                                      .contains(_getFriendListResponse.id)) {
                                    _quizDashboardController.selectedFriendId
                                        .clear();
                                  } else {
                                    _quizDashboardController.selectedFriendId
                                        .clear();
                                    _quizDashboardController.selectedFriendId
                                        .add(_getFriendListResponse.id);
                                  }
                                },
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Stack(
                                      children: [
                                        Obx(
                                          () => CircleAvatar(
                                            radius: 35.r,
                                            backgroundColor:
                                                _quizDashboardController
                                                        .selectedFriendId
                                                        .contains(
                                                            _getFriendListResponse
                                                                .id)
                                                    ? AppColors.lightGreen
                                                    : AppColors.greyText,
                                            child: TextWidget(
                                              snapshot.data[index].name,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                        // Obx(
                                        //   () => Positioned(
                                        //     right: 0,
                                        //     child: Checkbox(
                                        //       value: _quizDashboardController
                                        //           .selectedFriendId
                                        //           .contains(
                                        //               _getFriendListResponse
                                        //                   .id),
                                        //       onChanged: (value) {
                                        //         _quizDashboardController
                                        //             .selectedFriendId
                                        //             .clear();
                                        //         _quizDashboardController
                                        //             .selectedFriendId
                                        //             .add(_getFriendListResponse
                                        //                 .id);
                                        //       },
                                        //     ),
                                        //     //  CircleAvatar(
                                        //     //   radius: 10.r,
                                        //     //   backgroundColor:
                                        //     //       AppColors.lightPink,
                                        //     //   child: Icon(
                                        //     //     Icons.done,
                                        //     //     color: AppColors.white,
                                        //     //     size: 15.sp,
                                        //     //   ),
                                        //     // ),
                                        //   ),
                                        // ),
                                      ],
                                    )),
                              );
                            }),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuizSubjects extends StatelessWidget {
  const QuizSubjects({
    Key? key,
    required this.gradient,
    required this.subjectName,
    required this.subjectImage,
    required QuizDashboardController quizDashboardController,
    required this.index,
    this.onTap,
  })  : _quizDashboardController = quizDashboardController,
        super(key: key);
  final Gradient gradient;
  final int index;
  final String subjectName;
  final String subjectImage;
  final QuizDashboardController _quizDashboardController;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(children: [
        Obx(
          () => Container(
            width: Get.width * 0.4,
            height: Get.height * 0.25,
            margin: EdgeInsets.only(right: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            decoration: BoxDecoration(
              gradient:
                  _quizDashboardController.selectedSubject.contains(subjectName)
                      ? AppColors.greenGradient
                      : AppColors.blackGradient,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: AppColors.white,
                  child: Center(
                    child: Image.asset(
                      subjectImage,
                      height: 25.h,
                      width: 25.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                FittedBox(
                  child: TextWidget(
                    "Play $subjectName Quiz",
                    styles: TextStyles.size14_600,
                    color: AppColors.white,
                    maxLines: 5,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: Get.height * 0.3,
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
        // Obx(
        //   () => Positioned(
        //     right: 0,
        //     child: Checkbox(
        //       value: _quizDashboardController.selectedSubject
        //           .contains(subjectName),
        //       onChanged: (value) {
        //         _quizDashboardController.selectedSubject.clear();
        //         _quizDashboardController.selectedSubject.add(subjectName);
        //       },
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}

class LeaderboardRank extends StatelessWidget {
  const LeaderboardRank({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LeaderboardController _leaderboardController =
        Get.put(LeaderboardController());
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: AppColors.orangeGradient,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: TextWidget(
                "Leaderboard Rank",
                styles: TextStyles.size15_600,
                color: AppColors.white,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LeaderboardItems(
                  icon: Icons.star_border,
                  title: "POINTS",
                  value: _leaderboardController.totalPoints.value == ""
                      ? " "
                      : _leaderboardController.totalPoints.value,
                ),
                Container(
                  height: Get.height * 0.06,
                  color: AppColors.white.withOpacity(0.5),
                  width: 1.w,
                ),
                LeaderboardItems(
                  icon: Icons.public,
                  title: "Nepal",
                  value: _leaderboardController.countryRank.value == ""
                      ? " "
                      : "#${_leaderboardController.countryRank.value}",
                ),
                Container(
                  height: Get.height * 0.06,
                  color: AppColors.white.withOpacity(0.5),
                  width: 1.w,
                ),
                LeaderboardItems(
                  icon: Icons.local_activity_outlined,
                  title: "LOCAL RANK",
                  value: _leaderboardController.provinceRank.value == ""
                      ? " "
                      : "#${_leaderboardController.provinceRank.value}",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LeaderboardItems extends StatelessWidget {
  const LeaderboardItems({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);
  final IconData? icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: AppColors.white,
        ),
        SizedBox(
          height: 3.h,
        ),
        FittedBox(
          child: TextWidget(
            title,
            styles: TextStyles.size12_500,
            color: AppColors.white,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        FittedBox(
          child: TextWidget(
            value,
            styles: TextStyles.size15_700,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class BuildHead extends StatelessWidget {
  const BuildHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Icon(
                Icons.arrow_back,
                size: 25.sp,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                FittedBox(
                  child: FutureBuilder(
                      future:
                          Get.find<AppSharedPreferences>().getChildUserName(),
                      builder: (context, AsyncSnapshot snapshot) {
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
                ),
                SizedBox(
                  height: 10.h,
                ),
                // snapshot.data[1] == "0" ?
                FittedBox(
                  child: TextWidget(
                    "Let us learn by playing games",
                    styles: TextStyles.size12_500,
                    color: AppColors.black,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 0,
            child: Image.asset(
              "assets/images/rocket_child.png",
              height: 100.h,
              width: 70.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
