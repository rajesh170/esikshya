import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/utils/app_widgets.dart';

class NotificationScreenController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();
  var fecthNotification = true.obs;
  changeState() {
    print('I am called');
    fecthNotification.value = false;
    fecthNotification.value = true;
    return true;
  }

  getChildNotification(BuildContext context) {
    try {
      var _response = _networkCalls.getChildNotification();
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  getChildGameNotification(BuildContext context) {
    try {
      var _response = _networkCalls.getChildGameNotification();
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  removeChildGameNotification(BuildContext context, int? notificationId) async {
    try {
      var _response =
          await _networkCalls.removeChildGameNotification(notificationId!);
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
