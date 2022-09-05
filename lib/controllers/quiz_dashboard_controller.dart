import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/utils/app_widgets.dart';

class QuizDashboardController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();
  var friendTapped = false.obs;
  var subjectTapped = false.obs;
  var selectedSubject = [].obs;
  var selectedFriendId = [].obs;

  removeLobby(BuildContext context, int opponentId) async {
    try {
      var _response = await _networkCalls.removeLobby(opponentId);
      if (_response == "we couldnot found  lobby") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
