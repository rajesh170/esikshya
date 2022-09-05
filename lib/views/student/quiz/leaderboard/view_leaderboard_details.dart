import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esikshya/controllers/student/leaderboard_controller/leaderboard_controller.dart';
import 'package:esikshya/models/network_models/response/leaderboard_responses/leaderboard_details_section_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ViewLeaderboardDetailsWidget extends StatelessWidget {
  const ViewLeaderboardDetailsWidget({
    Key? key,
    required this.leaderboardController,
  }) : super(key: key);
  final LeaderboardController leaderboardController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: leaderboardController.fetchLeaderboardDetailSection(context),
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? snapshot.data.length > 0
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        LeaderboardDetailsSectionResponse
                            _leaderboardDetailsSectionResponse =
                            snapshot.data[index];
                        return DetailsItemWidget(
                          leaderboardDetailsSectionResponse:
                              _leaderboardDetailsSectionResponse,
                        );
                      })
                  : TextWidget("No Data to show")
              : const SizedBox();
        });
  }
}

class DetailsItemWidget extends StatelessWidget {
  const DetailsItemWidget(
      {Key? key, required this.leaderboardDetailsSectionResponse})
      : super(key: key);
  final LeaderboardDetailsSectionResponse leaderboardDetailsSectionResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(
              color: AppColors.greyText,
              width: 1.w,
            ),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            leaderboardDetailsSectionResponse.message.toString(),
            styles: TextStyles.size14_700,
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget(
                  "You:${leaderboardDetailsSectionResponse.yourPoints.toString()}"),
              SizedBox(
                width: 10.w,
              ),
              TextWidget(
                  "Op. :${leaderboardDetailsSectionResponse.opPoints.toString()}"),
            ],
          )
        ],
      ),
    );
  }
}
