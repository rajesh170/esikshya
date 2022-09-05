class UsersRankInCountryResponse {
  int? rank;
  int? userId;
  String? name;
  int? grade;
  int? score;
  bool? you;

  UsersRankInCountryResponse(
      {this.rank, this.userId, this.name, this.grade, this.score, this.you});

  UsersRankInCountryResponse.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    userId = json['user_id'];
    name = json['name'];
    grade = json['grade'];
    score = json['score'];
    you = json['you'];
  }

}
