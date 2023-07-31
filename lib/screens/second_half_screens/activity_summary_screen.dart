import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:self_test1/controllers/second_half_controllers/activity_expense_list_controller.dart';
import 'package:self_test1/controllers/second_half_controllers/registered_persons_controller.dart';
import 'package:self_test1/models/second_half_models/expense.dart';
import 'package:self_test1/widgets/second_half_widgets/summary_screen_list/summary_screen_list.dart';

final RegisteredActivityExpensesController rae =
    Get.put(RegisteredActivityExpensesController());
final RegisteredPersonsController rpc = Get.put(RegisteredPersonsController());

class ActivitySummaryScreen extends StatelessWidget {
  const ActivitySummaryScreen({super.key});

  Map<String, double> getMap(List<ActivityExpense> expenses) {
    Map<String, double> returnMap = {};
    for (var expense in expenses) {
      returnMap.update(expense.category, (value) => value + expense.amount,
          ifAbsent: () => expense.amount);
    }
    return returnMap;
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        'Bölüştürmek İçin İlk Harcamanı Ekle!',
        style: TextStyle(
          color: Color.fromARGB(85, 67, 173, 187),
        ),
      ),
    );

    if (rae.registeredActivityExpenses.isNotEmpty) {
      mainContent = Column(
        children: [
          PieChart(dataMap: getMap(rae.registeredActivityExpenses)),
          const Expanded(child: SummaryScreenList()),
        ],
      );
    }

    return mainContent;
  }
}
