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
    return ListView.builder(
      itemCount: incomes.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error.withOpacity(0.50),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: Theme.of(context).cardTheme.margin,
        ),
        key: ValueKey(incomes[index]),
        onDismissed: (direction) {
          widget.onRemoveIncome(incomes[index]);
        },
        child: IncomeItem(incomes[index]),
      ),
    );
  }
}
