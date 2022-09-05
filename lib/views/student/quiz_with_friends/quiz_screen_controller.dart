import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/quiz_request/quiz_searching_opponent_request.dart';
import 'package:esikshya/models/network_models/response/error_response.dart';
import 'package:esikshya/models/quiz_models/correct_answer_response.dart';
import 'package:esikshya/models/quiz_models/final_result_model.dart';
import 'package:esikshya/models/quiz_models/opponent_connected_response.dart';
import 'package:esikshya/models/quiz_models/question_model.dart';
import 'package:esikshya/models/quiz_models/wrong_answer_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/views/student/quiz/show_results/quiz_show_results_screen.dart';
import 'package:web_socket_channel/io.dart';

class QuizScreenController extends GetxController {
  late IOWebSocketChannel myChannel;
  var isWebSocketRunning = false.obs;
  int retryLimit = 3;
  var stopSearchingAnimation = false.obs;
  var yourScore = "0".obs;
  var opponentScore = "0".obs;
  var forQuestionModel = [].obs;
  var forWrongAnswer = [].obs;
  var forCorrectAnswer = [].obs;
  var forFinalResponse = [].obs;
  var forErrorResponse = [].obs;
  var correctAnswer = "".obs;
  var choosenOption = "".obs;
  var optionAcontainerColor = AppColors.white.obs;
  var optionBcontainerColor = AppColors.white.obs;
  var optionCcontainerColor = AppColors.white.obs;
  var optionDcontainerColor = AppColors.white.obs;
  var containerColor = AppColors.white.obs;
  var selectedContainerColor = AppColors.white.obs;
  var correctAnswerContainerColor = AppColors.white.obs;
  var isStreamDisconnected = false.obs;
  var showReadyToRumble = true.obs;
  var decodedData;
  var readyTime = 5.obs;
  var quizPercent = 0.0.obs;
  var quizTimer = 0.obs;
  var isNextQuestionFired = false.obs;
  var isOptionTapped = false.obs;
  var showCorrectOption = false.obs;
  var yourName = "".obs;
  var opponentName = "".obs;
  var friendLobbyRemoved = false.obs;

////------- Setting Datas from the channel to local variables ---//////////////////////
  void _setData({
    QuestionModelResponse? questionModel,
    FinalResultResponse? finalResultResponse,
    WrongAnswerResponse? wrongAnswerResponse,
    CorrectAnswerResponse? correctAnswerResponse,
    ErrorResponse? errorResponse,
    OpponentConnectedResponse? opponentConnectedResponse,
  }) async {
    if (errorResponse != null) {
      forErrorResponse.clear();
      forErrorResponse.add(errorResponse);
      log(forErrorResponse[0].message.toString());
    }
    if (opponentConnectedResponse != null) {
      yourName.value = opponentConnectedResponse.ownName.toString();
      opponentName.value = opponentConnectedResponse.opName.toString();
      // });
    }
    if (questionModel != null) {
      forQuestionModel.clear();
      forQuestionModel.add(questionModel);
      log(forQuestionModel[0].questions.toString());
      // Future.delayed(const Duration(seconds: 3), () {
      isNextQuestionFired.value = true;
      showReadyToRumble.value = false;
      // });
    }
    if (finalResultResponse != null) {
      forFinalResponse.clear();
      forFinalResponse.add(finalResultResponse);
    }
    if (wrongAnswerResponse != null) {
      forWrongAnswer.clear();
      forWrongAnswer.add(wrongAnswerResponse);
      log(forWrongAnswer[0].correctAnswer.toString());
      yourScore.value = forWrongAnswer[0].score.toString();
      opponentScore.value = forWrongAnswer[0].oscore.toString();
    }
    if (correctAnswerResponse != null) {
      forCorrectAnswer.clear();
      forCorrectAnswer.add(correctAnswerResponse);
      log(forCorrectAnswer[0].message.toString());
      yourScore.value = forCorrectAnswer[0].score.toString();
      opponentScore.value = forCorrectAnswer[0].oscore.toString();
    }
  }

//----- Connecting Web Sockets ----////
  void startStream(bool isWithRandom, QuizSearchOpponentRequest initialRequest,
      {AnimationController? searchingAnimationController,
      int? opId,
      String? subjectName,
      String? childAccessToken,
      int? grade}) async {
    if (isWebSocketRunning.value) {
      return;
    }
    var childAccessToken =
        await Get.find<AppSharedPreferences>().getChildAccessToken();
    String url = isWithRandom
        ? 'wss://edtech.mahajodi.io/game/withrandom'
        : 'wss://edtech.mahajodi.io/game/withfriends';
    log(url);
    myChannel = IOWebSocketChannel.connect(Uri.parse(url), headers: {
      "Authorization": "Bearer $childAccessToken",
    });

    if (isWithRandom) {
      // log({"subject": initialRequest.subject}.toString());
      sendData({"subject": initialRequest.subject});
    } else {
      // log(initialRequest.toJson().toString());
      sendData(initialRequest.toJson());
    }

    log("Stream suru vayo");
    // isWebSocketRunning.value = true;

    myChannel.stream.listen((event) {
      log([jsonDecode(event)].toString());
      decodedData = json.decode(event);
      if (decodedData["type"] == "connected") {
        stopSearchingAnimation.value = true;
        searchingAnimationController?.reset();
        searchingAnimationController?.stop();

        OpponentConnectedResponse ocr =
            OpponentConnectedResponse.fromJson(decodedData);
        _setData(opponentConnectedResponse: ocr);
      }
      if (decodedData["type"] == "WrongAnswer") {
        WrongAnswerResponse war = WrongAnswerResponse.fromJson(decodedData);
        _setData(
          wrongAnswerResponse: war,
        );
      }
      if (decodedData["type"] == "questions") {
        QuestionModelResponse qm = QuestionModelResponse.fromJson(decodedData);
        _setData(
          questionModel: qm,
        );
      }
      if (decodedData["type"] == "CorrectAnswer") {
        CorrectAnswerResponse car = CorrectAnswerResponse.fromJson(decodedData);
        _setData(
          correctAnswerResponse: car,
        );
      }
      if (decodedData["type"] == "gameCompleted") {
        FinalResultResponse frr = FinalResultResponse.fromJson(decodedData);
        _setData(
          finalResultResponse: frr,
        );
      }
    }, onDone: () {
      log("Done");
      isWebSocketRunning.value = false;
      isStreamDisconnected.value = true;

      if (decodedData != null) {
        if (decodedData["type"] == "error") {
          log("Error Couldnot find game lobby");
        }
      }
      if (forFinalResponse.isNotEmpty) {
        //do something here if you want something to perform after stream is closed
        Get.off(() => QuizShowResultScreen(
              yourName: yourName.value,
              opponentName: opponentName.value,
              yourScore: yourScore.value,
              opponentScore: opponentScore.value,
              opponentId: opId,
              childAccessToken: childAccessToken!,
              subjectName: subjectName!,
              hasWon:
                  int.parse(yourScore.value) > int.parse(opponentScore.value),
              grade: grade!,
              isWithRandom: isWithRandom,
            ));
      }
    }, onError: (err) {
      isWebSocketRunning.value = false;
      print("Om Error");
      // if (retryLimit > 0) {
      //   retryLimit--;
      //   startStream(isWithRandom, initialRequest,
      //       searchingAnimationController: searchingAnimationController);
      // }
    });
  }

  sendData(Map data) {
    log(data.toString());
    myChannel.sink.add(jsonEncode(data));
  }

  void sendOptions(String choosenAnswer,
      {Function()? reStartAnimation, bool? isFromOnTap}) async {
    choosenOption.value = choosenAnswer;
    var userAnswer = {"correct_answer": choosenAnswer};
    var dataToSend = json.encode(userAnswer);
    log(dataToSend.toString());
    myChannel.sink.add(dataToSend);
    selectedContainerColor.value = AppColors.white;
    isNextQuestionFired.value = false;
    isOptionTapped.value = false;
    choosenOption.value = "";
    showCorrectOption.value = true;
    reStartAnimation;
  }

  void closeMyStream() {
    //disposes of the stream
    myChannel.sink.close();
    isWebSocketRunning.value = false;
    yourScore.value = "";
    opponentScore.value = "";
  }

  final NetworkCalls _networkCalls = NetworkCalls();
  removeLobby(int opponentId) async {
    try {
      var _response = await _networkCalls.removeLobby(opponentId);
      if (_response != null) {
        friendLobbyRemoved.value = true;
      }
      if (_response == "we couldnot found  lobby") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  removeRandomLobby() async {
    try {
      await _networkCalls.removeLobbyRandom();
      // await _networkCalls.makeOffline();
    } catch (e) {
      print(e.toString());
    }
  }

  fiveSecondTimer() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (readyTime.value == 0) {
        timer.cancel();
      } else {
        readyTime.value--;
      }
    });
  }
}
