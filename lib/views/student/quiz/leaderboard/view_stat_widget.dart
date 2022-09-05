import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:esikshya/controllers/student/leaderboard_controller/leaderboard_controller.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/your_stat_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_constants_list.dart';
import 'package:esikshya/utils/text_widget.dart';

class ViewStatWidget extends StatelessWidget {
  const ViewStatWidget({
    Key? key,
    required this.leaderboardController,
  }) : super(key: key);
  final LeaderboardController leaderboardController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: FutureBuilder(
          future: leaderboardController.fetchYourStat(
              context, int.parse(DateFormat.M().format(DateTime.now()))),
          builder: (context, AsyncSnapshot snapshot) {
            // if (snapshot.hasData) {
            //   YourStatResponse _yourStat = snapshot.data;
            return Obx(
              () => Container(
                  height: Get.height,
                  width: Get.width,
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/stat_bg.png"),
                    fit: BoxFit.cover,
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 15.w),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: AppColors.scaffoldColor,
                                      width: 2.h,
                                    ))),
                                    child: TextWidget(
                                      "bottomSheetHeading!",
                                      styles: TextStyles.size14_400,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount:
                                            AppConstantsList.months.length,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () async {
                                              leaderboardController
                                                      .selectedMonth.value =
                                                  AppConstantsList
                                                      .months[index];
                                              await leaderboardController
                                                  .fetchYourStat(
                                                      context, index + 01);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h,
                                                  horizontal: 15.w),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 8.h,
                                                    width: 8.h,
                                                    decoration: BoxDecoration(
                                                      border: leaderboardController
                                                                  .selectedMonth
                                                                  .value ==
                                                              AppConstantsList
                                                                  .months[index]
                                                          ? null
                                                          : Border.all(
                                                              width: 0.5.sp,
                                                              color: AppColors
                                                                  .black),
                                                      color: leaderboardController
                                                                  .selectedMonth
                                                                  .value ==
                                                              AppConstantsList
                                                                  .months[index]
                                                          ? AppColors.aqua
                                                          : AppColors
                                                              .transparent,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15.h,
                                                  ),
                                                  TextWidget(
                                                    AppConstantsList
                                                        .months[index]
                                                        .toString(),
                                                    styles:
                                                        TextStyles.size12_400,
                                                    color: AppColors.darkGrey,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.r),
                                  topRight: Radius.circular(15.r),
                                ),
                              ),
                              backgroundColor: AppColors.white);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: Get.width * 0.3,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.white,
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextWidget(
                                  leaderboardController.selectedMonth.value,
                                ),
                                Icon(
                                  Icons.expand_more_outlined,
                                  size: 25.sp,
                                  color: AppColors.black,
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "You have played a total ",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 17.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text:
                              "${leaderboardController.gamePlayed.value} quizes ",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 17.sp,
                              color: AppColors.purpleBlue,
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: "this month!",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 17.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ])),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: CircularPercentIndicator(
                            radius: Get.height * 0.2.r,
                            lineWidth: 10.0,
                            circularStrokeCap: CircularStrokeCap.round,
                            percent: (double.parse(leaderboardController
                                            .gamePlayed.value
                                            .toString()) /
                                        50.00) >
                                    1.0
                                ? 0.999
                                : double.parse(leaderboardController
                                        .gamePlayed.value
                                        .toString()) /
                                    50.00,
                            backgroundColor: Colors.white,
                            progressColor: AppColors.blue,
                            center: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: leaderboardController
                                          .gamePlayed.value,
                                      style: TextStyle(
                                          fontFamily: "Montserrat-Bold",
                                          fontSize: 28.sp,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    TextSpan(
                                      text: "/50",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 17.sp,
                                          color: AppColors.darkGrey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ])),
                                  TextWidget(
                                    "Quiz played",
                                    styles: TextStyles.size14_400,
                                    color: AppColors.darkGrey,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const RectangleBoxWidget(
                              icon: Icons.edit_outlined,
                              titleText: "Quiz Created",
                              color: AppColors.white,
                              intText: "5"),
                          RectangleBoxWidget(
                              icon: Icons.military_tech,
                              titleText: "Quiz won",
                              color: AppColors.purple,
                              intText: leaderboardController.quizWon.value
                                  .toString()),
                        ],
                      )
                    ],
                  )),
            );
          }),
    );
  }
}

class RectangleBoxWidget extends StatelessWidget {
  const RectangleBoxWidget(
      {Key? key,
      required this.titleText,
      required this.intText,
      required this.icon,
      required this.color})
      : super(key: key);
  final String titleText;
  final String intText;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width * 0.4,
        height: Get.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: color,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 15.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  intText,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 25.sp,
                      color: color == AppColors.white
                          ? AppColors.black
                          : AppColors.white,
                      fontWeight: FontWeight.w900),
                ),
                Icon(
                  icon,
                  color: color == AppColors.white
                      ? AppColors.black
                      : AppColors.white,
                  size: 30.sp,
                ),
              ],
            ),
            TextWidget(
              titleText,
              styles: TextStyles.size18_400,
              font: "Montserrat",
              color:
                  color == AppColors.white ? AppColors.black : AppColors.white,
            ),
          ],
        ));
  }
}
