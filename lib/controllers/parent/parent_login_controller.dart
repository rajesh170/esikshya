import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/parent_login_request.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/views/common/bottom_nav_bar_screen.dart';
import 'package:esikshya/views/parent/parent_dashboard/parent_ask_name_screen.dart';

class ParentLoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final NetworkCalls _networkCalls = NetworkCalls();
  final _sharePref = Get.find<AppSharedPreferences>();

  parentLogin(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      ParentLoginRequest parentLoginRequest = ParentLoginRequest(
          phone: phoneController.text, password: passwordController.text);
      var _response = await _networkCalls.parentLogin(parentLoginRequest);
      log(_response.parentDetails!.fullName.toString());
      if (_response.parentDetails!.fullName != "") {
        await _sharePref.saveParentDetails(_response);
        var _fcmToken = await _sharePref.getFCMToken();
        await _networkCalls.sendParentFCMToken(_fcmToken.toString());
        await _sharePref.setUserWelcomed();
        Navigator.pop(context);
        // AppRoutes.goToParentDashboard(
        //     _response.parentDetails!.fullName.toString());
        Get.offAll(() => const BottomNavBarScreen(
              isUserChild: false,
            ));
      } else {
        await _sharePref.saveParentDetails(_response);
        var _fcmToken = await _sharePref.getFCMToken();
        await _networkCalls.sendParentFCMToken(_fcmToken.toString());
        await _sharePref.setUserWelcomed();
        Navigator.pop(context);
        Get.off(() => const ParentAskNameScreen());
      }
    } catch (e) {
      Navigator.pop(context);
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
