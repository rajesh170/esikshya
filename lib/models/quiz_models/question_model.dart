class QuestionModelResponse {
  String? type;
  int? id;
  String? questions;
  String? optionsA;
  String? optionsB;
  String? optionsC;
  String? optionsD;
  String? correct;

  QuestionModelResponse(
      {this.type,
      this.id,
      this.questions,
      this.optionsA,
      this.optionsB,
      this.optionsC,
      this.optionsD,
      this.correct});

  QuestionModelResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    questions = json['questions'];
    optionsA = json['options_a'];
    optionsB = json['options_b'];
    optionsC = json['options_c'];
    optionsD = json['options_d'];
    correct = json['correct'];
  }
}
