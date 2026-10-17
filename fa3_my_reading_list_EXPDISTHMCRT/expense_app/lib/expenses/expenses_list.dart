import 'package:expense_app/expenses/expense_item.dart';
import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.removeExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

@override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
    return Dismissible(
      background: Container(
        color: Theme.of(context).colorScheme.error.withOpacity(0.2),
        margin: Theme.of(context).cardTheme.margin,
      ),
      key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          removeExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
        );
      },
    );
  }
}