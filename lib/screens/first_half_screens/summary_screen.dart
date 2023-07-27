// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:self_test1/controllers/first_half_controllers/expenses_list_controller.dart';
import 'package:self_test1/controllers/first_half_controllers/incomes_list_controller.dart';
// import 'package:self_test1/models/summary.dart';
import 'package:self_test1/models/first_half_models/expense.dart';
import 'package:self_test1/models/first_half_models/income.dart';

import 'package:self_test1/screens/first_half_screens/add_screens/add_expense_screen.dart';
import 'package:self_test1/screens/first_half_screens/add_screens/add_income_screen.dart';

import 'package:self_test1/widgets/first_half_widgets/expenses_list/expense_item.dart';
import 'package:self_test1/widgets/first_half_widgets/incomes_list/income_item.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

RegisteredExpensesController re = Get.find();
RegisteredIncomesController ri = Get.find();

class _SummaryScreenState extends State<SummaryScreen> {
  late List<Income> registeredIncomes;
  late List<Expense> registeredExpenses;

  double calculateSummary(
      List<Income> registeredIncomes, List<Expense> registeredExpenses) {
    Expense expense;
    double totalExpense = 0;
    Income income;
    double totalIncome = 0;

    for (expense in registeredExpenses) {
      totalExpense += expense.amount;
    }
    for (income in registeredIncomes) {
      totalIncome += income.amount;
    }

    return totalIncome - totalExpense;
  }

  bool checkEmpty() {
    setState(() {});
    return registeredExpenses.isEmpty && registeredIncomes.isEmpty;
  }

  Map<String, double> returnMap() {
    Expense expense;
    double totalExpense = 0;
    Income income;
    double totalIncome = 0;

    for (expense in registeredExpenses) {
      totalExpense += expense.amount;
    }
    for (income in registeredIncomes) {
      totalIncome += income.amount;
    }
    Map<String, double> map = {'Gelir': totalIncome, 'Gider': totalExpense};
    return map;
  }

  void _addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
      re.registeredExpenses = registeredExpenses;
      re.saveExpenses(registeredExpenses);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (ctx) => AddExpenseScreen(_addExpense),
    );
  }

  void _addIncome(Income income) {
    setState(() {
      registeredIncomes.add(income);
      ri.registeredIncomes = registeredIncomes;
      ri.saveIncomes(registeredIncomes);
    });
  }

  void _openAddIncomeOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (ctx) => AddIncomeScreen(_addIncome),
    );
  }

  @override
  Widget build(BuildContext context) {
    registeredExpenses = re.registeredExpenses;
    registeredIncomes = ri.registeredIncomes;

    double summary =
        0 + calculateSummary(registeredIncomes, registeredExpenses);

    String sign = '';
    if (summary > 0) {
      sign = '+';
    } else {
      sign = '';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          checkEmpty()
              ? SizedBox(
                  width: 350,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer),
                        child: Text(
                          'Özet Çıkartılacak Bir Veri Bulunamadı',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: _openAddExpenseOverlay,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  Theme.of(context).colorScheme.errorContainer),
                          child: Text(
                            'Hemen İlk Harcamanızı Eklemek İçin Tıklayın!',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: _openAddIncomeOverlay,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer),
                          child: Text(
                            'Hemen İlk Gelirinizi Eklemek İçin Tıklayın!',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      PieChart(
                        colorList: [
                          Theme.of(context).colorScheme.tertiaryContainer,
                          Theme.of(context).colorScheme.errorContainer
                        ],
                        dataMap: returnMap(),
                        chartRadius: 350,
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValuesInPercentage: true),
                        legendOptions: const LegendOptions(
                            showLegends: false,
                            showLegendsInRow: true,
                            legendPosition: LegendPosition.bottom),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer),
                        child: Center(
                          child: Text(
                            'Bu Dönemki Gelir ve Giderlerinizin Özeti : $sign ${summary.toStringAsFixed(2)} ₺',
                            style: const TextStyle().copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      registeredExpenses.isNotEmpty
                          ? Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(1)),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                  ),
                                  child: Text(
                                    'Yapılan Son Harcama',
                                    style: const TextStyle().copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ExpenseItem(registeredExpenses.last),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .errorContainer),
                                  child: Text(
                                    'Son Yapılan Harcama Kaydı Bulunamadı',
                                    style: const TextStyle().copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                InkWell(
                                  onTap: _openAddExpenseOverlay,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 20),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 25,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer),
                                      child: Text(
                                        'Hemen İlk Harcamanızı Eklemek İçin Tıklayın!',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      registeredIncomes.isNotEmpty
                          ? Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(1)),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                  ),
                                  child: Text(
                                    'Girilen Son Gelir:',
                                    style: const TextStyle().copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                IncomeItem(registeredIncomes.last),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiaryContainer),
                                  child: Text(
                                    'Son Girilen Gelir Bilgisi Bulunamadı',
                                    style: const TextStyle().copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: _openAddIncomeOverlay,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 20),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 25,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer),
                                      child: Text(
                                        'Hemen İlk Gelirinizi Eklemek İçin Tıklayın!',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
