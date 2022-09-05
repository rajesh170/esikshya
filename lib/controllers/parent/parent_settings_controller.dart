import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/utils/app_widgets.dart';

class UserSettingsController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();
  removeParentFcmTokenFromServer(BuildContext context) async {
    try {
      var _response = await _networkCalls.removeParentFcmTokenFromServer();
      if (_response["message"] == "token removed successfully") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  removeChildFcmTokenFromServer(BuildContext context) async {
    try {
      var _response = await _networkCalls.removeChildFcmTokenFromServer();
      if (_response["message"] == "token removed successfully") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
