import 'package:expenses_tracker_app/chart/chart.dart';
import 'package:expenses_tracker_app/models/add_expense.dart';
import 'package:expenses_tracker_app/models/list_display.dart';
import 'package:expenses_tracker_app/models/expense_class.dart';
import 'package:expenses_tracker_app/models/text_style.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = registeredExpenses.indexOf(expense);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense deleted."),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: "undo",
          onPressed: () {
            setState(() {
              registeredExpenses.insert(index, expense);
            });
          }),
    ));

    setState(() {
      registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        "Add expenses.",
        style: appStyle(FontWeight.normal, 15, Colors.black)
            .copyWith(letterSpacing: 0.5),
      ),
    );

    if (registeredExpenses.isNotEmpty) {
      content = ListDisplay(
          expenses: registeredExpenses, onRemoveExpense: _removeExpense);
    }
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expenses Tracker",
          style: appStyle(FontWeight.w900, 25, Colors.black)
              .copyWith(letterSpacing: 0.5),
        ),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(
                Icons.add_circle_rounded,
                size: 30,
                color: Colors.black,
              ))
        ],
      ),
      body: width < 600
          ? Column(children: [
              Chart(expenses: registeredExpenses),
              Expanded(child: content)
            ])
          : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: Chart(expenses: registeredExpenses)),
              Expanded(child: content)
            ]),
    );
  }
}
