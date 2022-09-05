class LeaderboardDetailsSectionResponse {
  int? yourPoints;
  String? message;
  int? opPoints;

  LeaderboardDetailsSectionResponse(
      {this.yourPoints, this.message, this.opPoints});

  LeaderboardDetailsSectionResponse.fromJson(Map<String, dynamic> json) {
    yourPoints = json['your_points'];
    message = json['message'];
    opPoints = json['op_points'];
  }

}
