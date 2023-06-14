import 'package:flutter/material.dart';
import 'package:quizzler_lulu/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> iconList = [];
  List<Icon> iconList2 = [];

  Icon iconTrue = const Icon(Icons.check, color: Colors.green);
  Icon iconFalse = const Icon(Icons.close, color: Colors.red);

  QuizBrain quizBrain = QuizBrain();

  int score = 0;
  int scoreFinish = 0;

  void checkAnswerChoice(bool userChoice) {
    setState(() {
      if (quizBrain.getQuestionAnswer() == userChoice) {
        iconList.add(iconTrue);
        score += 1;
      } else {
        iconList.add(iconFalse);
      }
      quizBrain.nextQuestion();
    });
  }

  void reset(){
    setState(() {
      iconList2 = iconList;
      iconList = [];
      scoreFinish = score;
      score = 0;
      quizBrain.reset();
    });
  }

  void setAlert(){
    Alert(
      context: context,
      title: "You are done!",
      desc: "Your Score is: $scoreFinish / ${quizBrain.questionsLength()}",
      content: Wrap(children: iconList2),
      type: AlertType.success,
      onWillPopActive: true,
      style: AlertStyle(
        isCloseButton: false,
        backgroundColor: Colors.grey.shade800,
        titleStyle: TextStyle(color: Colors.white),
        descStyle: TextStyle(color: Colors.white),
      ),
    ).show();
  }

  void checkAnswer(bool userChoice) {
    if (quizBrain.isFinished()) {
      checkAnswerChoice(userChoice);
      reset();
      setAlert();
    } else {
      checkAnswerChoice(userChoice);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        Wrap(children: iconList, alignment: WrapAlignment.center),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () => checkAnswer(true),
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
              child: const Text(
                "True",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () => checkAnswer(false),
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
              child: const Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
