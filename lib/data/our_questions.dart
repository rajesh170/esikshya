import 'package:esikshya/models/quiz_models/options.dart';
import 'package:esikshya/models/quiz_models/quiz_model.dart';

class OurQuestion {
  static var question = [
    Question(
      question: "Which planet is the biggest planet?",
      options: [
        Options(optionNumber: "A", optionText: "Earth", isCorrect: false),
        Options(optionNumber: "B", optionText: "Jupiter", isCorrect: true),
        Options(optionNumber: "C", optionText: "Saturn", isCorrect: false),
        Options(optionNumber: "D", optionText: "Venus", isCorrect: false),
      ],
      solution: "Jupiter is  the biggest Planet",
    ),
    Question(
      question: "Which planet is the smallest one?",
      options: [
        Options(optionNumber: "A", optionText: "Earth", isCorrect: false),
        Options(optionNumber: "B", optionText: "Jupiter", isCorrect: false),
        Options(optionNumber: "C", optionText: "Saturn", isCorrect: false),
        Options(optionNumber: "D", optionText: "Venus", isCorrect: true),
      ],
      solution: "Venus is  the smallest one",
    ),
    Question(
      question: "Which planet has  life?",
      options: [
        Options(optionNumber: "A", optionText: "Earth", isCorrect: true),
        Options(optionNumber: "B", optionText: "Jupiter", isCorrect: false),
        Options(optionNumber: "C", optionText: "Saturn", isCorrect: false),
        Options(optionNumber: "D", optionText: "Venus", isCorrect: false),
      ],
      solution: "Earth has life",
    ),
  ];
}
