import 'package:flutter/material.dart';
import 'package:fa2/commons/styled_text.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.score,
    required this.total,
    required this.selectedAnswers,
    required this.onRestart,
  });

  final int score;
  final int total;
  final List<String> selectedAnswers;
  final void Function() onRestart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            const StyledText('Quiz Completed!', 32, color: Colors.white),
            StyledText(
              'You got $score out of $total correct!',
              24,
              color: Colors.yellowAccent,
            ),
            const SizedBox(height: 15),
            const StyledText('Your Selected Answers:', 20, color: Colors.white),
            ...selectedAnswers.asMap().entries.map(
              (entry) => StyledText(
                '${entry.key + 1}. ${entry.value}',
                18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: onRestart,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 2),
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              icon: const Icon(Icons.refresh),
              label: const StyledText('Restart Quiz', 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}