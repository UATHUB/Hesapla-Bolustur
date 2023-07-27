import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/expenses_list_controller.dart';
import 'package:self_test1/models/first_half_models/expense.dart';
import 'package:self_test1/widgets/first_half_widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({required this.onRemoveExpense, super.key});

  final void Function(Expense expense) onRemoveExpense;

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    RegisteredExpensesController re = Get.find();
    List<Expense> expenses = re.registeredExpenses;
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error.withOpacity(0.50),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: Theme.of(context).cardTheme.margin,
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          widget.onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
