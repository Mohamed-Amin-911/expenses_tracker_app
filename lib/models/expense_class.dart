import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Category { leisure, work, food, travel }

const uuid = Uuid();
final formatter = DateFormat().add_yMd();
const categoryIcon = {
  Category.leisure: Icons.movie_filter_rounded,
  Category.work: Icons.work,
  Category.food: Icons.lunch_dining_rounded,
  Category.travel: Icons.flight_rounded,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

final List<Expense> registeredExpenses = [
  // Expense(
  //     title: "expense1",
  //     amount: 19.99,
  //     category: Category.food,
  //     date: DateTime.now()),
  // Expense(
  //     title: "expense1",
  //     amount: 19.99,
  //     category: Category.food,
  //     date: DateTime.now()),
  // Expense(
  //     title: "expense1",
  //     amount: 19.99,
  //     category: Category.work,
  //     date: DateTime.now()),
  // Expense(
  //     title: "expense1",
  //     amount: 19.99,
  //     category: Category.leisure,
  //     date: DateTime.now()),
];

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final i in expenses) {
      sum += i.amount;
    }
    return sum;
  }
}
