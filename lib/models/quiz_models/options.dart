// these are the  options for quiz

          class Options {
            final String optionNumber; // like A, B, C, D
            final String optionText; // the values for options
            final bool isCorrect; // set this true  for correct option

            Options(
                {required this.optionNumber,
                required this.optionText,
                required this.isCorrect});
          }
