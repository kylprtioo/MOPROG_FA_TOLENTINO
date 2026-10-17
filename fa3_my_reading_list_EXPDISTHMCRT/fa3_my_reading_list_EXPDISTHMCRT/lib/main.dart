import 'package:fa3_my_reading_list_expdisthmcrt/books/books_screen.dart';
import 'package:flutter/material.dart';

const primaryPurple = Color(0xFF6B4EE6);
const secondaryBlue = Color(0xFF2979FF);
const creamyWhite = Color(0xFFFBFBF7);
const darkNavy = Color(0xFF0F121C);
const darkSurface = Color(0xFF1B2030);

var kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: primaryPurple,
  primary: primaryPurple,
  secondary: secondaryBlue,
  surface: creamyWhite,
  surfaceContainer: const Color(0xFFF1F0E8),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: primaryPurple,
  primary: const Color(0xFF9B84EC),
  secondary: const Color(0xFF82B1FF),
  surface: darkNavy,
  surfaceContainer: darkSurface,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: creamyWhite,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: Colors.white,
          elevation: 1,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFECEEF2)),
          ),
        ),
      ),
      darkTheme: ThemeData().copyWith(
        colorScheme: kDarkColorScheme,
        scaffoldBackgroundColor: darkNavy,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: darkSurface,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: darkSurface,
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF2C3249)),
          ),
        ),
      ),
      themeMode: _themeMode,
      home: BooksScreen(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}