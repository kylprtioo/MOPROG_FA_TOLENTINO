import 'package:flutter/material.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';

class ReadingSummary extends StatelessWidget {
  const ReadingSummary({super.key, required this.books});

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final totalBooks = books.length;
    final finishedCount =
        books.where((b) => b.status == ReadingStatus.finished).length;

    final avgRating = books.isEmpty
        ? 0.0
        : books.fold(0.0, (sum, b) => sum + b.rating) / totalBooks;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  '$totalBooks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? const Color(0xFF9B84EC) : const Color(0xFF6B4EE6),
                  ),
                ),
                Text(
                  'Total Books',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '$finishedCount',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? const Color(0xFF82B1FF) : const Color(0xFF2979FF),
                  ),
                ),
                Text(
                  'Finished',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  books.isEmpty ? '0.0 ★' : '${avgRating.toStringAsFixed(1)} ★',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[600],
                  ),
                ),
                Text(
                  'Avg Rating',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}