import 'package:flutter/material.dart';
import 'package:self_test1/models/second_half_models/persons.dart';

class SummaryScreenItem extends StatelessWidget {
  const SummaryScreenItem(this.person, {super.key});

  final Person person;

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
                  person.name,
                  style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  person.totalAmount.toStringAsFixed(2),
                  style: const TextStyle().copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
