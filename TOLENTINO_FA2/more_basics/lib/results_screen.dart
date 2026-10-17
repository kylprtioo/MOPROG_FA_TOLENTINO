import 'package:flutter/material.dart';
import 'package:more_basics/commons/styled_button.dart';
import 'package:more_basics/commons/styled_text.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.answers, required this.onExit});

  final List<String> answers;
  final void Function() onExit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10, 
          children: [
            StyledText('Results:', 25, color: Colors.white),
            ...answers.map(
              (answer) => StyledButton(
                text: answer,
                onPressed: () {}, 
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: onExit,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.exit_to_app),
              label: StyledText('Exit', 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}