class WrongAnswerResponse {
  String? type;
  String? message;
  String? correctAnswer;
  int? score;
  int? oscore;

  WrongAnswerResponse(
      {this.type, this.message, this.correctAnswer, this.score, this.oscore});

  WrongAnswerResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    correctAnswer = json['correct_answer'];
    score = json['score'];
    oscore = json['oscore'];
  }
}
