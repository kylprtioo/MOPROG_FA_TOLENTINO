import 'package:fa3_my_reading_list_expdisthmcrt/books/book_item.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';

class BooksList extends StatelessWidget {
  const BooksList({
    super.key,
    required this.books,
    required this.removeBook,
    required this.updateStatus,
  });

  final List<Book> books;
  final void Function(Book book) removeBook;
  final void Function(Book book, ReadingStatus newStatus) updateStatus;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (ctx, index) {
        final book = books[index];
        return Dismissible(
          key: ValueKey(book.id),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white, size: 28),
          ),
          onDismissed: (direction) {
            removeBook(book);
          },
          child: BookItem(
            book,
            onStatusChanged: (newStatus) {
              updateStatus(book, newStatus);
            },
          ),
        );
      },
    );
  }
}