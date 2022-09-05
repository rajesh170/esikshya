import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/database_helper.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/utils/app_widgets.dart';

class ChildrenDetailsController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();

  @override
  void onInit() async {
    DatabaseHelper.instance.initDatabase();

    //  DatabaseHelper.instance.close();

    super.onInit();
  }

  getChildrenDetailsInParentProfile(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      var _response = await _networkCalls.getChildrenDetails();
      await DatabaseHelper.instance.delete();
      if (_response.isNotEmpty) {
        Navigator.pop(context);

        for (var i = 0; i < _response.length; i++) {
          await DatabaseHelper.instance.addChildDetails(_response[i]);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
