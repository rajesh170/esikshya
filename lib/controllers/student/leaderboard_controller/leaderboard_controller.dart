import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/request/student/leader_board_request/your_stat_request.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/country_rank_response.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/leaderboard_details_section_response.dart';
// import 'package:esikshya/models/network_models/response/leaderboard_responses/province_rank_Response.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/users_rank_in_country_response.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/your_stat_response.dart';
import 'package:esikshya/utils/app_widgets.dart';

class LeaderboardController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    fetchCountryRank();
    //fetchProvinceRank();
    super.onInit();
  }

  final NetworkCalls _networkCalls = NetworkCalls();
  var selectedMonth = DateFormat.LLLL().format(DateTime.now()).toString().obs;
  var gamePlayed = "0".obs;
  var quizWon = "0".obs;
  var countryRank = "".obs;
  var provinceRank = "".obs;
  var totalPoints = "".obs;

  Future<List<UsersRankInCountryResponse>?> fetchUsersRankInCountry(
      BuildContext context) async {
    try {
      return await _networkCalls.fetchUsersRankInCountry();
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  Future<YourStatResponse?> fetchYourStat(
      BuildContext context, int selectedMonth) async {
    try {
      var year = int.parse(DateFormat.y().format(DateTime.now()));
      var month = selectedMonth;
      YourStatRequest _yourStatRequest =
          YourStatRequest(year: year, month: month);
      var _response = await _networkCalls.fetchUserStats(_yourStatRequest);
      quizWon.value = _response.quizWon.toString();
      gamePlayed.value = _response.gamePlayed.toString();
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  Future<List<LeaderboardDetailsSectionResponse>?>
      fetchLeaderboardDetailSection(BuildContext context) async {
    try {
      var _response = await _networkCalls.fetchLeaderboardDetailSection();
      print(_response);
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  Future<CountryRankResponse?> fetchCountryRank() async {
    try {
      CountryRankResponse _response =
          await _networkCalls.fetchCountryRankOfUser();
      totalPoints.value = _response.points.toString();
      countryRank.value =
          (int.parse(_response.countryRank.toString()) + 1).toString();
    } catch (e) {
      Get.snackbar("title", e.toString());
    }
  }

  // Future<ProvinceRankResponse?> fetchProvinceRank() async {
  //   try {
  //     ProvinceRankResponse _response =
  //         await _networkCalls.fetchProvinceRankOfUser();
  //     totalPoints.value = _response.points.toString();
  //     provinceRank.value =
  //         (int.parse(_response.stateRank.toString()) + 1).toString();
  //   } catch (e) {
  //     Get.snackbar("title", e.toString());
  //   }
  // }
}
