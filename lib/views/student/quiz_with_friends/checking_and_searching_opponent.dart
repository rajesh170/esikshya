import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'dart:math' as math;

import 'package:esikshya/views/student/quiz_with_friends/quiz_screen_controller.dart';

class CheckingAndSearchingOpponentScreen extends StatefulWidget {
  const CheckingAndSearchingOpponentScreen(
      {Key? key,
      required this.searchingAnimationController,
      required this.quizScreenController,
      required this.onOpponentFoundAnimationController})
      : super(key: key);
  final AnimationController searchingAnimationController;
  final AnimationController onOpponentFoundAnimationController;
  final QuizScreenController quizScreenController;

  @override
  _CheckingAndSearchingOpponentScreenState createState() =>
      _CheckingAndSearchingOpponentScreenState();
}

class _CheckingAndSearchingOpponentScreenState
    extends State<CheckingAndSearchingOpponentScreen> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.quizScreenController.stopSearchingAnimation.value
          ? const SizedBox()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10.w),
                  color: AppColors.transparent,
                  child: CircleAvatar(
                    radius: 150.r,
                    backgroundColor: AppColors.transparent,
                    child: AnimatedBuilder(
                      animation: widget.searchingAnimationController,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 120.r,
                                  backgroundColor: AppColors.transparent,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color:
                                                AppColors.blue.withOpacity(0.7),
                                            width: 5.w,
                                          ))),
                                )
                                // CircleAvatar(
                                //   radius: 120.r,
                                //   backgroundColor: AppColors.blue,
                                //   child: CircleAvatar(
                                //     radius: 115.r,
                                //     backgroundColor:
                                //         AppColors.darkThemeBackground,
                                //   ),
                                // ),
                                ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                  radius: 40.r,
                                  backgroundColor: AppColors.red,
                                  backgroundImage: const AssetImage(
                                      "assets/images/sardar.png")),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  radius: 40.r,
                                  backgroundColor: AppColors.darkBlue,
                                  backgroundImage: const AssetImage(
                                      "assets/images/sardar.png"),
                                )),
                            // opponentFound
                            //     ? TweenAnimationBuilder(
                            //         curve: Curves.bounceOut,
                            //         tween: Tween<double>(begin: 0, end: 1),
                            //         duration: const Duration(seconds: 2),
                            //         builder: (context, double value, child) {
                            //           return Transform.scale(
                            //             scale: value,
                            //             child: child,
                            //           );
                            //         },
                            //         child: Align(
                            //           alignment: Alignment.center,
                            //           child: TextWidget(
                            //             "VS",
                            //             styles: TextStyles.size20_600,
                            //             color: AppColors.white,
                            //           ),
                            //         ),
                            //       )
                            //     : const SizedBox()
                          ],
                        ),
                      ),
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: widget.searchingAnimationController.value *
                              2 *
                              math.pi,
                          child: child,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
