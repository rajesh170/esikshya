import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/network/network_base.dart';
import 'package:esikshya/models/network_models/request/edit_parent_details_request.dart';
import 'package:esikshya/models/network_models/request/otp_request.dart';
import 'package:esikshya/models/network_models/request/parent_login_request.dart';
import 'package:esikshya/models/network_models/request/parent_register_request.dart';
import 'package:esikshya/models/network_models/request/parent_set_password_request.dart';
import 'package:esikshya/models/network_models/request/payment/esewa/esewa_sdk_request.dart';
import 'package:esikshya/models/network_models/request/payment/khalti/khalti_one_request.dart';
import 'package:esikshya/models/network_models/request/payment/khalti/khalti_three_request.dart';
import 'package:esikshya/models/network_models/request/payment/khalti/khalti_two_request.dart';
import 'package:esikshya/models/network_models/request/silent_refresh_request.dart';
import 'package:esikshya/models/network_models/request/student/add_time_table_request.dart';
import 'package:esikshya/models/network_models/request/student/leader_board_request/your_stat_request.dart';
import 'package:esikshya/models/network_models/request/student/student_check_parent_request.dart';
import 'package:esikshya/models/network_models/request/student/student_details_request.dart';
import 'package:esikshya/models/network_models/request/student/student_login_request.dart';
import 'package:esikshya/models/network_models/request/student/student_register_request.dart';
import 'package:esikshya/models/network_models/request/student/student_tell_us_more_request.dart';
import 'package:esikshya/models/network_models/request/student/student_verify_parent_request.dart';
import 'package:esikshya/models/network_models/response/add_time_table_response.dart';
import 'package:esikshya/models/network_models/response/children_details_response.dart';
import 'package:esikshya/models/network_models/response/error_response.dart';
import 'package:esikshya/models/network_models/response/game_notification_response.dart';
import 'package:esikshya/models/network_models/response/get_friend_list_response.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/country_rank_response.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/leaderboard_details_section_response.dart';
// import 'package:esikshya/models/network_models/response/leaderboard_responses/province_rank_Response.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/users_rank_in_country_response.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/your_stat_response.dart';
import 'package:esikshya/models/network_models/response/notification_screen_response.dart';
import 'package:esikshya/models/network_models/response/otp_response.dart';
import 'package:esikshya/models/network_models/response/parent_child_details_response.dart';
import 'package:esikshya/models/network_models/response/parent_details_response.dart';
import 'package:esikshya/models/network_models/response/parent_login_response.dart';
import 'package:esikshya/models/network_models/response/silent_refresh_response.dart';
import 'package:esikshya/models/network_models/response/student_login_response.dart';
import 'package:esikshya/models/network_models/response/videos_response/fectch_videos_by_class_response.dart';
import 'package:esikshya/utils/app_exception.dart';
import 'package:http/http.dart' as http;

class NetworkCalls {
  final NetworkBase _networkBase = NetworkBase();
  final _appSharedPreferences = Get.find<AppSharedPreferences>();

  final String _parentRegister = "parent-sign-up";
  final String _parentVerify = "parent-verify";
  final String _parentSetPassword = "parent-set-password";
  final String _parentlogin = "parent-login";
  final String _addParentDetail = "add-parent-detail";

  final String _parentForgotPassword = "parent-resend-code";

  final String _studentCheckParent = "child-sign-up-check-parent";
  final String _studentVerifyParent = "child-verify-parent-phone";
  final String _studentCheckUsername = "child-check-username";
  final String _studentRegister = "child-register-with-password";
  final String _studentLogin = "child-login";
  final String _studentTellUsMore = "add-child-detail";
  final String _studentCheckDetail = "child-check-detail";
  final String _checkUsername = "child-check-username";
  final String _childDetails = "child-detail";

  final String _editParentDetail = "edit-parent-detail";
  final String _editChildDetail = 'edit-child-detail';

  final String _addTimeTable = "add-time-table";
  final String _getTimeTable = "get-time-table";
  final String _fetchVideosByClass = "video/class";
  final String _fetchVideosBySubject = "video/subject";
  final String _getChildrenDetails = "children-details";
  final String _getParentDetails = "parent-detail";
  final String _paymentKhaltiOne = "payment/khalti/one";
  final String _paymentKhaltiTwo = "payment/khalti/two";
  final String _paymentKhaltiThree = "payment/khalti/three";

  final String _paymentEsewaSdk = "payment/sdk";

  final String _parentChildList = "children-details";
  final String _getFriendList = "friend/list";
  final String _sendFriendRequest = "friend/send";
  final String _searchFriends = "search?q=";
  final String _sendParentFCMToken = "parents/token";
  final String _sendChildFCMToken = "child/token";
  final String _getChildNotifications = "child/notification";
  final String _getChildGameNotification = "game/notification";
  final String _acceptFriendRequest = "friend/accepts";
  final String _rejectFriendRequest = "friend/reject";
  final String _removeFcmTokenChild = "child/token/remove";
  final String _removeFcmTokenParent = "parents/token/remove";
  final String _removeGameNotification = "game/notification/remove";
  final String _removeLobby = "game/remove/lobby";
  final String _removeLobbyRandom = "game/withrandom/remove/lobby";
  final String _makeOfflineForRandom = "game/withrandom/offline";
  final String _rankInCountry = "score/list/country";
  final String _scoreStats = "score/stats";
  final String _leaderboardDetailsSection = "score/list/details";
  final String _leaderboardCountry = "score/leaderboard/country";
  final String _leaderboardProvince = "score/leaderboard/state";

  Future parentRegister(ParentRegisterRequest parentRegisterRequest) async {
    var _response = await _networkBase.post(
        _parentRegister, parentRegisterRequest.toJson(),
        needToken: false);

    return _response;
  }

  Future parentOTP(OTPRequest otpRequest) async {
    final _response = await _networkBase
        .post(_parentVerify, otpRequest.toJson(), needToken: false);

    return _response;
  }

// ------------Parent Set Password ---------//
  Future setPasswordParents(
      ParentSetPasswordRequest parentSetPasswordRequest) async {
    var _response = await _networkBase.post(
        _parentSetPassword, parentSetPasswordRequest.toJson(),
        needToken: false);

    return _response;
  }

  // ----- Parent login  --------////

  Future<ParentLoginResponse> parentLogin(
      ParentLoginRequest parentLoginRequest) async {
    var _response = await _networkBase
        .post(_parentlogin, parentLoginRequest.toJson(), needToken: false);
    var _responses = ParentLoginResponse.fromJson(_response);
    // var _errorResponse = ErrorResponse.fromJson(_response);
    // if (_errorResponse.message ==
    //     "parent with provided mobile doesnot exists") {
    //   throw UserNotFoundException();
    // }
    //  else {
    return _responses;
    // }
  }

  /////-------- Save parent Name ----////

  saveParentName(String name) async {
    var _token = await _appSharedPreferences.getParentAccessToken();
    var body = {"full_name": name};
    var _response = await _networkBase.post(_addParentDetail, body,
        needToken: true, token: _token);
    return _response;
  }

//////----------edit parent profile------///
  Future parentDetailsEdit(
      EditParentDetailsRequest editParentDetailsRequest) async {
    var _token = await _appSharedPreferences.getParentAccessToken();

    var _response = await _networkBase.patch(
      _editParentDetail,
      editParentDetailsRequest.toJson(),
      needToken: true,
      token: _token,
    );
    return _response;
  }

  //---get children details on parent profile------

  Future<List<ChildrenDetailsResponse>> getChildrenDetails() async {
    var _token = await _appSharedPreferences.getParentAccessToken();
    var _response = await _networkBase.get(_getChildrenDetails,
        needToken: true, token: _token);
    List<ChildrenDetailsResponse>? _responses = [];
    _response.forEach((element) {
      _responses.add(ChildrenDetailsResponse.fromJson(element));
    });

    return _responses;
  }

  //-----Fetch Parent Details ---////////////////

  Future<ParentDetailsResponse> fetchParentDetail() async {
    var _token = await _appSharedPreferences.getParentAccessToken();
    log(_token.toString());
    var _response = await _networkBase.get(_getParentDetails,
        needToken: true, token: _token);
    ParentDetailsResponse parentDetails =
        ParentDetailsResponse.fromJson(_response);
    print(parentDetails.parentDetail!.parentsCode.toString());
    return parentDetails;
  }

  // -------------------------- static function ------------------------

  static silentRefresh() async {
    var _appSharedPreferences = Get.find<AppSharedPreferences>();
    NetworkBase _networkBase = NetworkBase();
    String _refreshTokenUrl = "refresh";
    String? _prefRefreshToken =
        await _appSharedPreferences.getUserRefreshToken();
    SilentRefreshRequest silentRefreshRequest =
        SilentRefreshRequest(refreshToken: _prefRefreshToken.toString());
    final _response = await _networkBase.post(
        _refreshTokenUrl, silentRefreshRequest.toJson());
    var _silentRefreshResponse = SilentRefreshResponse.fromJson(_response);
    _appSharedPreferences.removeExpiredToken();
    _appSharedPreferences.setNewTokens(_silentRefreshResponse);
  }

  // Check if Parent number exists in database during student sign up
  Future studentCheckParent(
      StudentCheckParentRequest parentExistsRequest) async {
    var _response = await _networkBase.post(
        _studentCheckParent, parentExistsRequest.toJson(),
        needToken: false);
    return _response;
  }

  // verify parent's phone number entered by student
  Future studentVerifyParent(
      StudentVerifyParentRequest studentVerifyParentRequest) async {
    var _response = await _networkBase.post(
        _studentVerifyParent, studentVerifyParentRequest.toJson(),
        needToken: false);
    return _response;
  }

  // register student with phone, username and password
  Future checkUserName(String username) async {
    var _response = await _networkBase
        .post(_checkUsername, {"username": username}, needToken: false);
    return _response;
  }

  // register student with phone, username and password
  Future studentRegister(StudentRegisterRequest studentRegisterRequest) async {
    var _response = await _networkBase.post(
        _studentRegister, studentRegisterRequest.toJson(),
        needToken: false);
    return _response;
  }

  //------- Student Login ---------/////
  Future<StudentLoginResponse> studentLogin(
      StudentLoginRequest studentLoginRequest) async {
    var _response = await _networkBase
        .post(_studentLogin, studentLoginRequest.toJson(), needToken: false);
    var _responses = StudentLoginResponse.fromJson(_response);
    return _responses;
  }

  //------- Student Tell us more ---------/////
  Future studentTellUsMore(
      StudentTellUsMoreRequest studentTellUsMoreRequest) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    log(_token.toString());
    if (_token != "") {
      var _response = await _networkBase.post(
          _studentTellUsMore, studentTellUsMoreRequest.toJson(),
          needToken: true, token: _token);

      return _response;
    } else {
      throw BadRequestException("Access token expired");
    }
  }

  //-------- Add time Table -------//
  studentAddtimeTable(AddTimeTableRequest addTimeTableRequest) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response = await _networkBase.post(
        _addTimeTable, addTimeTableRequest.toJson(),
        needToken: true, token: _token);
    return _response;
  }

// --------- get student time table --------//
  Future<List<AddTimeTableResponse>?> getStudentTimeTable() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response =
        await _networkBase.get(_getTimeTable, needToken: true, token: _token);
    List<AddTimeTableResponse>? _responses = [];
    _response.forEach((element) {
      _responses.add(AddTimeTableResponse.fromJson(element));
    });
    return _responses;
  }

  //--------- fetch videos by grade of student ---//
  Future<List<FetchVideoByClassResponse>> fetchVideosByGrade() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response = await _networkBase.get(_fetchVideosByClass,
        needToken: true, token: _token);
    List<FetchVideoByClassResponse> _responses = [];
    if (_response.runtimeType.toString() == "List<dynamic>") {
      _response.forEach((element) {
        _responses.add(FetchVideoByClassResponse.fromJson(element));
      });
      return _responses;
    } else {
      return _responses;
    }
  }

  //--------- fetch videos by grade of student ---//

  Future<List<FetchVideoByClassResponse>> fetchVideosBySubjectName(
      int grade, String subjectName) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var body = {"grade": grade, "subject": subjectName};
    var _response = await _networkBase.post(_fetchVideosBySubject, body,
        needToken: true, token: _token);
    List<FetchVideoByClassResponse> _responses = [];

    if (_response.runtimeType.toString() == "List<dynamic>") {
      _response.forEach((element) {
        _responses.add(FetchVideoByClassResponse.fromJson(element));
      });
      return _responses;
    } else {
      return _responses;
    }
    // _response.forEach((element) {
    //   _responses.add(FetchVideoByClassResponse.fromJson(element));
    // });
    // return _responses;
  }

  Future<dynamic> getYoutubeDetails(String userUrl) async {
    String embedUrl = "https://www.youtube.com/oembed?url=$userUrl&format=json";

    //store http request response to res variable
    var res = await http.get(Uri.parse(embedUrl));
    print("get youtube detail status code: " + res.statusCode.toString());

    try {
      if (res.statusCode == 200) {
        //return the json from the response

        return json.decode(res.body);
      } else {
        //return null if status code other than 200
        return const FormatException();
      }
    } on FormatException catch (e) {
      print('invalid JSON' + e.toString());
      //return null if error
      return null;
    }
  }

  Future editChildDetails(ChildDetail _childDetailRequest) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    print(_token);
    var _response = await _networkBase.patch(
        _editChildDetail, _childDetailRequest.toJson(),
        needToken: true, token: _token);
    return _response;
  }

  Future parentForgotPasswordRegister(
      ParentRegisterRequest parentRegisterRequest) async {
    var _response = await _networkBase.post(
        _parentForgotPassword, parentRegisterRequest.toJson(),
        needToken: false);
    return _response;
  }

  Future paymentKhaltiOne(KhaltiOneRequest khaltiOneRequest) async {
    var _token = await _appSharedPreferences.getParentAccessToken();
    var _response = await _networkBase.post(
      _paymentKhaltiOne,
      khaltiOneRequest.toJson(),
      needToken: true,
      token: _token,
    );
    return _response;
  }

  Future paymentKhaltiTwo(KhaltiTwoRequest khaltiTwoRequest) async {
    var _token = await _appSharedPreferences.getParentAccessToken();
    var _response = await _networkBase.post(
      _paymentKhaltiTwo,
      khaltiTwoRequest.toJson(),
      needToken: true,
      token: _token,
    );
    return _response;
  }

  Future paymentKhaltiThree(KhaltiThreeRequest khaltiThreeRequest) async {
    var _token = await _appSharedPreferences.getParentAccessToken();
    var _response = await _networkBase.post(
      _paymentKhaltiThree,
      khaltiThreeRequest.toJson(),
      needToken: true,
      token: _token,
    );
    return _response;
  }

  Future esewaSdk(EsewaSdkRequestModel esewaSdkRequest) async {
    var _token = await _appSharedPreferences.getParentAccessToken();
    var _response = await _networkBase.post(
      _paymentEsewaSdk,
      esewaSdkRequest.toJson(),
      needToken: true,
      token: _token,
    );
    return _response;
  }

  // TODO i think already done by rajesh
  Future<List<ChildrenDetailsResponse>> parentChildList() async {
    var _token = await _appSharedPreferences.getParentAccessToken();
    print("TOKEN:");
    print(_token);
    var _response = await _networkBase.get(_parentChildList,
        needToken: true, token: _token);
    List<ChildrenDetailsResponse>? _responses = [];
    _response.forEach((element) {
      _responses.add(ChildrenDetailsResponse.fromJson(element));
    });
    return _responses;
  }

//----------- Get Friend List ------------//
  Future<List<GetFriendListResponse>> getFriendList() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response =
        await _networkBase.get(_getFriendList, needToken: true, token: _token);

    List<GetFriendListResponse> _responses = [];
    if (_response.runtimeType.toString() == "List<dynamic>") {
      _response.forEach((element) {
        _responses.add(GetFriendListResponse.fromJson(element));
      });
      return _responses;
    } else {
      return _responses;
    }
  }

  sendFriendRequest(int receiverId) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    log(_token.toString());
    var body = {"receiver_id": receiverId};
    var _response = await _networkBase.post(_sendFriendRequest, body,
        needToken: true, token: _token);
    log(_response.toString());
    return _response;
  }

  acceptFriendRequest(int senderId, int notificationId) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var body = {"sender_id": senderId, "notification_id": notificationId};
    var _response = await _networkBase.post(_acceptFriendRequest, body,
        needToken: true, token: _token);
    log(_response.toString());
    return _response;
  }

  rejectFriendRequest(int senderId, int notificationId) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var body = {"sender_id": senderId, "notification_id": notificationId};
    var _response = await _networkBase.post(_rejectFriendRequest, body,
        needToken: true, token: _token);
    log(_response.toString());
    return _response;
  }

  //----------- Search friends -------/////////////
  Future<List<GetFriendListResponse>> searchFriends(String searchValue) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response = await _networkBase.get(_searchFriends + searchValue,
        needToken: true, token: _token);
    List<GetFriendListResponse> _responses = [];
    if (_response.runtimeType.toString() == "List<dynamic>") {
      _response.forEach((element) {
        _responses.add(GetFriendListResponse.fromJson(element));
      });
      return _responses;
    } else {
      return _responses;
    }
  }

  ///------------Send FCM TOKEN OF PARENT ---------//

  sendParentFCMToken(String fcmtoken) async {
    var _token = await _appSharedPreferences.getParentAccessToken();
    log(_token.toString());
    var body = {"token": fcmtoken};
    log(body.toString());
    var _response = await _networkBase.post(_sendParentFCMToken, body,
        needToken: true, token: _token);
    log(_response.toString());
    return _response;
  }

  ///------------Send FCM TOKEN OF CHILD ---------//

  sendChildFCMToken(String fcmtoken) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    log(_token.toString());
    var body = {"token": fcmtoken};
    log(body.toString());
    var _response = await _networkBase.post(_sendChildFCMToken, body,
        needToken: true, token: _token);
    log(_response.toString());
    return _response;
  }

  /////-------- GET Notifications------------/////

  getChildNotification() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response = await _networkBase.get(_getChildNotifications,
        needToken: true, token: _token);
    List<NotificationResponse> _responses = [];
    if (_response.runtimeType.toString() == "List<dynamic>") {
      _response.forEach((element) {
        _responses.add(NotificationResponse.fromJson(element));
      });
      return _responses;
    } else {
      return _responses;
    }
  }

  getChildGameNotification() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response = await _networkBase.get(_getChildGameNotification,
        needToken: true, token: _token);
    List<GameNotificationResponse> _responses = [];
    if (_response.runtimeType.toString() == "List<dynamic>") {
      _response.forEach((element) {
        _responses.add(GameNotificationResponse.fromJson(element));
      });
      return _responses;
    } else {
      return _responses;
    }
  }

  ///------------ Remove Notification For Game -----////

  removeChildGameNotification(int notificationId) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var body = {"notification_id": notificationId};
    var _response = await _networkBase.post(_removeGameNotification, body,
        needToken: true, token: _token);
    print(_response);
    return _response;
  }
  /////-------- remove FCM TOKEN DURING SIGN OUT-------------////////////////

  removeParentFcmTokenFromServer() async {
    var _token = await _appSharedPreferences.getParentAccessToken();
    log(_token.toString());
    var _response = await _networkBase.get(_removeFcmTokenParent,
        needToken: true, token: _token);

    return _response;
  }

  removeChildFcmTokenFromServer() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    log(_token.toString());
    var _response = await _networkBase.get(_removeFcmTokenChild,
        needToken: true, token: _token);
    return _response;
  }

//----- Remove Game Lobby -------///
  removeLobby(int opponentId) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    log(_token.toString());
    var body = {"oponent_id": opponentId};
    var _response = await _networkBase.post(_removeLobby, body,
        needToken: true, token: _token);
    ErrorResponse response = ErrorResponse.fromJson(_response);
    log(response.message.toString());
    return response.message;
  }

  //----- Remove Game Lobby Random------//
  removeLobbyRandom() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response = await _networkBase.get(_removeLobbyRandom,
        needToken: true, token: _token);
    ErrorResponse response = ErrorResponse.fromJson(_response);
    log(response.message.toString());
    return response.message;
  }

  makeOffline() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response = await _networkBase.get(_makeOfflineForRandom,
        needToken: true, token: _token);
    ErrorResponse response = ErrorResponse.fromJson(_response);
    log(response.message.toString());
    return response.message;
  }

  Future<List<UsersRankInCountryResponse>> fetchUsersRankInCountry() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response =
        await _networkBase.get(_rankInCountry, needToken: true, token: _token);
    List<UsersRankInCountryResponse> _responses = [];
    if (_response.runtimeType.toString() == "List<dynamic>") {
      _response.forEach((element) {
        _responses.add(UsersRankInCountryResponse.fromJson(element));
      });
      return _responses;
    } else {
      return _responses;
    }
  }

  Future<YourStatResponse> fetchUserStats(
      YourStatRequest yourStatRequest) async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response = await _networkBase.post(
        _scoreStats, yourStatRequest.toJson(),
        needToken: true, token: _token);
    YourStatResponse _responses = YourStatResponse.fromJson(_response);
    return _responses;
  }

  Future<List<LeaderboardDetailsSectionResponse>>
      fetchLeaderboardDetailSection() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response = await _networkBase.get(_leaderboardDetailsSection,
        needToken: true, token: _token);
    List<LeaderboardDetailsSectionResponse> _responses = [];
    if (_response.runtimeType.toString() == "List<dynamic>") {
      _response.forEach((element) {
        _responses.add(LeaderboardDetailsSectionResponse.fromJson(element));
      });
      return _responses;
    } else {
      return _responses;
    }
  }

  Future<CountryRankResponse> fetchCountryRankOfUser() async {
    var _token = await _appSharedPreferences.getChildAccessToken();
    var _response = await _networkBase.get(_leaderboardCountry,
        needToken: true, token: _token);
    CountryRankResponse _responses = CountryRankResponse.fromJson(_response);
    return _responses;
  }

  //   Future<ProvinceRankResponse> fetchProvinceRankOfUser() async {
  //   var _token = await _appSharedPreferences.getChildAccessToken();
  //   var _response = await _networkBase.get(_leaderboardProvince,
  //       needToken: true, token: _token);
  //   ProvinceRankResponse _responses = ProvinceRankResponse.fromJson(_response);
  //   return _responses;
  // }
}
