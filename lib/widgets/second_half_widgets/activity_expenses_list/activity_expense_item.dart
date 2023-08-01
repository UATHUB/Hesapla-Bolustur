import 'package:self_test1/models/second_half_models/expense.dart';
import 'package:flutter/material.dart';

class ActivityExpenseItem extends StatelessWidget {
  const ActivityExpenseItem(this.expense, {super.key});

  final ActivityExpense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  expense.name.replaceFirst(expense.name.characters.first,
                      expense.name.characters.first.toUpperCase()),
                  style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  expense.category.replaceFirst(
                    expense.category.characters.first,
                    expense.category.characters.first.toUpperCase(),
                  ),
                  style: const TextStyle().copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '${expense.amount.toStringAsFixed(2)} ₺',
                  style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: expense.sharers.length,
                      itemBuilder: (context, index) {
                        return Text(
                          '${expense.sharers[index].name.replaceFirst(expense.sharers[index].name.characters.first, expense.sharers[index].name.characters.first.toUpperCase())}  ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
