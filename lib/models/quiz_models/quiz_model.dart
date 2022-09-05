        import 'options.dart';

        //this  is  the  model of our quiz.
        class Question {
          final String question;
          final List<Options> options;
          final String solution; // the short description of true  answer
          late final bool islocked; // set this true if user has given answer
          Options? selectedOption; // this  is the  option selected  by user

          Question({
            required this.question,
            required this.options,
            required this.solution,
            this.islocked = false,
            this.selectedOption,
          });
        }
