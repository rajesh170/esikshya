import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/database_helper.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/student/student_login_request.dart';
import 'package:esikshya/models/network_models/response/children_details_response.dart';
import 'package:esikshya/utils/app_routes.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/views/common/bottom_nav_bar_screen.dart';
import 'package:esikshya/views/student/home/student_home_screen.dart';
import 'package:esikshya/views/student/student_tell_us_more/student_tell_us_more.dart';

class StudentLoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var showEyeButton = false.obs;
  var isObscure = true.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _sharedPref = Get.find<AppSharedPreferences>();
  final NetworkCalls _networkCalls = NetworkCalls();
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  studentLogin(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      var studentLoginRequest = StudentLoginRequest(
          username: usernameController.text, password: passwordController.text);
      var _response = await _networkCalls.studentLogin(studentLoginRequest);
      log(_response.childDetails.toString());

      if (_response.childDetails!.grade != 0) {
        await _sharedPref.saveStudentDetails(_response);
        var _fcmToken = await _sharedPref.getFCMToken();
        await _networkCalls.sendChildFCMToken(_fcmToken.toString());
        await _sharedPref.setUserWelcomed();
        ChildrenDetailsResponse _childDetailResponse = ChildrenDetailsResponse(
          childId: int.parse(_response.childDetails!.childId.toString()),
          fullName: _response.childDetails!.fullName.toString(),
          username: _response.childDetails!.username.toString(),
          dateOfBirth: _response.childDetails!.dateOfBirth.toString(),
          grade: int.parse(_response.childDetails!.grade.toString()),
          gender: _response.childDetails!.gender.toString(),
          school: _response.childDetails!.school.toString(),
          country: _response.childDetails!.country.toString(),
          state: _response.childDetails!.state.toString(),
        );
        await _databaseHelper.addChildDetails(_childDetailResponse);

        Navigator.pop(context);
        Get.offAll(
          () => const BottomNavBarScreen(
            isUserChild: true,
          ),
        );
      } else {
        await _sharedPref.saveStudentDetails(_response);
        var _fcmToken = await _sharedPref.getFCMToken();
        await _networkCalls.sendChildFCMToken(_fcmToken.toString());
        await _sharedPref.setUserWelcomed();
        // AppRoutes.goToStudentTellUsMore();
        Get.to(() => StudentTellUsMore(
            username: usernameController.text,
            password: passwordController.text));
      }
    } catch (e) {
      Navigator.pop(context);
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
