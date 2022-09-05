import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/quiz_with_friends/quiz_dashboard.dart';
import 'package:esikshya/views/student/quiz_with_friends/quiz_screen.dart';

class QuizShowResultScreen extends StatelessWidget {
  const QuizShowResultScreen({
    Key? key,
    required this.hasWon,
    required this.yourScore,
    required this.opponentScore,
    required this.yourName,
    required this.opponentName,
    required this.childAccessToken,
    required this.subjectName,
    this.opponentId,
    required this.isWithRandom,
    required this.grade,
  }) : super(key: key);
  final bool hasWon;
  final String yourScore;
  final String opponentScore;
  final String yourName;
  final String opponentName;
  final String childAccessToken;
  final String subjectName;
  final int? opponentId;
  final int grade;
  final bool isWithRandom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.darkThemeBackground,
        padding: EdgeInsets.fromLTRB(15.w, 70.h, 15.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hasWon
                ? Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/papers.png",
                          height: Get.height * 0.2,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/trophy.png",
                          height: Get.height * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/trophy_blur.png",
                          height: Get.height * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Image.asset(
                      "assets/images/supertoon.png",
                      height: Get.height * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
            SizedBox(height: Get.height * 0.1),
            TextWidget(
              hasWon ? "Congratulations!" : "Try Again!",
              styles: TextStyles.size22_700,
              color: AppColors.white,
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AvatarAndScoreWidget(
                  backgroundColor: AppColors.darkBlue,
                  imagePath: "assets/images/sardar.png",
                  name: yourName,
                  location: "Kathmandu",
                  score: yourScore.toString(),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 0, horizontal: Get.width * 0.1),
                    height: Get.height * 0.1,
                    width: 1.w,
                    color: AppColors.greyText.withOpacity(0.4)),
                AvatarAndScoreWidget(
                  backgroundColor: AppColors.darkBlue,
                  imagePath: "assets/images/sardar.png",
                  name: opponentName,
                  location: "Kathmandu",
                  score: opponentScore.toString(),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            ButtonWidget(
              onPressed: () {
                // Get.off(() => QuizScreen(
                //     title: "title",
                //     childAccessToken: childAccessToken,
                //     subjectName: subjectName,
                //     opponentId: opponentId,
                //     grade: grade,
                //     isWithRandom: isWithRandom));
                Get.back();
                // Get.off(() => const QuizDashboard());
              },
              width: Get.width * 0.8,
              buttonText: "Play Again",
            )
          ],
        ),
      ),
    );
  }
}

class AvatarAndScoreWidget extends StatelessWidget {
  const AvatarAndScoreWidget(
      {Key? key,
      required this.imagePath,
      required this.backgroundColor,
      required this.location,
      required this.name,
      required this.score})
      : super(key: key);
  final String imagePath;
  final Color backgroundColor;
  final String location;
  final String name;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        backgroundImage: const AssetImage("assets/images/sardar.png"),
        radius: 25.r,
        backgroundColor: AppColors.white,
      ),
      TextWidget(
        name,
        styles: TextStyles.size12_400,
        color: AppColors.white,
      ),
      TextWidget(
        location,
        styles: TextStyles.size12_400,
        color: AppColors.darkGrey,
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        margin: EdgeInsets.symmetric(
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: backgroundColor,
        ),
        child: TextWidget(
          score,
          styles: TextStyles.size12_400,
          color: AppColors.white,
        ),
      )
    ]);
  }
}
