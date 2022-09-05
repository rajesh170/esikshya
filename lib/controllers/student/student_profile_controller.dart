import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/database_helper.dart';

class StudentProfileController extends GetxController {
  final _sharedPref = Get.find<AppSharedPreferences>();
  Future getChildDetail() async {
    var id = await _sharedPref.getChildId();
    var childDetail = await DatabaseHelper.instance.getChildDetailsById(id);
    return childDetail[0];
  }
}
