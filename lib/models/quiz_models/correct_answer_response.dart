class CorrectAnswerResponse {
  String? type;
  String? message;
  int? score;
  int? oscore;

  CorrectAnswerResponse({this.type, this.message, this.score, this.oscore});

  CorrectAnswerResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    score = json['score'];
    oscore = json['oscore'];
  }
}
