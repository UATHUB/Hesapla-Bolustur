import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_test1/models/first_half_models/income.dart';

final incomesListBox = GetStorage('incomesList');

class RegisteredIncomesController extends GetxController {
  List<Income> registeredIncomes = [];

  void saveIncomes(List<Income> incomes) {
    final List<Map<String, dynamic>> dataList = incomes.map((income) {
      return {
        'title': income.title,
        'amount': income.amount,
        'date': income.date.toIso8601String(),
        'category': income.category,
      };
    }).toList();

    incomesListBox.write('IncomesList', dataList);
  }

  List<Income> getAllIncomes() {
    final List<Income> incomes = [];

    final dataList = incomesListBox.read('IncomesList') as List<dynamic>?;

    if (dataList != null) {
      for (final data in dataList) {
        incomes.add(Income(
          title: data['title'],
          amount: data['amount'],
          date: DateTime.parse(data['date']),
          category: data['category'],
        ));
      }
    }

    return incomes;
  }

  void removeAllIncomes() {
    incomesListBox.remove('ExpensesList');
  }

  void removeIncomeById(String incomeId) {
    final dataList = incomesListBox.read('ExpensesList') as List<dynamic>?;

    if (dataList != null) {
      dataList.removeWhere((data) => data['id'] == incomeId);
      incomesListBox.write('ExpensesList', dataList);
    }
  }
}
