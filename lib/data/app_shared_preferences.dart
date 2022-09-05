import 'package:get/get.dart';
import 'package:esikshya/models/network_models/response/parent_login_response.dart';
import 'package:esikshya/models/network_models/response/silent_refresh_response.dart';
import 'package:esikshya/models/network_models/response/student_login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences extends GetxController {
  saveIsDarkModeOn(bool isDarkModeOn) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("isDarkModeOn", isDarkModeOn);
  }

  getDarkMode() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool("isDarkModeOn") ?? true;
  }

  Future<bool> removeExpiredToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('accessToken');
    _prefs.remove('refreshToken');
    return true;
  }

  Future<bool> setNewTokens(SilentRefreshResponse silentRefreshResponse) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('accessToken', silentRefreshResponse.accessToken ?? "");
    _prefs.setString('refreshToken', silentRefreshResponse.refreshToken ?? "");
    return true;
  }

  Future saveParentDetails(ParentLoginResponse parentLoginResponse) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(
        "parentAccessToken", parentLoginResponse.accessToken.toString());
    await _prefs.setString(
        "parentPhone", parentLoginResponse.parentDetails!.phone.toString());
    await _prefs.setString(
        "parentName", parentLoginResponse.parentDetails!.fullName.toString());
    await _prefs.setString(
        "parentId", parentLoginResponse.parentDetails!.parentId.toString());
  }

  Future saveStudentDetails(StudentLoginResponse studentLoginResponse) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(
        "childAccessToken", studentLoginResponse.accessToken.toString());
    await _prefs.setString(
        "childId", studentLoginResponse.childDetails!.childId.toString());
    await _prefs.setString(
        "childName", studentLoginResponse.childDetails!.fullName.toString());
    await _prefs.setString(
        "username", studentLoginResponse.childDetails!.username.toString());
    await _prefs.setString("dateOfBirth",
        studentLoginResponse.childDetails!.dateOfBirth.toString());
    await _prefs.setString(
        "gender", studentLoginResponse.childDetails!.gender.toString());
    await _prefs.setString(
        "school", studentLoginResponse.childDetails!.school.toString());
    await _prefs.setString(
        "country", studentLoginResponse.childDetails!.country.toString());
    await _prefs.setString(
        "state", studentLoginResponse.childDetails!.state.toString());
    await _prefs.setString(
        "grade", studentLoginResponse.childDetails!.grade!.toString());
    return true;
  }

  Future getParentName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _parentFullName = _prefs.getString("parentName") ?? "";
    return _parentFullName;
  }

  Future getParentPhoneNumber() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _parentPhone = _prefs.getString("parentPhone") ?? "";
    return _parentPhone;
  }

  Future<String?> getParentAccessToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _parentAccessToken = _prefs.getString("parentAccessToken") ?? "";
    return _parentAccessToken;
  }

//children details
  Future<String?> getChildName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _childName = _prefs.getString("childName") ?? "";
    return _childName;
  }

  Future<String?> getChildDateOfBirth() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _dateOfBirth = _prefs.getString("dateOfBirth") ?? "";
    return _dateOfBirth;
  }

  Future<String?> getChildGender() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _childGender = _prefs.getString("gender") ?? "";
    return _childGender;
  }

  Future<String?> getChildCountry() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _childCountry = _prefs.getString("country") ?? "";
    return _childCountry;
  }

  Future<String?> getChildSchool() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _childSchool = _prefs.getString("school") ?? "";
    return _childSchool;
  }

  Future<String?> getChildUserName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _username = _prefs.getString("username") ?? "";
    return _username;
  }

  Future getChildState() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _childState = _prefs.getString("state") ?? "";
    return _childState;
  }

  Future getChildGrade() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _childGrade = _prefs.getString("grade") ?? "";
    return _childGrade;
  }

  Future getChildId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _childId = _prefs.getString("childId") ?? "";
    return _childId;
  }

  Future<String?> saveParentName(String parentName) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("parentName", parentName);
  }

  Future<String?> setUserWelcomed() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("isUserWelcomed", true);
  }

  Future<bool?> getUserWelcomed() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var isParentWelcomed = _prefs.getBool("isUserWelcomed") ?? false;
    return isParentWelcomed;
  }

  // Future<String?> setChildWelcomed() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   await _prefs.setBool("isChildWelcomed", true);
  // }

  // Future<bool?> getChildWelcomed() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   var isChildWelcomed = _prefs.getBool("isChildWelcomed") ?? false;
  //   return isChildWelcomed;
  // }

  Future<String?> getChildAccessToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _userData = _prefs.getString("childAccessToken") ?? "";

    return _userData;
  }

  Future<String?> getUserRefreshToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _userData = _prefs.getString("refreshToken") ?? "";
    return _userData;
  }

  removeParentDetails() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // await _prefs.remove("isParentWelcomed");
    await _prefs.remove("parentAccessToken");
    await _prefs.remove("parentPhone");
    await _prefs.remove("parentName");
    await _prefs.remove("parentId");
  }

  removeChildDetails() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // await _prefs.remove("isParentWelcomed");
    await _prefs.remove("childAccessToken");
    await _prefs.remove("childId");
    await _prefs.remove("childName");
    await _prefs.remove("username");
    await _prefs.remove("gender");
    await _prefs.remove("school");
    await _prefs.remove("country");
    await _prefs.remove("state");
  }

//////------- save FCM Token ---------///////

  saveFCMToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("fcmToken", token);
  }

  Future<String?> getFCMToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _fcmToken = _prefs.getString("fcmToken") ?? "";
    return _fcmToken;
  }
}
