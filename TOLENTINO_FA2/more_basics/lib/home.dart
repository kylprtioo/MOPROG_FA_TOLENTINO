import 'package:flutter/material.dart';
import 'package:more_basics/home_screen.dart';
import 'package:more_basics/profile/profile_screen.dart';
import 'package:more_basics/results_screen.dart'; 

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var activeScreen = 'home-screen';
  List<String> userSelections = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'profile-screen';
      userSelections = [];
    });
  }

  void goHome() {
    setState(() {
      activeScreen = 'home-screen';
    });
  }

  void finishQuiz(List<String> answers) {
    setState(() {
      userSelections = answers;
      activeScreen = 'results-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = HomeScreen(switchScreen);

    if (activeScreen == 'profile-screen') {
      currentScreen = ProfileScreen(
        onExit: goHome,
        onFinish: finishQuiz,
      );
    } else if (activeScreen == 'results-screen') {
      currentScreen = ResultsScreen(
        answers: userSelections,
        onExit: goHome,
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: currentScreen,
        ),
      ),
    );
  }
}