import 'package:flutter/material.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';

class NewBook extends StatefulWidget {
  const NewBook({
    super.key,
    required this.addBook,
    required this.genres,
    required this.onAddGenre,
  });

  final void Function(Book book) addBook;
  final List<String> genres;
  final void Function(String newGenre) onAddGenre;

  @override
  State<NewBook> createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _pagesController = TextEditingController();
  final _customGenreController = TextEditingController();

  int _selectedRating = 5;
  late String _selectedGenre;
  ReadingStatus _selectedStatus = ReadingStatus.wantToRead;

  @override
  void initState() {
    super.initState();
    _selectedGenre = widget.genres.first;
  }

  void _openAddCategoryDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1B2030) : Colors.white,
        title: Text(
          'Add New Genre / Category',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: _customGenreController,
          maxLength: 30,
          autofocus: true,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
          ),
          decoration: InputDecoration(
            labelText: 'Genre Name',
            labelStyle: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            hintText: 'ex: Sci-Fi, Psychological Horror',
            hintStyle: TextStyle(
              color: isDark ? Colors.white38 : Colors.black38,
            ),
            counterStyle: TextStyle(
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _customGenreController.clear();
              Navigator.pop(ctx);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = _customGenreController.text.trim();
              if (newName.isNotEmpty) {
                if (!widget.genres.contains(newName)) {
                  widget.onAddGenre(newName);
                }
                setState(() {
                  _selectedGenre = newName;
                });
              }
              _customGenreController.clear();
              Navigator.pop(ctx);
            },
            child: const Text('Add Genre'),
          ),
        ],
      ),
    );
  }

  void _submitBookData() {
    final enteredPages = int.tryParse(_pagesController.text);

    if (_titleController.text.trim().isEmpty ||
        _authorController.text.trim().isEmpty ||
        enteredPages == null ||
        enteredPages <= 0 ||
        _selectedRating < 1 ||
        _selectedRating > 5) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
            'Please verify that all fields are correct:\n'
            '- Title and Author must not be blank.\n'
            '- Pages must be a positive number.\n'
            '- Rating must be between 1 and 5.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    final newBook = Book(
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      pages: enteredPages,
      rating: _selectedRating,
      genre: _selectedGenre,
      status: _selectedStatus,
    );

    widget.addBook(newBook);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pagesController.dispose();
    _customGenreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final itemTextColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              style: TextStyle(color: itemTextColor),
              decoration: InputDecoration(
                labelText: 'Book Title',
                labelStyle: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                counterStyle: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ),
            TextField(
              controller: _authorController,
              maxLength: 35,
              style: TextStyle(color: itemTextColor),
              decoration: InputDecoration(
                labelText: 'Author',
                labelStyle: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                counterStyle: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pagesController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    style: TextStyle(color: itemTextColor),
                    decoration: InputDecoration(
                      labelText: 'Pages',
                      labelStyle: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      counterStyle: TextStyle(
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedRating,
                    dropdownColor:
                        isDark ? const Color(0xFF1B2030) : Colors.white,
                    decoration: const InputDecoration(labelText: 'Rating'),
                    items: [1, 2, 3, 4, 5]
                        .map(
                          (r) => DropdownMenuItem(
                            value: r,
                            child: Text(
                              '$r Stars',
                              style: TextStyle(color: itemTextColor),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedRating = val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedGenre,
                    dropdownColor:
                        isDark ? const Color(0xFF1B2030) : Colors.white,
                    decoration: const InputDecoration(
                      labelText: 'Genre / Category',
                    ),
                    items: widget.genres
                        .map(
                          (genre) => DropdownMenuItem(
                            value: genre,
                            child: Row(
                              children: [
                                Icon(
                                  genreIconMap[genre] ?? Icons.book,
                                  size: 18,
                                  color: isDark
                                      ? const Color(0xFFA78BFA)
                                      : const Color(0xFF6B4EE6),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  genre,
                                  style: TextStyle(color: itemTextColor),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedGenre = val);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _openAddCategoryDialog,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('New Genre'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ReadingStatus>(
              value: _selectedStatus,
              dropdownColor:
                  isDark ? const Color(0xFF1B2030) : Colors.white,
              decoration: const InputDecoration(
                labelText: 'Reading Status',
              ),
              items: ReadingStatus.values
                  .map(
                    (status) => DropdownMenuItem(
                      value: status,
                      child: Row(
                        children: [
                          Icon(
                            statusIcons[status],
                            size: 18,
                            color: isDark
                                ? const Color(0xFFA78BFA)
                                : const Color(0xFF6B4EE6),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            statusLabels[status]!,
                            style: TextStyle(color: itemTextColor),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedStatus = val);
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _submitBookData,
                  child: const Text('Save Book'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}