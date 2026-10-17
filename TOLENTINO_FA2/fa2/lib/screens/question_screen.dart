import 'package:flutter/material.dart';
import 'package:fa2/commons/styled_button.dart';
import 'package:fa2/commons/styled_text.dart';
import 'package:fa2/model/question.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.questions,
    required this.onAnswer,
    required this.onFinish,
    required this.onExit,
  });

  final List<Question> questions;
  final void Function(bool isCorrect, String selectedAnswer) onAnswer;
  final void Function() onFinish;
  final void Function() onExit;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var questionIndex = 0;
  late List<String> shuffledChoices;

  @override
  void initState() {
    super.initState();
    shuffledChoices = widget.questions[questionIndex].getShuffledAnswers();
  }

  void chooseAnswer(String answer) {
    final currentQuestion = widget.questions[questionIndex];
    final bool isCorrect = answer == currentQuestion.correctAnswer;
    widget.onAnswer(isCorrect, answer);

    setState(() {
      if (questionIndex < widget.questions.length - 1) {
        questionIndex++;
        shuffledChoices = widget.questions[questionIndex].getShuffledAnswers();
      } else {
        widget.onFinish();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[questionIndex];

    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            StyledText(
              'Question ${questionIndex + 1} of ${widget.questions.length}',
              16,
              color: Colors.white70,
            ),
            if (currentQuestion.imagePath != null)
              Image.asset(
                currentQuestion.imagePath!,
                height: 180,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 8),
            StyledText(currentQuestion.text, 20, color: Colors.white),
            const SizedBox(height: 12),
            ...shuffledChoices.map(
              (choice) => StyledButton(
                text: choice,
                onPressed: () {
                  chooseAnswer(choice);
                },
              ),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: widget.onExit,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                backgroundColor: const Color.fromARGB(255, 211, 47, 47),
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.exit_to_app),
              label: const StyledText('Exit', 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}