import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/utils/app_widgets.dart';

class ParentAccountController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();
  getChildDetails(BuildContext context) async {
    try {
      var _response = await _networkCalls.getChildrenDetails();
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  fetchParentCode(BuildContext context) async {
    try {
      var _response = await _networkCalls.fetchParentDetail();
      return _response.parentDetail!.parentsCode;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
