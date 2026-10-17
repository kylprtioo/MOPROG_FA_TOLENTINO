import 'package:flutter/material.dart';
import 'package:fa2/commons/styled_text.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.text, required this.onPressed});

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 217, 188),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: StyledText(text, 18, color: const Color.fromARGB(255, 183, 28, 28)),
    );
  }
}