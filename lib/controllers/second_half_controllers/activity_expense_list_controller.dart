import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_test1/models/second_half_models/expense.dart';
import 'package:self_test1/models/second_half_models/persons.dart';

final activityExpensesListBox = GetStorage('activityExpensesList');

class RegisteredActivityExpensesController extends GetxController {
  List<ActivityExpense> registeredActivityExpenses = [];

  void saveExpenses(List<ActivityExpense> expenses) {
    final List<Map<String, dynamic>> dataList = expenses.map((expense) {
      return {
        'name': expense.name,
        'amount': expense.amount,
        'sharers': expense.sharers
            .map((person) => person.toJson())
            .toList(), // Use toJson here
        'category': expense.category,
      };
    }).toList();

    activityExpensesListBox.write('ExpensesList', dataList);
  }

  List<ActivityExpense> getAllExpenses() {
    final List<ActivityExpense> expenses = [];

    final dataList = activityExpensesListBox.read('ExpensesList');

    if (dataList != null) {
      for (final data in dataList) {
        final List<dynamic> sharersList = data['sharers'];

        final List<Person> sharers = sharersList.map((sharer) {
          return Person.fromJson(sharer); // Use fromJson here
        }).toList();

        expenses.add(ActivityExpense(
          name: data['name'],
          amount: data['amount'],
          sharers: sharers,
          category: data['category'],
        ));
      }
    }

    return expenses;
  }

  void removeAllExpenses() {
    activityExpensesListBox.remove('ExpensesList');
  }

  void removeExpenseById(String expenseId) {
    final dataList =
        activityExpensesListBox.read('ExpensesList') as List<dynamic>?;

    if (dataList != null) {
      dataList.removeWhere((data) => data['id'] == expenseId);
      activityExpensesListBox.write('ExpensesList', dataList);
    }
  }

  void divideExpense(List<Person> sharers, double amount, String name) {
    double partOfEach = amount / sharers.length;

    for (var person in sharers) {
      person.totalAmount += partOfEach;
      person.includedExpenses.add(name);
    }
  }
}
