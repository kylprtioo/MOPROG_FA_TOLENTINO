import 'package:expense_app/chart/chart.dart';
import 'package:expense_app/expenses/expenses_list.dart';
import 'package:expense_app/expenses/new_expense.dart';
import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  final void Function() onToggleTheme;
  final bool isDarkMode;

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  late final List<CategoryItem> _availableCategories = List.from(initialCategories);

  late final List<Expense> registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 100.0,
      date: DateTime.now(),
      category: initialCategories[3],
    ),
    Expense(
      title: 'Cinema',
      amount: 20.0,
      date: DateTime.now(),
      category: initialCategories[2],
    ),
    Expense(
      title: 'Pizza',
      amount: 40.0,
      date: DateTime.now(),
      category: initialCategories[0],
    ),
    Expense(
      title: 'Cebu Trip',
      amount: 150.0,
      date: DateTime.now(),
      category: initialCategories[1],
    ),
  ];

  void _openExpenseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(
        addExpense: _addExpense,
        availableCategories: _availableCategories,
      ),
    );
  }

  void _openAddCategoryDialog() {
    final categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add New Category'),
        content: TextField(
          controller: categoryController,
          maxLength: 15,
          decoration: const InputDecoration(
            labelText: 'Category Name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final enteredText = categoryController.text.trim();
              if (enteredText.isEmpty) return;

              final alreadyExists = _availableCategories.any(
                (c) => c.name.toLowerCase() == enteredText.toLowerCase(),
              );

              if (!alreadyExists) {
                setState(() {
                  _availableCategories.add(
                    CategoryItem(
                      name: enteredText,
                      icon: Icons.category,
                    ),
                  );
                });
              }

              Navigator.pop(ctx);
            },
            child: const Text('Add Category'),
          ),
        ],
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = registeredExpenses.indexOf(expense);

    setState(() {
      registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: registeredExpenses,
        removeExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          IconButton(
            onPressed: _openAddCategoryDialog,
            icon: const Icon(Icons.playlist_add),
          ),
          IconButton(
            onPressed: _openExpenseModal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(
            expenses: registeredExpenses,
            categories: _availableCategories,
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}