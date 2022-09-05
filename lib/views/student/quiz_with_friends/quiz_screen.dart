import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/models/network_models/request/quiz_request/quiz_searching_opponent_request.dart';
import 'package:esikshya/models/network_models/response/notification_screen_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/quiz_with_friends/checking_and_searching_opponent.dart';
import 'package:esikshya/views/student/quiz_with_friends/option_widget.dart';
import 'package:esikshya/views/student/quiz_with_friends/quiz_screen_controller.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:lottie/lottie.dart';
import 'build_quiz_timer.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key? key,
    required this.title,
    required this.childAccessToken,
    this.notificationResponse,
    this.opponentId,
    required this.subjectName,
    required this.grade,
    this.isFromNotificationScreen,
    this.connectivityStatus,
    required this.isWithRandom,
  }) : super(key: key);
  final String title;
  final String childAccessToken;
  final NotificationResponse? notificationResponse;
  final int? opponentId;
  final String subjectName;
  final int grade;
  final bool? isFromNotificationScreen;
  final String? connectivityStatus;
  final bool isWithRandom;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  final QuizScreenController _quizController = Get.put(QuizScreenController());
  late AnimationController _controller;
  late AnimationController _finalAnimation;
  late AnimationController _onOpponentFoundAnimationController;
  late AnimationController _searchingAnimationController;

  @override
  void initState() {
    //if isFromNotificationScreen is true then we must remove the lobby first
    if (widget.isFromNotificationScreen == true &&
        widget.isWithRandom == false) {
      _quizController.removeLobby(widget.opponentId!);
    }

    //removing lobby for random
    if (widget.isWithRandom) {
      _quizController.removeRandomLobby();
    }
    //this is initial request to be sent for the first time if playing with friends
    QuizSearchOpponentRequest req = widget.isWithRandom
        ? QuizSearchOpponentRequest(subject: widget.subjectName)
        : QuizSearchOpponentRequest(
            oponentId: widget.opponentId,
            subject: widget.subjectName,
            status: widget.connectivityStatus,
            grade: widget.grade,
          );
    _searchingAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _quizController.startStream(
      widget.isWithRandom,
      req,
      searchingAnimationController: _searchingAnimationController,
      grade: widget.grade,
      childAccessToken: widget.childAccessToken,
      opId: widget.opponentId,
      subjectName: widget.subjectName,
    );
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
    _finalAnimation = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _onOpponentFoundAnimationController = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    )..repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _quizController.closeMyStream();
    _controller.dispose();
    _finalAnimation.dispose();
    _onOpponentFoundAnimationController.dispose();
    _searchingAnimationController.dispose();
    super.dispose();
  }

  final CountdownController _countdownController =
      CountdownController(autoStart: true);
  reStartAnimation() {
    if (_controller.isCompleted) {
      _controller.value = 0.0;
      _controller = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      )..forward();
      _controller.forward();
      _quizController.optionAcontainerColor.value = AppColors.white;
      // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      //   // _countdownController.setOnStart(() { })
      //   _countdownController.restart();
      // });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackground,
      body: WillPopScope(
        onWillPop: () async {
          Get.defaultDialog(
              middleText: "Are You Sure you want to quit?",
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Text("No"),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.back();
                      },
                      child: Text("yes"),
                    ),
                  ],
                )
              ]);
          return true;
        },
        child: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    opacity: 0.5,
                    image:
                        AssetImage("assets/images/quiz_ques_background.png"))),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
            child: Obx(
              () => Column(
                children: [
                  CheckingAndSearchingOpponentScreen(
                    searchingAnimationController: _searchingAnimationController,
                    quizScreenController: _quizController,
                    onOpponentFoundAnimationController:
                        _onOpponentFoundAnimationController,
                  ),
                  _quizController.stopSearchingAnimation.value
                      ? SizedBox(
                          width: Get.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: CircleAvatar(
                                        radius: 25.r,
                                        backgroundColor: AppColors.blue,
                                        backgroundImage: const AssetImage(
                                            "assets/images/sardar.png"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Obx(() => SizedBox(
                                          width: Get.width * 0.2,
                                          child: Column(
                                            children: [
                                              TextWidget(
                                                _quizController.yourName.value,
                                                styles: TextStyles.size18_600,
                                                color: AppColors.white,
                                              ),
                                              TextWidget(
                                                _quizController.yourScore.value
                                                    .toString(),

                                                // _quizController.forCorrectAnswer.isEmpty
                                                //     ? "0"
                                                //     : _quizController
                                                //         .forCorrectAnswer[0].score
                                                //         .toString(),
                                                styles: TextStyles.size18_600,
                                                color: AppColors.white,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                                BuildQuizTimer(
                                  quizScreenController: _quizController,
                                  reStartAnimation: reStartAnimation,
                                  countDownController: _countdownController,
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: CircleAvatar(
                                        radius: 25.r,
                                        backgroundColor: AppColors.red,
                                        backgroundImage: const AssetImage(
                                            "assets/images/sardar.png"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Obx(() => SizedBox(
                                          width: Get.width * 0.2,
                                          child: Column(
                                            children: [
                                              TextWidget(
                                                _quizController
                                                    .opponentName.value,
                                                // _quizController.forCorrectAnswer.isEmpty
                                                //     ? "0"
                                                //     : _quizController
                                                //         .forWrongAnswer[0].oscore
                                                //         .toString(),
                                                styles: TextStyles.size18_600,
                                                color: AppColors.white,
                                                maxLines: 2,
                                              ),
                                              TextWidget(
                                                _quizController
                                                    .opponentScore.value
                                                    .toString(),
                                                // _quizController.forCorrectAnswer.isEmpty
                                                //     ? "0"
                                                //     : _quizController
                                                //         .forWrongAnswer[0].oscore
                                                //         .toString(),
                                                styles: TextStyles.size18_600,
                                                color: AppColors.white,
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ]),
                        )
                      : TextWidget(
                          "Awaiting Opponent",
                          styles: TextStyles.size15_600,
                          color: AppColors.white,
                        ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Obx(
                    () => _quizController.isStreamDisconnected.value
                        ? const SizedBox()
                        : _quizController.forQuestionModel.isEmpty
                            ? const SizedBox()
                            : Column(
                                children: [
                                  SlideTransition(
                                    position: _controller.drive(
                                      Tween<Offset>(
                                          begin: const Offset(-1.5, 0),
                                          end: const Offset(0, 0)),
                                    ),
                                    child: TextWidget(
                                      _quizController
                                                  .forQuestionModel[0].questions
                                                  .toString() ==
                                              "null"
                                          ? ""
                                          : _quizController
                                              .forQuestionModel[0].questions
                                              .toString(),
                                      styles: TextStyles.size24_600,
                                      color: AppColors.white,
                                      maxLines: 5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SlideTransition(
                                    position: _controller.drive(
                                      Tween<Offset>(
                                          begin: const Offset(1.5, 0),
                                          end: const Offset(0, 0)),
                                    ),
                                    child: ShowOptions(
                                      channel: _quizController.myChannel,
                                      questionModel:
                                          _quizController.forQuestionModel[0],
                                      reStartAnimation: reStartAnimation,
                                      myExampleController: _quizController,
                                    ),
                                  ),
                                ],
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


 // Obx(
                  //   () => _quizController.isStreamDisconnected.value
                  //       ? SlideTransition(
                  //           position: _finalAnimation.drive(
                  //             Tween<Offset>(
                  //               begin: const Offset(1.5, 0),
                  //               end: const Offset(-1.5, 0),
                  //             ),
                  //           ),
                  //           child: TextWidget(
                  //             "Game Over!!",
                  //             color: AppColors.white,
                  //             styles: TextStyles.size18_600,
                  //           ),
                  //         )
                  //       : const SizedBox(),
                  // ),
                  // Obx(
                  //   () => _quizController.isStreamDisconnected.value &&
                  //           _quizController.forFinalResponse.isNotEmpty
                  //       ? Column(
                  //           children: [
                  //             int.parse(_quizController
                  //                         .forFinalResponse[0].score
                  //                         .toString()) >
                  //                     int.parse(_quizController
                  //                         .forFinalResponse[0].oscore
                  //                         .toString())
                  //                 ? Center(
                  //                     child: Lottie.asset(
                  //                       'assets/lottie_files/happy.json',
                  //                       repeat: true,
                  //                       frameRate: FrameRate.max,
                  //                       height: Get.height * 0.2,
                  //                       // width: Get.width * 0.15,
                  //                       fit: BoxFit.cover,
                  //                       reverse: false,
                  //                     ),
                  //                   )
                  //                 : Center(
                  //                     child: Lottie.asset(
                  //                       'assets/lottie_files/sad.json',
                  //                       repeat: true,
                  //                       frameRate: FrameRate.max,
                  //                       height: Get.height * 0.2,
                  //                       // width: Get.width * 0.15,
                  //                       fit: BoxFit.cover,
                  //                       reverse: false,
                  //                     ),
                  //                   ),
                  //             TextWidget(
                  //               _quizController.forFinalResponse[0].message
                  //                   .toString(),
                  //               color: AppColors.white,
                  //               styles: TextStyles.size18_600,
                  //             ),
                  //           ],
                  //         )
                  //       : const SizedBox(),
                  // ),