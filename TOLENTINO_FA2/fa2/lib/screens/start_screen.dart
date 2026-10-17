import 'package:flutter/material.dart';
import 'package:fa2/commons/styled_text.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            const StyledText('Filipino Stews Quiz', 32, color: Colors.white),
            const StyledText(
              'Can you tell the difference between Mechado, Menudo, Afritada, and Kaldereta?',
              18,
              color: Colors.white70,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: startQuiz,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 2),
                backgroundColor: const Color.fromARGB(255, 211, 47, 47),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              icon: const Icon(Icons.restaurant_menu),
              label: const StyledText('Start Quiz', 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}