import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:self_test1/controllers/first_half_controllers/expenses_list_controller.dart';
import 'package:self_test1/models/first_half_models/expense.dart';

import 'package:self_test1/screens/first_half_screens/add_screens/add_expense_screen.dart';
import 'package:self_test1/widgets/first_half_widgets/expenses_list/expenses_list.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

RegisteredExpensesController re = Get.put(RegisteredExpensesController());

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> registeredExpenses = re.registeredExpenses;

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (ctx) => AddExpenseScreen(_addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
      re.registeredExpenses = registeredExpenses;
      re.saveExpenses(re.registeredExpenses);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = registeredExpenses.indexOf(expense);
    setState(() {
      re.registeredExpenses.removeAt(expenseIndex);
      re.saveExpenses(registeredExpenses);
    });
    Get.closeAllSnackbars();
    Get.snackbar('Başarılı', 'Harcama Silindi',
        snackPosition: SnackPosition.TOP,
        mainButton: TextButton(
          child: const Text('Geri Al'),
          onPressed: () => setState(() {
            Get.closeAllSnackbars();
            registeredExpenses.insert(expenseIndex, expense);
            re.saveExpenses(registeredExpenses);
          }),
        ));
  }

  Map<String, double> mapRegisteredExpenses(List<Expense> expenses) {
    Map<String, double> categoryMap = {};

    for (var expense in expenses) {
      categoryMap.update(expense.category, (value) => value + expense.amount,
          ifAbsent: () => expense.amount);
    }
    return categoryMap;
  }

  @override
  Widget build(BuildContext context) {
    re.registeredExpenses = registeredExpenses;
    Widget mainContent = Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _openAddExpenseOverlay, child: const Icon(Icons.add)),
      body: const Center(
        child: Text(
          'Para Harcamadan Yaşıyor Olamazsın.\nHadi Eklemeye Başla!',
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Harcamalar'),
              expandedHeight: 450,
              pinned: true,
              floating: false,
              primary: true,
              stretch: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.restore))
              ],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    initialPage: 0,
                    height: 350,
                    enlargeFactor: 1.20,
                    enableInfiniteScroll: false,
                  ),
                  items: [
                    Column(
                      children: [
                        PieChart(
                          dataMap: mapRegisteredExpenses(registeredExpenses),
                          chartRadius: 450,
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                            showChartValueBackground: false,
                            chartValueStyle: const TextStyle().copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer),
                          ),
                          legendOptions: LegendOptions(
                            showLegends: false,
                            showLegendsInRow: true,
                            legendPosition: LegendPosition.bottom,
                            legendTextStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Kategori İsimlerini Görmek İçin Kaydırınız',
                              style: const TextStyle().copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer),
                            ),
                            const Icon(Icons.chevron_right_sharp)
                          ],
                        )
                      ],
                    ),
                    PieChart(
                      dataMap: mapRegisteredExpenses(registeredExpenses),
                      chartRadius: 0,
                      chartValuesOptions:
                          const ChartValuesOptions(showChartValues: false),
                      legendOptions: LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.top,
                        legendTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ExpensesList(onRemoveExpense: _removeExpense),
          ],
        ),
      );
    }
    return mainContent;
  }
}
