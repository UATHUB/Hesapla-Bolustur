import 'package:get/get.dart';
import 'package:self_test1/controllers/second_half_controllers/activity_expense_list_controller.dart';
import 'package:self_test1/models/second_half_models/expense.dart';
import 'package:flutter/material.dart';
import 'package:self_test1/widgets/second_half_widgets/activity_expenses_list/activity_expense_item.dart';

class ActivityExpensesList extends StatefulWidget {
  const ActivityExpensesList({required this.onRemoveExpense, super.key});

  final void Function(ActivityExpense expense) onRemoveExpense;

  @override
  State<ActivityExpensesList> createState() => _ActivityExpensesListState();
}

RegisteredActivityExpensesController rae =
    Get.put(RegisteredActivityExpensesController());

class _ActivityExpensesListState extends State<ActivityExpensesList> {
  @override
  Widget build(BuildContext context) {
    List<ActivityExpense> expenses = rae.registeredActivityExpenses;
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
        child: ActivityExpenseItem(expenses[index]),
      ),
    );
  }
}
