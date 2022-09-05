import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/models/quiz_models/question_model.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/quiz_with_friends/quiz_screen_controller.dart';
import 'package:web_socket_channel/io.dart';

class ShowOptions extends StatelessWidget {
  const ShowOptions({
    Key? key,
    required this.questionModel,
    required this.channel,
    this.reStartAnimation,
    required this.myExampleController,
  }) : super(key: key);

  final QuestionModelResponse questionModel;
  final IOWebSocketChannel channel;
  final Function()? reStartAnimation;
  final QuizScreenController myExampleController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (myExampleController.isOptionTapped.value) {
            } else {
              myExampleController.selectedContainerColor.value =
                  AppColors.darkBlue;
              myExampleController.choosenOption.value = "a";
              myExampleController.isOptionTapped.value = true;
              if (myExampleController.forQuestionModel.isNotEmpty) {
                if (myExampleController.forQuestionModel[0].correct
                        .toString() ==
                    "a") {
                  myExampleController.selectedContainerColor.value =
                      AppColors.lightGreen;
                } else {
                  myExampleController.selectedContainerColor.value =
                      AppColors.red;
                }
              }
            }
          },
          child: Obx(
            () => BuildOptionWidget(
                containerColor: myExampleController.choosenOption.value == "a"
                    ? myExampleController.selectedContainerColor.value
                    : (myExampleController.forQuestionModel[0].correct
                                    .toString() ==
                                "a" &&
                            myExampleController.isOptionTapped.value)
                        ? AppColors.lightGreen
                        : AppColors.white,
                optionsFromQuestionModel: questionModel.optionsA.toString()),
          ),
        ),
        InkWell(
          onTap: () {
            if (myExampleController.isOptionTapped.value) {
            } else {
              myExampleController.selectedContainerColor.value =
                  AppColors.darkBlue;

              myExampleController.choosenOption.value = "b";
              myExampleController.isOptionTapped.value = true;

              if (myExampleController.forQuestionModel.isNotEmpty) {
                if (myExampleController.forQuestionModel[0].correct
                        .toString() ==
                    "b") {
                  myExampleController.selectedContainerColor.value =
                      AppColors.lightGreen;
                } else {
                  myExampleController.selectedContainerColor.value =
                      AppColors.red;
                }
              }
            }
          },
          child: Obx(
            () => BuildOptionWidget(
                containerColor: myExampleController.choosenOption.value == "b"
                    ? myExampleController.selectedContainerColor.value
                    : (myExampleController.forQuestionModel[0].correct
                                    .toString() ==
                                "b" &&
                            myExampleController.isOptionTapped.value)
                        ? AppColors.lightGreen
                        : AppColors.white,
                optionsFromQuestionModel: questionModel.optionsB.toString()),
          ),
        ),
        InkWell(
          onTap: () {
            if (myExampleController.isOptionTapped.value) {
            } else {
              myExampleController.selectedContainerColor.value =
                  AppColors.darkBlue;
              myExampleController.choosenOption.value = "c";
              myExampleController.isOptionTapped.value = true;

              if (myExampleController.forQuestionModel.isNotEmpty) {
                if (myExampleController.forQuestionModel[0].correct
                        .toString() ==
                    "c") {
                  myExampleController.selectedContainerColor.value =
                      AppColors.lightGreen;
                  // myExampleController.correctAnswerContainerColor.value =
                  //     AppColors.lightGreen;
                } else {
                  myExampleController.selectedContainerColor.value =
                      AppColors.red;
                }
              }
            }
          },
          child: Obx(
            () => BuildOptionWidget(
                containerColor: myExampleController.choosenOption.value == "c"
                    ? myExampleController.selectedContainerColor.value
                    : (myExampleController.forQuestionModel[0].correct
                                    .toString() ==
                                "c" &&
                            myExampleController.isOptionTapped.value)
                        ? AppColors.lightGreen
                        : AppColors.white,
                optionsFromQuestionModel: questionModel.optionsC.toString()),
          ),
        ),
        InkWell(
          onTap: () {
            if (myExampleController.isOptionTapped.value) {
            } else {
              myExampleController.selectedContainerColor.value =
                  AppColors.darkBlue;
              myExampleController.choosenOption.value = "d";
              myExampleController.isOptionTapped.value = true;
              if (myExampleController.forQuestionModel.isNotEmpty) {
                if (myExampleController.forQuestionModel[0].correct
                        .toString() ==
                    "d") {
                  myExampleController.selectedContainerColor.value =
                      AppColors.lightGreen;
                } else {
                  myExampleController.selectedContainerColor.value =
                      AppColors.red;
                }
              }
            }
          },
          child: Obx(
            () => BuildOptionWidget(
                containerColor: myExampleController.choosenOption.value == "d"
                    ? myExampleController.selectedContainerColor.value
                    : (myExampleController.forQuestionModel[0].correct
                                    .toString() ==
                                "d" &&
                            myExampleController.isOptionTapped.value)
                        ? AppColors.lightGreen
                        : AppColors.white,
                optionsFromQuestionModel: questionModel.optionsD.toString()),
          ),
        ),
      ],
    );
  }
}

class BuildOptionWidget extends StatelessWidget {
  const BuildOptionWidget({
    Key? key,
    required this.optionsFromQuestionModel,
    required this.containerColor,
  }) : super(key: key);

  final String optionsFromQuestionModel;
  final Color containerColor;
  @override
  Widget build(BuildContext context) {
    QuizScreenController _myExampleController = Get.put(QuizScreenController());

    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: containerColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Center(
        child: TextWidget(
          optionsFromQuestionModel,
          styles: TextStyles.size16_400,
          color: containerColor == AppColors.white
              ? AppColors.black
              : AppColors.white,
          maxLines: 5,
        ),
      ),
    );
  }
}
