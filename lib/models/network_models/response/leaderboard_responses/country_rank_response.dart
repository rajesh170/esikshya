class CountryRankResponse {
  int? countryRank;
  String? country;
  int? points;

  CountryRankResponse({this.countryRank, this.country, this.points});

  CountryRankResponse.fromJson(Map<String, dynamic> json) {
    countryRank = json['country_rank'];
    country = json['country'];
    points = json['points'];
  }
}
