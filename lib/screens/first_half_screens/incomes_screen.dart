import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/incomes_list_controller.dart';

import 'package:self_test1/models/first_half_models/income.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:self_test1/screens/first_half_screens/add_screens/add_income_screen.dart';
import 'package:self_test1/widgets/first_half_widgets/incomes_list/income_list.dart';

class IncomesScreen extends StatefulWidget {
  const IncomesScreen({super.key});

  @override
  State<IncomesScreen> createState() => _ExpensesScreenState();
}

RegisteredIncomesController ri = Get.put(RegisteredIncomesController());

class _ExpensesScreenState extends State<IncomesScreen> {
  final List<Income> registeredIncomes = ri.registeredIncomes.obs;

  void _openAddIncomeOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (ctx) => AddIncomeScreen(_addIncome),
    );
  }

  void _addIncome(Income income) {
    setState(() {
      registeredIncomes.add(income);
      ri.registeredIncomes = registeredIncomes;
      ri.saveIncomes(registeredIncomes);
    });
  }

  void _removeIncome(Income income) {
    final incomeIndex = registeredIncomes.indexOf(income);
    setState(() {
      registeredIncomes.removeAt(incomeIndex);
      ri.saveIncomes(registeredIncomes);
    });
    Get.closeAllSnackbars();
    Get.snackbar('Başarılı', 'Harcama Silindi',
        snackPosition: SnackPosition.TOP,
        mainButton: TextButton(
          child: const Text('Geri Al'),
          onPressed: () => setState(() {
            Get.closeAllSnackbars();
            registeredIncomes.insert(incomeIndex, income);
            ri.saveIncomes(registeredIncomes);
          }),
        ));
  }

  Map<String, double> mapRegisteredExpenses(List<Income> incomes) {
    Map<String, double> categoryMap = {};

    for (var expense in incomes) {
      categoryMap.update(expense.category, (value) => value + expense.amount,
          ifAbsent: () => expense.amount);
    }
    return categoryMap;
  }

  @override
  Widget build(BuildContext context) {
    ri.registeredIncomes = registeredIncomes;
    Widget mainContent = Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _openAddIncomeOverlay, child: const Icon(Icons.add)),
      body: const Center(
        child: Text(
          'Para Kazanmadan Yaşıyor Olamazsın.\nHadi Eklemeye Başla!',
          style: TextStyle(
            color: Color.fromARGB(85, 67, 173, 187),
          ),
        ),
      ),
    );

    if (registeredIncomes.isNotEmpty) {
      mainContent = Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: _openAddIncomeOverlay, child: const Icon(Icons.add)),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 50),
            PieChart(
                dataMap: mapRegisteredExpenses(registeredIncomes),
                chartRadius: 300,
                chartValuesOptions: ChartValuesOptions(
                    showChartValuesInPercentage: true,
                    showChartValueBackground: false,
                    chartValueStyle: const TextStyle().copyWith(
                        color:
                            Theme.of(context).colorScheme.secondaryContainer)),
                legendOptions: LegendOptions(
                    showLegendsInRow: true,
                    legendPosition: LegendPosition.bottom,
                    legendTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface))),
            const SizedBox(height: 5),
            Expanded(
              child: IncomeList(
                onRemoveIncome: _removeIncome,
              ),
            ),
          ],
        ),
      );
    }
    return mainContent;
  }
}
