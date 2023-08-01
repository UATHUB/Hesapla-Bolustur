import 'package:flutter/material.dart';
import 'package:self_test1/models/second_half_models/persons.dart';

class SummaryScreenItem extends StatelessWidget {
  const SummaryScreenItem(this.person, {super.key});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              person.name.replaceFirst(person.name.characters.first,
                  person.name.characters.first.toUpperCase()),
              style: const TextStyle().copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Text(
              '${person.totalAmount.toStringAsFixed(2)}₺',
              style: const TextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
          ],
        ),
      ),
    );
  }
}
