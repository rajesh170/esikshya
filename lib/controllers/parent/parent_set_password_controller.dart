import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/parent_login_request.dart';
import 'package:esikshya/models/network_models/request/parent_set_password_request.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/views/common/bottom_nav_bar_screen.dart';
import 'package:esikshya/views/parent/parent_dashboard/parent_ask_name_screen.dart';

class ParentSetPasswordController extends GetxController {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController fullName = TextEditingController();

  var noOfChildren = 0.obs;
  var showEyeButton = false.obs;
  var isObscure = true.obs;
  final NetworkCalls _networkCalls = NetworkCalls();
  final _sharedPref = Get.find<AppSharedPreferences>();

  parentSetPassword(BuildContext context, String phoneNumber) async {
    try {
      AppWidgets.showLoading(context);
      var parentSetPasswordRequest = ParentSetPasswordRequest(
        phone: phoneNumber,
        password: confirmPassword.text,
      );
      var _response =
          await _networkCalls.setPasswordParents(parentSetPasswordRequest);
      if (_response["message"] == "password set successfully") {
        ParentLoginRequest loginRequest = ParentLoginRequest(
            phone: phoneNumber, password: confirmPassword.text);
        var _response = await _networkCalls.parentLogin(loginRequest);
        await _sharedPref.saveParentDetails(_response);
        var _fcmToken = await _sharedPref.getFCMToken();
        await _networkCalls.sendParentFCMToken(_fcmToken.toString());
        Get.to(() => const ParentAskNameScreen());
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  saveParentName(BuildContext context, String name) async {
    try {
      AppWidgets.showLoading(context);
      var _response = await _networkCalls.saveParentName(name);
      if (_response['message'] == "parents details added successfully") {
        Navigator.pop(context);
        await _sharedPref.saveParentName(name);
        await _sharedPref.setUserWelcomed();
        // Get.offAll(() => ParentDashBoard(
        //       name: name,
        //     ));
        Get.offAll(() => const BottomNavBarScreen(
              isUserChild: false,
            ));
      } else {
        AppWidgets.showSnackBar(context, "Unexpected Error! Please try again.");
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
}
