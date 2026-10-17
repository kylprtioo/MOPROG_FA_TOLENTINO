import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

class CategoryItem {
  const CategoryItem({
    required this.name,
    required this.icon,
  });

  final String name;
  final IconData icon;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryItem &&
          runtimeType == other.runtimeType &&
          name.toLowerCase() == other.name.toLowerCase();

  @override
  int get hashCode => name.toLowerCase().hashCode;
}

final List<CategoryItem> initialCategories = [
  const CategoryItem(name: 'Food', icon: Icons.lunch_dining),
  const CategoryItem(name: 'Travel', icon: Icons.flight_takeoff),
  const CategoryItem(name: 'Leisure', icon: Icons.movie),
  const CategoryItem(name: 'Work', icon: Icons.work),
];

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = const Uuid().v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final CategoryItem category;

  String get formattedDate {
    return formatter.format(date);
  }
}