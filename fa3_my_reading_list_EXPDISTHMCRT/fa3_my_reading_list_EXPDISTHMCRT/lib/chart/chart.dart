import 'package:fa3_my_reading_list_expdisthmcrt/chart/chart_bar.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book_bucket.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.books});

  final List<Book> books;

  List<BookBucket> get buckets {
    return [
      BookBucket.forStatus(books, ReadingStatus.wantToRead),
      BookBucket.forStatus(books, ReadingStatus.reading),
      BookBucket.forStatus(books, ReadingStatus.finished),
    ];
  }

  int get maxTotalBooks {
    int max = 0;
    for (final bucket in buckets) {
      if (bucket.totalBooks > max) {
        max = bucket.totalBooks;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: 195,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1B2030) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2C3249) : const Color(0xFFE2E4EC),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.35 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    count: bucket.totalBooks,
                    fill: maxTotalBooks == 0
                        ? 0.04
                        : (bucket.totalBooks == 0
                            ? 0.04
                            : bucket.totalBooks / maxTotalBooks),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets.map((bucket) {
              return Expanded(
                child: Column(
                  children: [
                    Icon(
                      statusIcons[bucket.status],
                      size: 20,
                      color: isDark ? const Color(0xFF9B84EC) : const Color(0xFF6B4EE6),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      statusLabels[bucket.status]!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}