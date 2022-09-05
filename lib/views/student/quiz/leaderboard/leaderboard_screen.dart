import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/student/leaderboard_controller/leaderboard_controller.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/leaderboard_details_section_response.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/users_rank_in_country_response.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/your_stat_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/quiz/leaderboard/view_leaderboard_details.dart';
import 'package:esikshya/views/student/quiz/leaderboard/view_stat_widget.dart';
import 'package:esikshya/views/student/quiz_with_friends/quiz_dashboard.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sharedPref = Get.find<AppSharedPreferences>();
    LeaderboardController _leaderboardController =
        Get.put(LeaderboardController());
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: DefaultTabController(
                length: 3,
                child: NestedScrollView(
                  headerSliverBuilder: (context, value) {
                    return [
                      SliverAppBar(
                          elevation: 1.h,
                          expandedHeight: Get.height * 0.35,
                          automaticallyImplyLeading: false,
                          backgroundColor: AppColors.white,
                          pinned: true,
                          floating: true,
                          bottom: TabBar(
                            indicatorPadding: EdgeInsets.zero,
                            indicatorColor: AppColors.purpleBlue,
                            unselectedLabelColor:
                                AppColors.white.withOpacity(0.8),
                            unselectedLabelStyle: TextStyle(
                              color: AppColors.greyText,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Montserrat",
                            ),
                            labelPadding: EdgeInsets.zero,

                            // labelStyle: TextStyle(
                            //   color: AppColors.white,
                            //   fontSize: 12.sp,
                            //   fontWeight: FontWeight.w700,
                            //   fontFamily: "Montserrat",
                            // ),
                            tabs: const [
                              TabBarTitleWidget(title: "Leaderboard"),
                              TabBarTitleWidget(title: "Stats"),
                              TabBarTitleWidget(title: "Details"),
                            ],
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Column(
                              children: const [
                                BuildHead(),
                                LeaderboardRank(),
                              ],
                            ),
                          )),
                    ];
                  },
                  body: SizedBox(
                    // height: Get.height,
                    // width: Get.width,
                    child: TabBarView(children: [
                      UsersRankWidget(
                        leaderboardController: _leaderboardController,
                      ),
                      ViewStatWidget(
                        leaderboardController: _leaderboardController,
                      ),
                      ViewLeaderboardDetailsWidget(
                        leaderboardController: _leaderboardController,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class UsersRankWidget extends StatelessWidget {
  const UsersRankWidget({
    Key? key,
    required this.leaderboardController,
  }) : super(key: key);
  final LeaderboardController leaderboardController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: leaderboardController.fetchUsersRankInCountry(context),
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    UsersRankInCountryResponse _userRankInCountryResponse =
                        snapshot.data[index];
                    return RankItemsWidget(
                        userRankInCountryResponse: _userRankInCountryResponse);
                  })
              : const SizedBox();
        });
  }
}

class RankItemsWidget extends StatelessWidget {
  const RankItemsWidget({
    Key? key,
    required this.userRankInCountryResponse,
  }) : super(key: key);
  final UsersRankInCountryResponse userRankInCountryResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            (userRankInCountryResponse.rank! + 1).toString(),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: TextWidget(
                  userRankInCountryResponse.name.toString(),
                  styles: TextStyles.size12_600,
                  color: AppColors.black,
                ),
              ),
              TextWidget(
                "Class: ${userRankInCountryResponse.grade.toString()}",
                styles: TextStyles.size10_400,
                color: AppColors.darkGrey,
              ),
            ],
          ),
          SizedBox(width: 15.w),
          TextWidget(
            userRankInCountryResponse.you! ? "You" : "",
            styles: TextStyles.size10_600,
            color: AppColors.red,
          ),
          const Spacer(),
          TextWidget(
            userRankInCountryResponse.score.toString(),
            styles: TextStyles.size16_600,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }
}

class TabBarTitleWidget extends StatelessWidget {
  const TabBarTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.05,
      width: Get.width,
      color: AppColors.white,
      child: Center(
        child: TextWidget(title),
      ),
    );
  }
}


  // FutureBuilder(
                  //     future: _sharedPref.getChildUserName(),
                  //     builder: (context, AsyncSnapshot snapshot) {
                  //       return snapshot.data != ""
                  //           ? TextWidget(
                  //               "Hi, ${snapshot.data.toString().capitalizeFirst}",
                  //               styles: TextStyles.size18_600,
                  //             )
                  //           : TextWidget(
                  //               "Hi, Anonymous",
                  //               styles: TextStyles.size18_600,
                  //             );
                  //     }),