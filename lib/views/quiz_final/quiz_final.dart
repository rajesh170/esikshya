import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:esikshya/models/network_models/request/quiz_request/quiz_searching_opponent_request.dart';
import 'package:esikshya/models/network_models/response/notification_screen_response.dart';
import 'package:esikshya/models/quiz_models/correct_answer_response.dart';
import 'package:esikshya/models/quiz_models/final_result_model.dart';
import 'package:esikshya/models/quiz_models/question_model.dart';
import 'package:esikshya/models/quiz_models/wrong_answer_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/quiz_final/web_socket_controller.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter/material.dart';

class QuizFinalScreen extends StatefulWidget {
  const QuizFinalScreen({
    Key? key,
    required this.title,
    required this.childAccessToken,
    this.notificationResponse,
    required this.opponentId,
    required this.subjectName,
    required this.grade,
    required this.connectivityStatus,
    this.isFromNotificationScreen,
  }) : super(key: key);

  final String title;
  final String childAccessToken;
  final NotificationResponse? notificationResponse;
  final int opponentId;
  final String subjectName;
  final int grade;
  final bool? isFromNotificationScreen;
  final String connectivityStatus;

  @override
  _QuizFinalScreenState createState() => _QuizFinalScreenState();
}

class _QuizFinalScreenState extends State<QuizFinalScreen> {
  final TextEditingController _controller = TextEditingController();
  late IOWebSocketChannel _channel;

  final WebSocketController _webSocketController =
      Get.put(WebSocketController());

  @override
  void initState() {
    super.initState();
    if (widget.isFromNotificationScreen != true) {
      _webSocketController.removeLobby(widget.opponentId);
    }

    _channel = IOWebSocketChannel.connect(
        Uri.parse('wss://edtech.mahajodi.io/game/withfriends'),
        // headers: {
        //   'Content-Type': 'application/json; charset=UTF-8',
        //   HttpHeaders.authorizationHeader: "Bearer ${widget.childAccessToken}"
        // },
        headers: {
          "Authorization": "Bearer ${widget.childAccessToken}",
        });

    log(_channel.innerWebSocket.toString());
    QuizSearchOpponentRequest req = QuizSearchOpponentRequest(
      oponentId: widget.opponentId,
      subject: widget.subjectName,
      status: widget.connectivityStatus,
      grade: widget.grade,
    );
    var toSendData = (jsonEncode(req.toJson()));
    print(toSendData);
    _channel.sink.add(toSendData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return TextWidget("Connection lost");
                }

                if (snapshot.hasData) {
                  var decodedData = jsonDecode(snapshot.data);

                  if (decodedData["connection_status"] == "Connected") {
                    return TextWidget("Connected");
                  }
                  if (decodedData["id"] != null) {
                    return TextWidget("Id: " + decodedData["id"].toString());
                  }
                  if (decodedData["message"] == "wrong") {
                    return TextWidget(
                        "Message: " + decodedData["message"].toString());
                  }
                  if (decodedData["message"] == "correct") {
                    return TextWidget(
                        "Message: " + decodedData["message"].toString());
                  } else {
                    return Text(snapshot.data.toString());
                  }
                } else {
                  return TextWidget(
                    snapshot.connectionState.toString(),
                    color: AppColors.red,
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      var answer = {
        "correct_answer": _controller.text,
      };
      var toSendData = (jsonEncode(answer));
      // var toSendData = (jsonEncode(req));
      print(toSendData);
      _channel.sink.add(toSendData);
    } else {
      // QuizSearchOpponentRequest req = QuizSearchOpponentRequest(
      //   oponentId: widget.opponentId,
      //   subject: widget.subjectName,
      //   status: widget.connectivityStatus,
      //   grade: widget.grade,
      // );
      // var toSendData = (jsonEncode(req.toJson()));
      // print(toSendData);
      // _channel.sink.add(toSendData);
    }
  }

  @override
  void dispose() {
    log("Connection Closed");
    log(status.goingAway.toString());
    _channel.sink.close();
    super.dispose();
  }
}
