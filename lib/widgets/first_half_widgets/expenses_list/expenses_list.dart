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
    return SliverList.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => InkWell(
              onLongPress: () => Get.dialog(AlertDialog(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                shadowColor: Colors.black87.withAlpha(150),
                content: Text(
                  'Bu Harcamayı Silmek İstediğinize Emin Misiniz ?',
                  softWrap: true,
                  style: const TextStyle().copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  textWidthBasis: TextWidthBasis.parent,
                ),
                actions: [
                  TextButton(
                    child: const Text('İptal'),
                    onPressed: () => Get.close(1),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        widget.onRemoveExpense(expenses[index]);
                        Get.close(1);
                      },
                      child: const Text('Harcamayı Sil'))
                ],
              )),
              child: ExpenseItem(expenses[index]),
            )

        // Dismissible(
        //   background: Container(
        //     decoration: BoxDecoration(
        //       color: Theme.of(context).colorScheme.error.withOpacity(0.50),
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     margin: Theme.of(context).cardTheme.margin,
        //   ),
        //   direction: DismissDirection.endToStart,
        //   key: ValueKey(expenses[index]),
        //   onDismissed: (direction) {
        //     widget.onRemoveExpense(expenses[index]);
        //   },
        //   child: ExpenseItem(expenses[index]),
        // ),
        );
  }
}
