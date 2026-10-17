import 'package:flutter/material.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';

class BookItem extends StatelessWidget {
  const BookItem(
    this.book, {
    super.key,
    required this.onStatusChanged,
  });

  final Book book;
  final void Function(ReadingStatus newStatus) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final titleColor = isDark ? Colors.white : const Color(0xFF1A1D26);
    final subtitleColor = isDark ? const Color(0xFFB0B7C3) : const Color(0xFF5A6070);
    final detailColor = isDark ? const Color(0xFF8A94A6) : const Color(0xFF717786);
    final accentColor = isDark ? const Color(0xFFA78BFA) : const Color(0xFF6B4EE6);
    final badgeBgColor = isDark ? const Color(0xFF262C40) : const Color(0xFFEDE9FE);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    book.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: accentColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: DropdownButton<ReadingStatus>(
                    value: book.status,
                    underline: const SizedBox(),
                    dropdownColor: isDark ? const Color(0xFF1B2030) : Colors.white,
                    icon: Icon(Icons.arrow_drop_down, color: accentColor, size: 20),
                    items: ReadingStatus.values.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              statusIcons[status],
                              size: 15,
                              color: accentColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              statusLabels[status]!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (newStatus) {
                      if (newStatus != null) {
                        onStatusChanged(newStatus);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'by ${book.author}',
              style: TextStyle(
                fontSize: 13,
                color: subtitleColor,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  '${book.pages} pages',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: detailColor,
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < book.rating ? Icons.star : Icons.star_border,
                      size: 16,
                      color: Colors.amber,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      genreIconMap[book.genre] ?? Icons.book,
                      size: 17,
                      color: accentColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      book.genre.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 0.5,
                        color: accentColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}