import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/quiz_with_friends/quiz_screen_controller.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class BuildQuizTimer extends StatefulWidget {
  const BuildQuizTimer(
      {Key? key,
      required this.quizScreenController,
      required this.reStartAnimation,
      required this.countDownController})
      : super(key: key);
  final QuizScreenController quizScreenController;
  final CountdownController countDownController;
  final Function()? reStartAnimation;

  @override
  State<BuildQuizTimer> createState() => _BuildQuizTimerState();
}

class _BuildQuizTimerState extends State<BuildQuizTimer> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.quizScreenController.showReadyToRumble.value
                ? TextWidget(
                    "Starts in",
                    styles: TextStyles.size16_600,
                    color: AppColors.white,
                  )
                : const SizedBox(),
            SizedBox(height: 5.h),
            widget.quizScreenController.showReadyToRumble.value
                ? Countdown(
                    // controller: widget.countDownController,
                    seconds: 5,
                    build: (context, double time) {
                      return TextWidget(
                        time.toStringAsFixed(0),
                        styles: TextStyles.size16_600,
                        color: AppColors.white,
                      );
                    },
                    onFinished: () {})
                // TextWidget(
                //     widget.quizScreenController.readyTime.value.toString(),
                //     // "5",
                //     styles: TextStyles.size16_600,
                //     color: AppColors.white,
                //   )
                : CircularPercentIndicator(
                    radius: 40.r,
                    lineWidth: 15.0,
                    percent: widget.quizScreenController.quizPercent.value,
                    center: CircleAvatar(
                        radius: 40.r,
                        backgroundColor: AppColors.darkBlue,
                        child: Countdown(
                            controller: widget.countDownController,
                            seconds: 12,
                            build: (context, double time) {
                              return Text(time.toStringAsFixed(0));
                            },
                            onFinished: () {
                              if (widget.quizScreenController
                                  .isNextQuestionFired.value) {
                                widget.quizScreenController.sendOptions(
                                  widget.quizScreenController.choosenOption
                                              .value ==
                                          ""
                                      ? "no answer"
                                      : widget.quizScreenController
                                          .choosenOption.value,
                                  reStartAnimation: widget.reStartAnimation!(),
                                );
                                widget.quizScreenController.isOptionTapped
                                    .value = false;
                                widget.countDownController.restart();
                              } else {}
                            })),
                    backgroundColor: Colors.transparent,
                    progressColor: AppColors.purpleBlue,
                  ),
          ],
        );
      },
    );
  }
}
