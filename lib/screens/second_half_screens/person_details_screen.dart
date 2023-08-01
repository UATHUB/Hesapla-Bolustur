import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/second_half_controllers/activity_expense_list_controller.dart';
import 'package:self_test1/models/second_half_models/expense.dart';
import 'package:self_test1/models/second_half_models/persons.dart';
import 'package:self_test1/widgets/second_half_widgets/activity_expenses_list/activity_expense_item.dart';

RegisteredActivityExpensesController rae = Get.find();

class PersonDetails extends StatelessWidget {
  const PersonDetails({required this.person, super.key});

  final Person person;

  List<ActivityExpense> getRelatedExpenses() {
    List<ActivityExpense> relatedExpenses = [];
    person.includedExpenses;
    for (var expense in rae.registeredActivityExpenses) {
      if (person.includedExpenses.contains(expense.name)) {
        relatedExpenses.add(expense);
      }
    }
    return relatedExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black87.withAlpha(240),
      child: SizedBox(
        height: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).colorScheme.secondaryContainer),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  person.name.replaceFirst(
                    person.name.characters.first,
                    person.name.characters.first.toUpperCase(),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle().copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                  itemCount: getRelatedExpenses().length,
                  itemBuilder: (ctx, index) =>
                      ActivityExpenseItem(getRelatedExpenses()[index])),
            ),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).colorScheme.secondaryContainer),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Toplam harcama miktar: ${person.totalAmount.toStringAsFixed(2)}₺',
                  textAlign: TextAlign.center,
                  style: const TextStyle().copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
