import 'dart:io';

import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketController extends GetxController {
  NetworkCalls _networkCalls = NetworkCalls();
  connectWithWebSocket() async {
    var token = await Get.find<AppSharedPreferences>().getChildAccessToken();
    var channel = IOWebSocketChannel.connect(
      Uri.parse('edtech.mahajodi.io/game/withfriends'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
  }

  removeLobby(int opponentId) async {
    try {
      var _response = await _networkCalls.removeLobby(opponentId);
      print(_response);
      if (_response == "we couldnot found  lobby") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
