import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/otp_request.dart';
import 'package:esikshya/models/network_models/request/parent_register_request.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/views/parent/parent_auth/account_not_verified.dart';
import 'package:esikshya/views/parent/parent_auth/account_verified.dart';
import 'package:esikshya/views/parent/parent_auth/otp_screen.dart';

class ParentSignUpController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();
  var countryCode = "".obs;

  parentSignUp(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      var parentRegisterRequest =
          ParentRegisterRequest(phone: phoneNumberController.text);
      var _response = await _networkCalls.parentRegister(parentRegisterRequest);
      if (_response["is_verified"] == true) {
        Navigator.pop(context);
        AppWidgets.showSnackBar(context,
            "parent with this phone number already exists. Please login");
      } else {
        Navigator.pop(context);
        Get.to(() => const ParentOTPScreen());
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  parentOTPAuth(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      String otp =
          otp1.text + otp2.text + otp3.text + otp4.text + otp5.text + otp6.text;
      OTPRequest otpRequest =
          OTPRequest(phone: phoneNumberController.text, otp: otp);

      var _response = await _networkCalls.parentOTP(otpRequest);
      if (_response["message"] == "mobile number verified successfully") {
        Navigator.pop(context);
        Get.to(() => AccountVerified(
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

  @override
  void dispose() {
    phoneNumberController.dispose();
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();
    countryCode.value = "";
    super.dispose();
  }
}
