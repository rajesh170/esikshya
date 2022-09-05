import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/response/videos_response/fectch_videos_by_class_response.dart';
import 'package:esikshya/utils/app_widgets.dart';

class StudentHomeScreenController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();
  Future<List<FetchVideoByClassResponse>?> fetchVideosByClass(
      BuildContext context) async {
    try {
      // AppWidgets.showLoading(context);
      var _response = await _networkCalls.fetchVideosByGrade();
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
