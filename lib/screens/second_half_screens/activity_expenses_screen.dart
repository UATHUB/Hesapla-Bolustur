import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:self_test1/controllers/second_half_controllers/activity_expense_list_controller.dart';
import 'package:self_test1/models/second_half_models/expense.dart';
import 'package:self_test1/screens/second_half_screens/add_screens/add_activity_expense_screen.dart';
import 'package:self_test1/widgets/second_half_widgets/activity_expenses_list/activity_expenses_list.dart';

class ActivityExpensesScreen extends StatefulWidget {
  const ActivityExpensesScreen({super.key});

  @override
  State<ActivityExpensesScreen> createState() => _ActivityExpensesScreenState();
}

RegisteredActivityExpensesController rae =
    Get.put(RegisteredActivityExpensesController());

class _ActivityExpensesScreenState extends State<ActivityExpensesScreen> {
  final List<ActivityExpense> registeredExpenses =
      rae.registeredActivityExpenses;

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (ctx) => AddActivityExpenseScreen(_addExpense),
    );
  }

  void _addExpense(ActivityExpense expense) {
    setState(() {
      registeredExpenses.add(expense);
      rae.registeredActivityExpenses = registeredExpenses;
      rae.saveExpenses(rae.registeredActivityExpenses);
    });
  }

  void _removeExpense(ActivityExpense expense) {
    final expenseIndex = registeredExpenses.indexOf(expense);
    setState(() {
      rae.registeredActivityExpenses.removeAt(expenseIndex);
      rae.saveExpenses(registeredExpenses);
    });
    Get.closeAllSnackbars();
    Get.snackbar('Başarılı', 'Harcama Silindi',
        snackPosition: SnackPosition.TOP,
        mainButton: TextButton(
          child: const Text('Geri Al'),
          onPressed: () => setState(() {
            Get.closeAllSnackbars();
            registeredExpenses.insert(expenseIndex, expense);
            rae.saveExpenses(registeredExpenses);
          }),
        ));
  }

  Map<String, double> mapRegisteredActivityExpenses(
      List<ActivityExpense> expenses) {
    Map<String, double> categoryMap = {};

    for (var expense in expenses) {
      categoryMap.update(expense.category, (value) => value + expense.amount,
          ifAbsent: () => expense.amount);
    }
    return categoryMap;
  }

  @override
  Widget build(BuildContext context) {
    rae.registeredActivityExpenses = registeredExpenses;
    Widget mainContent = Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _openAddExpenseOverlay, child: const Icon(Icons.add)),
      body: const Center(
        child: Text(
          'Bölüştürmek İçin İlk Harcamanı Ekle!',
          style: TextStyle(
            color: Color.fromARGB(85, 67, 173, 187),
          ),
        ),
      ),
    );

    if (registeredExpenses.isNotEmpty) {
      mainContent = Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: _openAddExpenseOverlay, child: const Icon(Icons.add)),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: ActivityExpensesList(
                onRemoveExpense: _removeExpense,
              ),
            ),
          ],
        ),
      );
    }
    return mainContent;
  }
}
