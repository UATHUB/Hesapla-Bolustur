import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:self_test1/controllers/second_half_controllers/activity_expense_list_controller.dart';
import 'package:self_test1/controllers/second_half_controllers/registered_persons_controller.dart';
import 'package:self_test1/models/second_half_models/expense.dart';

final RegisteredActivityExpensesController rae =
    Get.put(RegisteredActivityExpensesController());
final RegisteredPersonsController rpc = Get.put(RegisteredPersonsController());

class ActivitySummaryScreen extends StatelessWidget {
  ActivitySummaryScreen({super.key});

  final totalExpense = rpc.personsList[0].totalAmount.toString().obs;
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
    return Column(
      children: [
        PieChart(dataMap: getMap(rae.registeredActivityExpenses)),
        Obx(
          () => Card(
            child: Row(
              children: [
                Text(rpc.personsList[0].name),
                Text(totalExpense.value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
