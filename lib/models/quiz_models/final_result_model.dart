class FinalResultResponse {
  String? type;
  String? message;
  int? score;
  int? oscore;
  String? yourName;
  String? opName;

  FinalResultResponse(
      {this.type,
      this.message,
      this.score,
      this.oscore,
      this.yourName,
      this.opName});

  FinalResultResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    score = json['score'];
    oscore = json['oscore'];
    yourName = json['your_name'];
    opName = json['op_name'];
  }
}
