import 'package:self_test1/models/first_half_models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  expense.title,
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
                Row(
                  children: [
                    // Icon(categoryIcons[expense.category],
                    //     color:
                    //         Theme.of(context).colorScheme.onSecondaryContainer),
                    // const SizedBox(width: 8),
                    Text(
                      expense.formattedDate,
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


//Eğer Tekrar Kutu Şekline Dönmek İstersem :

 // Column(
 //   children: [
 //     Text(
 //       expense.title.replaceFirst(
 //         expense.title.characters.first,
 //         expense.title.characters.first.toUpperCase(),
 //       ),
 //       style: const TextStyle().copyWith(
 //         color: Theme.of(context).colorScheme.onSecondaryContainer,
 //         fontSize: 16,
 //         fontWeight: FontWeight.w500,
 //       ),
 //     ),
 //     const Spacer(),
 //     Padding(
 //       padding: const EdgeInsets.symmetric(horizontal: 15),
 //       child: Row(
 //         mainAxisAlignment: MainAxisAlignment.center,
 //         children: [
 //           const Icon(Icons.category, size: 20),
 //           const Spacer(),
 //           Text(
 //             expense.category.replaceFirst(
 //               expense.category.characters.first,
 //               expense.category.characters.first.toUpperCase(),
 //             ),
 //             style: const TextStyle().copyWith(
 //                 fontSize: 14,
 //                 fontWeight: FontWeight.w500,
 //                 color: Theme.of(context)
 //                     .colorScheme
 //                     .onSecondaryContainer),
 //           ),
 //         ],
 //       ),
 //     ),
 //     const Spacer(),
 //     Padding(
 //       padding: const EdgeInsets.symmetric(horizontal: 15),
 //       child: Row(
 //         mainAxisAlignment: MainAxisAlignment.center,
 //         children: [
 //           const Icon(Icons.date_range, size: 20),
 //           const Spacer(),
 //           Text(
 //             expense.formattedDate,
 //             style: const TextStyle().copyWith(
 //               color:
 //                   Theme.of(context).colorScheme.onSecondaryContainer,
 //               fontWeight: FontWeight.w500,
 //             ),
 //           ),
 //         ],
 //       ),
 //     ),
 //     const Spacer(),
 //     Container(
 //       decoration: BoxDecoration(
 //         color: Colors.black87.withAlpha(100),
 //       ),
 //       height: 50,
 //       width: double.infinity,
 //       alignment: Alignment.center,
 //       child: Text(
 //         '${expense.amount.toStringAsFixed(2)} ₺',
 //         style: const TextStyle().copyWith(
 //             color: Theme.of(context).colorScheme.onSecondaryContainer,
 //             fontWeight: FontWeight.w500,
 //             fontSize: 18),
 //       ),
 //     )
 //   ],
 // )