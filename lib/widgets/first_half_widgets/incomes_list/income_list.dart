import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/incomes_list_controller.dart';
import 'package:self_test1/models/first_half_models/income.dart';
import 'package:flutter/material.dart';
import 'package:self_test1/widgets/first_half_widgets/incomes_list/income_item.dart';

class IncomeList extends StatefulWidget {
  const IncomeList({required this.onRemoveIncome, super.key});

  final void Function(Income income) onRemoveIncome;

  @override
  State<IncomeList> createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> {
  @override
  Widget build(BuildContext context) {
    RegisteredIncomesController ri = Get.find();
    List<Income> incomes = ri.registeredIncomes;
    return SliverList.builder(
      itemCount: incomes.length,
      itemBuilder: (ctx, index) => InkWell(
        onLongPress: () => Get.dialog(AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          shadowColor: Colors.black87.withAlpha(150),
          content: Text(
            'Bu Geliri Silmek İstediğinize Emin Misiniz ?',
            softWrap: true,
            style: const TextStyle().copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            textWidthBasis: TextWidthBasis.parent,
          ),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () => Get.close(1),
            ),
            ElevatedButton(
                onPressed: () {
                  widget.onRemoveIncome(incomes[index]);
                  Get.close(1);
                },
                child: const Text('Geliri Sil'))
          ],
        )),
        child: IncomeItem(incomes[index]),
      ),
    );
  }
}
