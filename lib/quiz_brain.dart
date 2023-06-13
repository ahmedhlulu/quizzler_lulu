import 'package:quizzler_lulu/question.dart';

class QuizBrain {
  int questionNo = 0;

  final List<Question> _questionBank = [
    Question(
      questionText: 'You can Lead a cow down stairs but not up stairs.',
      questionAnswer: false,
    ),
    Question(
      questionText: 'Approximately one quarter of human bones are in the feet.',
      questionAnswer: true,
    ),
    Question(
      questionText: 'A slug\'s blood is green.',
      questionAnswer: true,
    ),
  ];

  String getQuestionText() => _questionBank[questionNo].questionText;

  bool getQuestionAnswer() => _questionBank[questionNo].questionAnswer;

  void nextQuestion() {
    if(questionNo < _questionBank.length -1){
      questionNo++;
    }
  }

}

