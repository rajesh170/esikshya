import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/edit_parent_details_request.dart';
import 'package:esikshya/utils/app_widgets.dart';

class ParentEditProfileController extends GetxController {
  TextEditingController parentFullNameController = TextEditingController();
  var location = "".obs;
  // var initialPage = 0.obs;
  // var isTappedNext = false.obs;

  final NetworkCalls _networkCalls = NetworkCalls();
  final _sharedPref = Get.find<AppSharedPreferences>();

  editParentProfile(BuildContext context, String fullName) async {
    try {
      AppWidgets.showLoading(context);

      EditParentDetailsRequest editParentDetailsRequest =
          EditParentDetailsRequest(fullName: fullName);
      var _response =
          await _networkCalls.parentDetailsEdit(editParentDetailsRequest);

      if (_response["message"] == "update/edit successfull") {
        Navigator.pop(context);
        await _sharedPref.saveParentName(fullName);
      }
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  fetchParentNameStream() async* {
    while (true) {
      yield await Future.delayed(
          const Duration(seconds: 2), () => _sharedPref.getParentName());
    }
  }

  fetchParentShortNameStream() async* {
    while (true) {
      yield await Future.delayed(
          const Duration(seconds: 2), () => _sharedPref.getParentName());
    }
  }

  getInitials(String parentFullname) {
    if (parentFullname.contains(' ')) {
      List<String> names = parentFullname.split(' ');
      if (names[0].isNotEmpty && names[1].isNotEmpty) {
        String shortName = names[0][0] + names[1][0];
        return shortName.toUpperCase();
      } else {
        return '';
      }
    } else {
      String shortName = parentFullname[0];
      return shortName.toUpperCase();
    }
  }

  @override
  void dispose() {
    parentFullNameController.dispose();
    super.dispose();
  }
}
