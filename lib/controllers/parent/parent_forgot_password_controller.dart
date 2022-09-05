import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/otp_request.dart';
import 'package:esikshya/models/network_models/request/parent_register_request.dart';
import 'package:esikshya/models/network_models/request/parent_set_password_request.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/views/parent/parent_auth/account_not_verified.dart';
import 'package:esikshya/views/parent/parent_auth/parentForgotPassword/parent_fp_otp_screen.dart';
import 'package:esikshya/views/parent/parent_auth/parentForgotPassword/parent_fp_set_password_screen.dart';
import 'package:esikshya/views/parent/parent_auth/parent_login_screen.dart';

class ParentForgotPasswordController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  var showEyeButton = false.obs;
  var isObscure = true.obs;

  parentForgotPasswordEnterNumber(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      var parentRegisterRequest =
          ParentRegisterRequest(phone: phoneNumberController.text);
      var _response = await _networkCalls
          .parentForgotPasswordRegister(parentRegisterRequest);
      if (_response["message"] == "parent with provided phone doesnot exists") {
        Navigator.pop(context);
        AppWidgets.showSnackBar(
            context, "Please register your parent number first.");
      } else {
        Navigator.pop(context);
        Get.to(() => const ParentFpVerifyOTPScreen());
      }
    } catch (e) {
      Navigator.pop(context);
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  parentForgotPasswordOtpVerify(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      String otp =
          otp1.text + otp2.text + otp3.text + otp4.text + otp5.text + otp6.text;
      OTPRequest otpRequest =
          OTPRequest(phone: phoneNumberController.text, otp: otp);

      var _response = await _networkCalls.parentOTP(otpRequest);
      if (_response["message"] == "mobile number verified successfully") {
        Navigator.pop(context);
        Get.to(() => ParentFpSetPasswordScreen(
              phoneNumber: phoneNumberController.text,
            ));
      } else if (_response["message"] == "mobile number already verified") {
        Navigator.pop(context);
        AppWidgets.showSnackBar(
            context, "mobile number already verified,please login");
      } else {
        Navigator.pop(context);
        Get.to(() => const AccountNotVerified());
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  parentForgotPasswordSetPassword(
      BuildContext context, String phoneNumber) async {
    try {
      AppWidgets.showLoading(context);
      var parentSetPasswordRequest = ParentSetPasswordRequest(
        phone: phoneNumber,
        password: confirmPassword.text,
      );
      var _response =
          await _networkCalls.setPasswordParents(parentSetPasswordRequest);
      if (_response["message"] == "password set successfully") {
        AppWidgets.showSnackBar(context, _response["message"]);
        Get.to(() => const ParentLoginScreen());
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
