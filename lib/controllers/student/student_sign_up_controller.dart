import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/student/student_login_controller.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/database_helper.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/student/student_check_parent_request.dart';
import 'package:esikshya/models/network_models/request/student/student_login_request.dart';
import 'package:esikshya/models/network_models/request/student/student_register_request.dart';
import 'package:esikshya/models/network_models/request/student/student_tell_us_more_request.dart';
import 'package:esikshya/models/network_models/request/student/student_verify_parent_request.dart';
import 'package:esikshya/models/network_models/response/children_details_response.dart';
import 'package:esikshya/utils/app_routes.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/views/student/student_auth/student_otp_parent_screen.dart';
import 'package:esikshya/views/student/student_auth/student_username_screen.dart';
import 'package:esikshya/views/student/student_tell_us_more/student_tell_us_more.dart';

class StudentSignUpController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();

  TextEditingController parentKeyController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();
  // TextEditingController dobController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  StudentLoginController _studentLoginController =
      Get.put(StudentLoginController());
  var grade = "".obs;
  var gender = "".obs;
  var state = "".obs;
  var country = "".obs;
  var dateOfBirth = "".obs;
  var showPassword = false.obs;

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();
  var countryCode = "".obs;
  var checkValidation = false.obs;
  var isFormTapped = false.obs;
  var isUserNameEmpty = true.obs;
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  studentCheckParent(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      var studentCheckParentRequest =
          StudentCheckParentRequest(randomKey: parentKeyController.text);
      var _response =
          await _networkCalls.studentCheckParent(studentCheckParentRequest);
      if (_response["message"] == "Parents is verified") {
        Navigator.pop(context);
        Get.to(() => const StudentAskUsernameScreen());
      } else if (_response["message"] ==
          "parent with provided phone doesnot exists") {
        Navigator.pop(context);
        AppWidgets.showSnackBar(
            context, "Please register your parent number first.");
      }
    } catch (e) {
      Navigator.pop(context);
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  parentOTPVerify(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      String otp =
          otp1.text + otp2.text + otp3.text + otp4.text + otp5.text + otp6.text;
      StudentVerifyParentRequest studentVerifyParentRequest =
          StudentVerifyParentRequest(phone: parentKeyController.text, otp: otp);

      var _response =
          await _networkCalls.studentVerifyParent(studentVerifyParentRequest);

      if (_response["message"] == "phone verified successfully") {
        Navigator.pop(context);
        Get.to(() => const StudentAskUsernameScreen());
      } else if (_response) {
        Navigator.pop(context);
        AppWidgets.showSnackBar(context, "Unexpected Error.!!");
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  checkUserName() async {
    try {
      var _response =
          await _networkCalls.checkUserName(usernameController.text);
      if (_response["message"] == "username available") {
        checkValidation.value = true;
        return true;
      } else {
        checkValidation.value = false;
        return false;
      }
    } catch (e) {
      checkValidation.value = false;
    }
  }

  studentSignUp(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      var studentRegisterRequest = StudentRegisterRequest(
        randomKey: parentKeyController.text,
        username: usernameController.text,
        password: passwordController.text,
      );
      var _response =
          await _networkCalls.studentRegister(studentRegisterRequest);
      if (_response["message"] == "child account created successfully") {
        try {
          StudentLoginRequest _studentLoginRequest = StudentLoginRequest(
              username: studentRegisterRequest.username,
              password: studentRegisterRequest.password);
          var _studentLoginResponse =
              await _networkCalls.studentLogin(_studentLoginRequest);
          if (_studentLoginResponse.childDetails!.username ==
              studentRegisterRequest.username) {
            await Get.find<AppSharedPreferences>()
                .saveStudentDetails(_studentLoginResponse);
            // var _fcmToken =
            //     await Get.find<AppSharedPreferences>().getFCMToken();
            // await _networkCalls.sendChildFCMToken(_fcmToken.toString());
            await Get.find<AppSharedPreferences>().setUserWelcomed();
            Get.to(() => StudentTellUsMore(
                username: usernameController.text,
                password: passwordController.text));
          } else {
            AppWidgets.showSnackBar(context, "Unexpected error!");
          }
        } catch (e) {
          AppWidgets.showSnackBar(context, e.toString());
        }
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  studentTellUsMore(
      BuildContext context, String username, String password) async {
    try {
      AppWidgets.showLoading(context);
      StudentTellUsMoreRequest studentTellUsMoreRequest =
          StudentTellUsMoreRequest(
              fullName: studentNameController.text,
              dateOfBirth: dateOfBirth.value,
              gender: gender.value,
              school: schoolNameController.text,
              country: country.value,
              state: state.value,
              grade: int.parse(grade.value));
      var _response =
          await _networkCalls.studentTellUsMore(studentTellUsMoreRequest);
      if (_response["message"] == "child details added successfully") {
        StudentLoginRequest _studentLoginRequest =
            StudentLoginRequest(username: username, password: password);
        var _studentLoginResponse =
            await _networkCalls.studentLogin(_studentLoginRequest);
        if (_studentLoginResponse.childDetails!.username ==
            _studentLoginRequest.username) {
          await Get.find<AppSharedPreferences>()
              .saveStudentDetails(_studentLoginResponse);
          var _fcmToken = await Get.find<AppSharedPreferences>().getFCMToken();
          await _networkCalls.sendChildFCMToken(_fcmToken.toString());
          await Get.find<AppSharedPreferences>().setUserWelcomed();
          ChildrenDetailsResponse _childDetailResponse =
              ChildrenDetailsResponse(
            childId: int.parse(
                _studentLoginResponse.childDetails!.childId.toString()),
            fullName: _studentLoginResponse.childDetails!.fullName.toString(),
            username: _studentLoginResponse.childDetails!.username.toString(),
            dateOfBirth:
                _studentLoginResponse.childDetails!.dateOfBirth.toString(),
            grade:
                int.parse(_studentLoginResponse.childDetails!.grade.toString()),
            gender: _studentLoginResponse.childDetails!.gender.toString(),
            school: _studentLoginResponse.childDetails!.school.toString(),
            country: _studentLoginResponse.childDetails!.country.toString(),
            state: _studentLoginResponse.childDetails!.state.toString(),
          );
          await _databaseHelper.addChildDetails(_childDetailResponse);
          AppRoutes.goToBottomNavBar(true);
        } else {
          AppWidgets.showSnackBar(context, "Adding details failed.");
        }
      } else {
        AppWidgets.showSnackBar(context, "Adding details failed.");
        // AppRoutes.goToStudentHomeScreen();
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
