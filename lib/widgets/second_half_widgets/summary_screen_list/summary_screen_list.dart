import 'package:get/get.dart';
import 'package:self_test1/controllers/second_half_controllers/activity_expense_list_controller.dart';
import 'package:self_test1/controllers/second_half_controllers/registered_persons_controller.dart';
import 'package:flutter/material.dart';
import 'package:self_test1/models/second_half_models/persons.dart';
import 'package:self_test1/widgets/second_half_widgets/summary_screen_list/summary_screen_item.dart';

class SummaryScreenList extends StatefulWidget {
  const SummaryScreenList({super.key});

  @override
  State<SummaryScreenList> createState() => _SummaryScreenListState();
}

RegisteredPersonsController rpc = Get.find();
RegisteredActivityExpensesController rae = Get.find();

class _SummaryScreenListState extends State<SummaryScreenList> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      rpc.getAllPersons();
      rae.getAllExpenses();
      rae.divideExpenses();
    });
    List<Person> persons = rpc.personsList;
    return ListView.builder(
      itemCount: persons.length,
      itemBuilder: (ctx, index) {
        return SummaryScreenItem(persons[index]);
      },
    );
  }
}
