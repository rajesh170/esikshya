import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/database_helper.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/student/student_details_request.dart';
import 'package:esikshya/utils/app_widgets.dart';

class StudentEditProfileController extends GetxController {
  final _sharedPref = Get.find<AppSharedPreferences>();
  final NetworkCalls _networkCalls = NetworkCalls();

  var grade = "".obs;
  var state = "".obs;
  var country = "".obs;
  var gender = "".obs;
  var readOnly = true.obs;

  getChildDetails() async {
    var childId = await _sharedPref.getChildId();
    var childData = await DatabaseHelper.instance.getChildDetailsById(childId);
    return childData;
  }

  @override
  void onInit() async {
    // getChildDetails();
    super.onInit();
  }

  editStudentDetails(
      BuildContext context, ChildDetail _childDetailRequest) async {
    try {
      AppWidgets.showLoading(context);
      var _response = await _networkCalls.editChildDetails(_childDetailRequest);
      log(_response.toString());
      if (_response['message'] == 'update/edit successfull') {
        Navigator.pop(context);
        var _childId = await _sharedPref.getChildId();
        var _childDob = await _sharedPref.getChildDateOfBirth();
        log(_childId.toString());
        ChildDetail cd = ChildDetail(
          fullName: _childDetailRequest.fullName,
          dateOfBirth: _childDob,
          gender: _childDetailRequest.gender,
          school: _childDetailRequest.school,
          state: _childDetailRequest.state,
          country: _childDetailRequest.country,
          grade: _childDetailRequest.grade,
        );
        await DatabaseHelper.instance.updateChildDetails(cd, _childId);
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
