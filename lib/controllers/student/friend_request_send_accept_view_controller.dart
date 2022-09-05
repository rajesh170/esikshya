import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/response/get_friend_list_response.dart';
import 'package:esikshya/utils/app_widgets.dart';

class FriendRequestSendAcceptViewController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();
  var temp = [].obs;
  var hasPerformedSearch = false.obs;
  var hasPerformedAcceptOrReject = true.obs;

  Future<List<GetFriendListResponse>?> getFriendList(
      BuildContext context) async {
    try {
      var _response = await _networkCalls.getFriendList();
      log(_response.toString());
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  sendFriendRequest(BuildContext context, int receiverId) async {
    try {
      AppWidgets.showLoading(context);
      var _response = await _networkCalls.sendFriendRequest(receiverId);
      if (_response["message"] == "friend request send successfully") {
        Navigator.pop(context);
        AppWidgets.showSnackBar(context, "friend request send successfully");
      } else {
        AppWidgets.showSnackBar(context, "Unexpected Error");
      }
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  var parameters = "".obs;
  var isLoading = false.obs;
  var receiverId = 0.obs;
  searchFriends(String searchValue, BuildContext context) async {
    try {
      isLoading.value = true;
      temp.value = [];
      var _response = await _networkCalls.searchFriends(searchValue);
      temp.value = _response;
      isLoading.value = false;
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  acceptFriendRequest(
      BuildContext context, int senderID, int notificationId) async {
    try {
      var _response =
          await _networkCalls.acceptFriendRequest(senderID, notificationId);
      if (_response["message"] == "friends request accepted successfully") {
        hasPerformedAcceptOrReject.value = !hasPerformedAcceptOrReject.value;
      } else {
        hasPerformedAcceptOrReject.value = !hasPerformedAcceptOrReject.value;
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  changeStateForNotificationScreen() {
    hasPerformedAcceptOrReject.value = false;
    hasPerformedAcceptOrReject.value = true;
  }

  rejectFriendRequest(
      BuildContext context, int senderID, int notificationId) async {
    try {
      var _response =
          await _networkCalls.rejectFriendRequest(senderID, notificationId);
      if (_response["message"] == "friends request accepted successfully") {
        changeStateForNotificationScreen();
      } else {
        changeStateForNotificationScreen();
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
