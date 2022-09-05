import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/custom_widgets/k_dialog.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/student/add_time_table_request.dart';
import 'package:esikshya/utils/app_widgets.dart';

class AddTimeTableController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();
  var selectedSubject = "".obs;
  var selectedClass = "0".obs;
  var selectedSection = "".obs;
  var selectedPeriod = "".obs;
  var selectedDay = [].obs;
  var selectedTime = "".obs;
  var endTime = "".obs;
  var selectedIndex = 10.obs;
  resetTime() {
    selectedTime.value = "";
    endTime.value = "";
  }

  clearData() {
    selectedSubject.value = "";
    selectedClass.value = "0";
    selectedSection.value = "";
    selectedPeriod.value = "";
    selectedDay.value = [];
    selectedTime.value = "";
    endTime.value = "";
    selectedIndex.value = 10;
  }

  addTimeTable(BuildContext context) async {
    try {
      AppWidgets.showLoading(context);
      var addTimeTableRequest = AddTimeTableRequest(
          grade: int.parse(selectedClass.value.toString()),
          section: selectedSection.value,
          description: selectedPeriod.value,
          day: selectedDay[0],
          startTime: selectedTime.value,
          endTime: endTime.value);

      var _response =
          await _networkCalls.studentAddtimeTable(addTimeTableRequest);
      if (_response["message"] == "time table added successfully") {
        Navigator.pop(context);
        clearData();
        CustomDialogesikshya.openEsikshyaDialog(context);
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
