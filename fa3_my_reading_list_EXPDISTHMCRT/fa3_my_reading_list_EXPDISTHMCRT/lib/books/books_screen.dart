import 'package:fa3_my_reading_list_expdisthmcrt/books/books_list.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/books/new_book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/books/reading_summary.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/chart/chart.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  final void Function() onToggleTheme;
  final bool isDarkMode;

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final List<String> _genres = List.from(defaultGenres);

  final List<Book> registeredBooks = [
    Book(
      title: 'The Witcher: The Last Wish',
      author: 'Andrzej Sapkowski',
      pages: 288,
      rating: 5,
      genre: 'Dark Fantasy',
      status: ReadingStatus.finished,
    ),
    Book(
      title: 'Metro 2033',
      author: 'Dmitry Glukhovsky',
      pages: 458,
      rating: 4,
      genre: 'Post-Apocalyptic',
      status: ReadingStatus.reading,
    ),
    Book(
      title: 'Cyberpunk 2077: No Coincidence',
      author: 'Rafal Kosik',
      pages: 384,
      rating: 5,
      genre: 'Cyberpunk',
      status: ReadingStatus.wantToRead,
    ),
    Book(
      title: 'Fables: Legends in Exile',
      author: 'Bill Willingham',
      pages: 128,
      rating: 4,
      genre: 'Detective Noir',
      status: ReadingStatus.finished,
    ),
  ];

  void _addGenre(String newGenre) {
    setState(() {
      _genres.add(newGenre);
    });
  }

  void _openBookModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewBook(
        addBook: _addBook,
        genres: _genres,
        onAddGenre: _addGenre,
      ),
    );
  }

  void _addBook(Book book) {
    setState(() {
      registeredBooks.add(book);
    });
  }

  void _updateStatus(Book book, ReadingStatus newStatus) {
    setState(() {
      book.status = newStatus;
    });
  }

  void _removeBook(Book book) {
    final bookIndex = registeredBooks.indexOf(book);

    setState(() {
      registeredBooks.remove(book);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${book.title}" removed.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredBooks.insert(bookIndex, book);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    Widget mainContent = Center(
      child: Text(
        'No books found. Start adding some!',
        style: TextStyle(
          color: isDark ? Colors.white70 : Colors.black54,
          fontSize: 16,
        ),
      ),
    );

    if (registeredBooks.isNotEmpty) {
      mainContent = BooksList(
        books: registeredBooks,
        removeBook: _removeBook,
        updateStatus: _updateStatus,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Reading List',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          IconButton(
            onPressed: _openBookModal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(books: registeredBooks),
          ReadingSummary(books: registeredBooks),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}