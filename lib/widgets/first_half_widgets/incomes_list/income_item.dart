import 'package:flutter/material.dart';
import 'package:self_test1/models/first_half_models/income.dart';

class IncomeItem extends StatelessWidget {
  const IncomeItem(this.income, {super.key});

  final Income income;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
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
                  income.title,
                  style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  income.category.replaceFirst(
                    income.category.characters.first,
                    income.category.characters.first.toUpperCase(),
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
                  '${income.amount.toStringAsFixed(2)} ₺',
                  style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    // Icon(
                    //   categoryIcons[income.category],
                    //   color: Theme.of(context).colorScheme.onSecondaryContainer,
                    // ),
                    // const SizedBox(width: 8),
                    Text(
                      income.formattedDate,
                      style: const TextStyle().copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
