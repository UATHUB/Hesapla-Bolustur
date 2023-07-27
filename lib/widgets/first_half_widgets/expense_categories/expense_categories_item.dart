import 'package:flutter/material.dart';

class ExpenseCategoriesItem extends StatelessWidget {
  const ExpenseCategoriesItem(this.category, {super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 20,
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SizedBox(
        width: 320,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
          child: Text(
            category.replaceFirst(category.characters.first,
                category.characters.first.toUpperCase()),
            textAlign: TextAlign.center,
            style: const TextStyle().copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}
