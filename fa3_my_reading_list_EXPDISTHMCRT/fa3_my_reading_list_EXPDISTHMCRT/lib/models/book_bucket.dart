import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';

class BookBucket {
  const BookBucket({
    required this.status,
    required this.books,
  });

  final ReadingStatus status;
  final List<Book> books;

  BookBucket.forStatus(List<Book> allBooks, this.status)
      : books = allBooks.where((book) => book.status == status).toList();

  int get totalBooks {
    return books.length;
  }
}