class Question {
  const Question({
    required this.text,
    this.imagePath,
    required this.answers,
  });

  final String text;
  final String? imagePath;
  final List<String> answers;

  String get correctAnswer => answers[0];

  List<String> getShuffledAnswers() {
    final shuffled = List<String>.from(answers);
    shuffled.shuffle();
    return shuffled;
  }
}