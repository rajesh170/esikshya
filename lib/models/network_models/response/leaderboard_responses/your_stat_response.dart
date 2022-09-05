class YourStatResponse {
  int? gamePlayed;
  int? quizWon;

  YourStatResponse({this.gamePlayed, this.quizWon});

  YourStatResponse.fromJson(Map<String, dynamic> json) {
    gamePlayed = json['game_played'];
    quizWon = json['quiz_won'];
  }
}
