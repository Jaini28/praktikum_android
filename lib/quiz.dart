import 'package:flutter/material.dart';
import 'package:praktikummobile/home_screen.dart';
import 'package:praktikummobile/question_screen.dart';
import 'package:praktikummobile/result_screen.dart';
import 'package:praktikummobile/profile.dart'; // Pastikan file profile.dart ada
import 'package:praktikummobile/datas/question.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  final List<String> selectedAnswer = [];

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void showProfileScreen() {
    setState(() {
      activeScreen = 'profile-screen';
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer.clear();
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget;

    if (activeScreen == 'start-screen') {
      screenWidget = HomeScreen(
        startQuiz: switchScreen,
        profile: showProfileScreen, // Panggilan ke fungsi showProfileScreen
      );
    } else if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    } else if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        choosenAnswers: selectedAnswer,
        onRestart: restartQuiz,
      );
    } else if (activeScreen == 'profile-screen') {
      screenWidget = const Profile(); // Pastikan class Profile ada
    } else {
      screenWidget = const Center(
        child: Text('Unknown screen!'),
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
