import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/models/second_half_models/persons.dart';
import 'package:self_test1/screens/second_half_screens/person_details_screen.dart';

class SummaryScreenItem extends StatelessWidget {
  const SummaryScreenItem(this.person, {super.key});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.dialog(
        PersonDetails(person: person),
        transitionDuration: const Duration(milliseconds: 400),
        useSafeArea: true,
        barrierColor: Colors.transparent.withOpacity(0.5),
      ),
      child: Card(
        elevation: 5,
        color:
            Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withAlpha(100),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Toplam Harcama',
                      style: const TextStyle().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${person.totalAmount.toStringAsFixed(2)}₺',
                      style: const TextStyle().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
