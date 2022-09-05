class QuizSearchOpponentRequest {
  int? oponentId;
  String? subject;
  String? status;
  int? grade;

  QuizSearchOpponentRequest(
      {this.oponentId, this.subject, this.status, this.grade});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oponent_id'] = oponentId;
    data['subject'] = subject;
    data['status'] = status;
    data['grade'] = grade;
    return data;
  }
}
