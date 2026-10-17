import 'package:flutter/material.dart';
import 'styled_text.dart';

class GradientContainer extends StatelessWidget{
  const GradientContainer({
    super.key,
    required this.fullName,
    required this.course,
    required this.bio,
    required this.gradientColors,
    required this.startAlignment,
    required this.endAlignment,
  });

  final String fullName;
  final String course;
  final String bio;
  final List<Color> gradientColors;
  final Alignment startAlignment;
  final Alignment endAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:310,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          stops: const [0.0, 0.18, 0.82, 1.0],
          begin: startAlignment,
          end: endAlignment,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
        color: Colors.black26,
        blurRadius: 12,
        offset: Offset(0,6),
      ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StyledText(
          fullName,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 10),
        StyledText(
          course, 
          fontSize: 13,
          textColor: const Color.fromARGB(255, 200, 210, 230),
        ),
        const SizedBox(height: 14),
        StyledText(
          bio, 
          fontSize: 12,
          fontStyle: FontStyle.italic,
          textColor: const Color.fromARGB(255, 230, 205, 145),
        ),
      ],
    ),
    );
  }
}