import 'package:flutter/material.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/payment/esewa/esewa_sdk_request.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/views/parent/parent_payment_method/payment_failed.dart';
import 'package:esikshya/views/parent/parent_payment_method/payment_success.dart';

class EsewaPayController extends GetxController {
  EsewaPayController({
    required this.parentPhoneNumber,
    required this.productPrice,
    required this.childIdList,
    required this.save,
  });

  final String parentPhoneNumber;
  final int productPrice;
  final List<int> childIdList;
  final bool save;

  final String CLIENT_ID =
      "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R";
  final String SECRET_KEY = "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==";

  makePayment(BuildContext context) async {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: CLIENT_ID,
          secretId: SECRET_KEY,
        ),
        esewaPayment: EsewaPayment(
          productId: "1d71jd81",
          productName: "Product One",
          // productPrice: "20",
          productPrice: productPrice.toString(),
          callbackUrl: "www.test-url.com",
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          debugPrint(":::SUCCESS::: => $data");
          NetworkCalls _networkCalls = NetworkCalls();
          EsewaSdkRequestModel esewaSdkRequest = EsewaSdkRequestModel(
            amount: int.parse(data.totalAmount),
            childId: childIdList,
            // Replaced esewa payer phone number with parent phone number
            // beacuse getting esewa payer phone number is not figured out.
            number: parentPhoneNumber,
            save: save,
            token: "",
            trid: data.refId,
          );
          _networkCalls.esewaSdk(esewaSdkRequest);
          Get.offAll(() => const PaymentSuccess());
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
          Get.offAll(() => const PaymentFailed());
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
          Get.offAll(() => const PaymentFailed());
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
