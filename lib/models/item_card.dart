import 'package:expenses_tracker_app/models/expense_class.dart';
import 'package:expenses_tracker_app/models/text_style.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(expense.title,
                style: appStyle(FontWeight.w200, 20, Colors.black)),
            const SizedBox(height: 10),
            Row(
              children: [
                //amount
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text("\$${expense.amount.toStringAsFixed(2)}",
                      style: appStyle(FontWeight.w200, 15, Colors.white)),
                ),
                const Spacer(),
                //icon&date
                Row(
                  children: [
                    Icon(categoryIcon[expense.category]),
                    const SizedBox(width: 10),
                    Text(expense.formattedDate,
                        style: appStyle(FontWeight.w200, 15,
                            const Color.fromARGB(97, 0, 0, 0))),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
