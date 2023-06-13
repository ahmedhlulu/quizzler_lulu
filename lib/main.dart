import 'package:flutter/material.dart';
import 'package:quizzler_lulu/quiz_brain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Icon> iconList = [];
  Icon iconTrue = const Icon(Icons.check,color: Colors.green);
  Icon iconFalse = const Icon(Icons.close,color: Colors.red);

  QuizBrain quizBrain = QuizBrain();

  void checkAnswer(bool userChoice){
    setState(() {
      if(quizBrain.getQuestionAnswer() == userChoice) {
        iconList.add(iconTrue);
      }else {
        iconList.add(iconFalse);
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: Column(
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
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
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
            Row(children: iconList),
          ],
        ),
      ),
    );
  }
}
