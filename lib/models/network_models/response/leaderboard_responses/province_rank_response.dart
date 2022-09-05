class ProvinceRankResponse {
  int? stateRank;
  String? state;
  int? points;

  ProvinceRankResponse({this.stateRank, this.state, this.points});

  ProvinceRankResponse.fromJson(Map<String, dynamic> json) {
    stateRank = json['state_rank'];
    state = json['state'];
    points = json['points'];
  }
}
