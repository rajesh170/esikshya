class SubmitAnswerRequest {
  String? correctAnswer;

  SubmitAnswerRequest({this.correctAnswer});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['correct_answer'] = correctAnswer;
    return data;
  }
}
