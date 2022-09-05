class YourRankInStateResponse {
  int? stateRank;
  String? state;
  int? points;

  YourRankInStateResponse({this.stateRank, this.state, this.points});

  YourRankInStateResponse.fromJson(Map<String, dynamic> json) {
    stateRank = json['state_rank'];
    state = json['state'];
    points = json['points'];
  }

}
