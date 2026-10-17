import 'package:flutter/material.dart';
import 'gradient_container.dart';

  const startAlignment = Alignment.topLeft;
  const endAlignment = Alignment.bottomRight;

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 197, 225, 245),
        body: Center(
          child: GradientContainer(
            fullName: 'KYLER LI P. TOLENTINO',
            course: 'BS APPLIED MATHEMATICS WITH SPECIALIZATION IN IT',
            bio: '"Horror games enthusiast and bedroom pop listener"',
            gradientColors: const[
              Color.fromARGB(255, 155, 120, 50),
              Color.fromARGB(255, 10, 16, 32),
              Color.fromARGB(255, 10, 16, 32),
              Color.fromARGB(255, 155, 120, 50),
            ],
            startAlignment: startAlignment,
            endAlignment: endAlignment,
          ),
        ),
      ),
    ), 
  );
}