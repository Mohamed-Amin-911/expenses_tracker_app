import 'package:expenses_tracker_app/models/item_card.dart';
import 'package:expenses_tracker_app/models/expense_class.dart';
import 'package:flutter/material.dart';

class ListDisplay extends StatelessWidget {
  const ListDisplay(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            direction: width >= 600
                ? DismissDirection.startToEnd
                : DismissDirection.horizontal,
            background: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              color: const Color.fromARGB(134, 255, 82, 82),
              child: const Icon(
                Icons.delete,
                size: 30,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            key: ValueKey(expenses[index]),
            child: ItemCard(expenses[index])));
  }
}
