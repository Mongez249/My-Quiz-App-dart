import 'package:flutter/material.dart';
import 'package:qize_app/data/questions.dart';
import 'package:qize_app/results_screen.dart';
import 'package:qize_app/decoration_container.dart';
import 'package:qize_app/questions_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(
      () {
        activeScreen = 'questions-screen';
      },
    );
  }

  void chosedAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(context) {
    Widget activeWidget = DecorationContainer(switchScreen);
    if (activeScreen == 'questions-screen') {
      activeWidget = QuestionsScreen(
        onSelectAnswer: chosedAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      activeWidget = ResultsScreen(
        restartQuiz,
        chosenAnswers: selectedAnswers,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 8, 34, 56),
                Color.fromARGB(255, 15, 48, 104),
                Color.fromARGB(255, 25, 119, 196),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: activeWidget,
        ),
      ),
    );
  }
}
