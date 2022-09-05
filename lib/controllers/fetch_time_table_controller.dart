import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/response/add_time_table_response.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:intl/intl.dart';

class FetchTimeTableController extends GetxController {
  var currentDay = "SUN".obs;
  var currentWeekday = 1.obs;
  @override
  void onInit() {
    currentDay.value = DateFormat.E().format(DateTime.now()).toUpperCase();
    currentWeekday.value = DateTime.now().weekday;
    super.onInit();
  }

  changeCurrentDay() {
    if (currentWeekday.value >= 7) {
      currentWeekday.value = currentWeekday.value % 7;
    }
    switch (currentWeekday.value) {
      case 0:
        currentDay.value = "SUN";
        break;
      case 1:
        currentDay.value = "MON";
        break;
      case 2:
        currentDay.value = "TUE";
        break;
      case 3:
        currentDay.value = "WED";
        break;
      case 4:
        currentDay.value = "THU";
        break;
      case 5:
        currentDay.value = "FRI";
        break;
      case 6:
        currentDay.value = "SAT";
        break;
    }
  }

  final NetworkCalls _networkCalls = NetworkCalls();

  var responseDays = "SUN".obs;

  Future<List<AddTimeTableResponse>?> fetchTimeTable(
      BuildContext context) async {
    try {
      var _response = await _networkCalls.getStudentTimeTable();
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
