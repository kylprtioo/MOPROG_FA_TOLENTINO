import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final List<String> defaultGenres = [
  'Dark Fantasy',
  'Post-Apocalyptic',
  'Cyberpunk',
  'Detective Noir',
];

const Map<String, IconData> genreIconMap = {
  'Dark Fantasy': Icons.shield,
  'Post-Apocalyptic': Icons.masks,
  'Cyberpunk': Icons.memory,
  'Detective Noir': Icons.search,
};

enum ReadingStatus {
  wantToRead,
  reading,
  finished,
}

const statusLabels = {
  ReadingStatus.wantToRead: 'Want to Read',
  ReadingStatus.reading: 'Reading',
  ReadingStatus.finished: 'Finished',
};

const statusIcons = {
  ReadingStatus.wantToRead: Icons.bookmark_border,
  ReadingStatus.reading: Icons.hourglass_top,
  ReadingStatus.finished: Icons.check_circle,
};

class Book {
  Book({
    required this.title,
    required this.author,
    required this.pages,
    required this.rating,
    required this.genre,
    required this.status,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final String author;
  final int pages;
  final int rating;
  final String genre;
  ReadingStatus status;
}