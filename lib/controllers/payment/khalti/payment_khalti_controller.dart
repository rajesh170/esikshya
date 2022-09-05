import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/payment/khalti/khalti_one_request.dart';
import 'package:esikshya/models/network_models/request/payment/khalti/khalti_three_request.dart';
import 'package:esikshya/models/network_models/request/payment/khalti/khalti_two_request.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/views/parent/parent_payment_method/payment_failed.dart';
import 'package:esikshya/views/parent/parent_payment_method/payment_success.dart';
import 'package:esikshya/views/payment/khalti/khalti_otp_screen.dart';

class KhaltiPayController extends GetxController {
  KhaltiPayController(this._childIdList, this._amount, this._save);

  final NetworkCalls _networkCalls = NetworkCalls();

  // from payment page
  final List<int> _childIdList;
  final int _amount;
  final bool _save;

  // from khalti auth page
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController transactionPin = TextEditingController();
  // TODO replace productIdentity and productName later
  // TextEditingController productIdentity = TextEditingController();
  String productIdentity = "demo";
  // TextEditingController productName = TextEditingController();
  String productName = "edtech";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // from OTP verify page
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();
  TextEditingController confirmationCode = TextEditingController();

  final String _publicTestKey =
      "test_public_key_00c7a01504da4d7a9b836f41777bef9a";
  // "test_public_key_592100a099b746ee9d3f25b6451fbe7f";

  // for 3rd api

  String _khaltiToken = "";

  String _transactionId = "";

  // khalti api one
  khaltiOne(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      var khaltiOneRequest = KhaltiOneRequest(
          publicKey: _publicTestKey,
          amount: _amount,
          mobile: phoneNumber.text,
          transactionPin: transactionPin.text,
          // productIdentity: productIdentity.text,
          productIdentity: productIdentity,
          // productName: productName.text);
          productName: productName);
      var _response = await _networkCalls.paymentKhaltiOne(khaltiOneRequest);
      final r = _response;
      if (_response["token"] != null) {
        // store _response token in _khaltiToken
        _khaltiToken = _response["token"];
        Navigator.pop(context);
        Get.to(() => KhaltiOtpScreen(
              childIdList: _childIdList,
              amount: _amount,
              save: _save,
            ));
      } else {
        Navigator.pop(context);
        AppWidgets.showSnackBar(context, "Some Error Occured!.");
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  // khalti api two
  khaltiTwo(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      String confirmationCode =
          otp1.text + otp2.text + otp3.text + otp4.text + otp5.text + otp6.text;

      var khaltiTwoRequest = KhaltiTwoRequest(
          publicKey: _publicTestKey,
          token: _khaltiToken,
          confirmationCode: confirmationCode,
          transactionPin: transactionPin.text);

      var _response = await _networkCalls.paymentKhaltiTwo(khaltiTwoRequest);

      if (_response["token"] == _khaltiToken) {
        _transactionId = _response["idx"];
        await khaltiThree(context);
      } else if (_response["message"] == "can't complete transaction") {
        AppWidgets.showSnackBar(context, _response["error"]);
      } else {
        Navigator.pop(context);
        AppWidgets.showSnackBar(context, "Some Error Occured!.");
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  // khalti api three
  khaltiThree(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      var khaltiThreeRequest = KhaltiThreeRequest(
        number: int.parse(phoneNumber.text),
        token: _khaltiToken,
        trid: _transactionId,
        amount: _amount,
        childId: _childIdList,
        save: _save,
      );

      var _response =
          await _networkCalls.paymentKhaltiThree(khaltiThreeRequest);

      if (_response == null) {
        AppWidgets.showSnackBar(context, "Payment Successful");
        Get.offAll(() => const PaymentSuccess());
      } else {
        AppWidgets.showSnackBar(context, "Some Error Occured.");
        Get.offAll(() => const PaymentFailed());
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
