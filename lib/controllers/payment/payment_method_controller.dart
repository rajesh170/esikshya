import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/response/children_details_response.dart';
import 'package:esikshya/utils/app_widgets.dart';

class ParentPaymentController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();

  RxList<int> childIdList = <int>[].obs;

  var childListError = "".obs;

  // "Esewa" for esewa
  // "Khalti" for khalti
  var paymentMethod = "Khalti".obs;

  //TODO get yearly amount package from api??
  var amount = 5500.obs;

  var save = true.obs;

  Future<List<ChildrenDetailsResponse>?> fetchChildList(
      BuildContext context) async {
    try {
      var _response = await _networkCalls.parentChildList();
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
