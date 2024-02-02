import 'package:expenses_tracker_app/models/expense_class.dart';
import 'package:expenses_tracker_app/models/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat().add_yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _selectDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      initialDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final amount = double.tryParse(_amountController.text);
    final invalidAmount = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid input"),
                content: const Text("Please make sure to input valid data."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("close"))
                ],
              ));
      return;
    }
    setState(() {
      widget.onAddExpense(Expense(
          title: _titleController.text,
          amount: amount,
          date: _selectedDate!,
          category: _selectedCategory));
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).systemGestureInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: InputDecoration(
                    label: Text(
                  "Title",
                  style: appStyle(FontWeight.w400, 15, Colors.black),
                )),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //amount
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixText: "\$ ",
                          prefixStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          label: Text(
                            "Amount",
                            style: appStyle(FontWeight.w400, 15, Colors.black),
                          )),
                    ),
                  ),

                  const Spacer(),

                  //date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? "no date selected"
                            : formatter.format(_selectedDate!),
                        style: appStyle(FontWeight.w400, 15, Colors.black),
                      ),
                      IconButton(
                          onPressed: () {
                            _selectDate();
                          },
                          icon: const Icon(Icons.calendar_month))
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              //buttons
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase())))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      "cancel",
                      style: appStyle(FontWeight.w700, 15, Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      onPressed: _submitExpenseData,
                      child: Text(
                        "add",
                        style: appStyle(FontWeight.w700, 15, Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
