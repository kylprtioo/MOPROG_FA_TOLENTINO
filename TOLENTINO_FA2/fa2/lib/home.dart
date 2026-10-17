import 'package:flutter/material.dart';
import 'package:fa2/data/questions_data.dart';
import 'package:fa2/model/question.dart';
import 'package:fa2/screens/start_screen.dart';
import 'package:fa2/screens/question_screen.dart';
import 'package:fa2/screens/results_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var activeScreen = 'start-screen';
  List<Question> roundQuestions = [];
  final List<String> pickedAnswers = [];
  var score = 0;

  void startQuiz() {
    setState(() {
      final randomizedList = List<Question>.from(questionsData);
      randomizedList.shuffle();
      roundQuestions = randomizedList.take(5).toList();

      pickedAnswers.clear();
      score = 0;
      activeScreen = 'question-screen';
    });
  }

  void recordAnswer(bool isCorrect, String answer) {
    pickedAnswers.add(answer);
    if (isCorrect) {
      score++;
    }
  }

  void finishQuiz() {
    setState(() {
      activeScreen = 'results-screen';
    });
  }

  void returnHome() {
    setState(() {
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = StartScreen(startQuiz);

    if (activeScreen == 'question-screen') {
      currentScreen = QuestionScreen(
        questions: roundQuestions,
        onAnswer: recordAnswer,
        onFinish: finishQuiz,
        onExit: returnHome,
      );
    } else if (activeScreen == 'results-screen') {
      currentScreen = ResultsScreen(
        score: score,
        total: roundQuestions.length,
        selectedAnswers: pickedAnswers,
        onRestart: returnHome,
      );
    }

    return MaterialApp(
      title: 'FA2 Quiz App',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 183, 28, 28),
        body: Center(
          child: currentScreen,
        ),
      ),
    );
  }
}