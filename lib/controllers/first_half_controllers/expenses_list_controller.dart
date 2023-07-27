import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_test1/models/first_half_models/expense.dart';

final expensesListBox = GetStorage('expensesList');

class RegisteredExpensesController extends GetxController {
  List<Expense> registeredExpenses = [];

  void saveExpenses(List<Expense> expenses) {
    final List<Map<String, dynamic>> dataList = expenses.map((expense) {
      return {
        'title': expense.title,
        'amount': expense.amount,
        'date': expense.date.toIso8601String(),
        'category': expense.category,
      };
    }).toList();

    expensesListBox.write('ExpensesList', dataList);
  }

  List<Expense> getAllExpenses() {
    final List<Expense> expenses = [];

    final dataList = expensesListBox.read('ExpensesList');

    if (dataList != null) {
      for (final data in dataList) {
        expenses.add(Expense(
          title: data['title'],
          amount: data['amount'],
          date: DateTime.parse(data['date']),
          category: data['category'],
        ));
      }
    }

    return expenses;
  }

  void removeAllExpenses() {
    expensesListBox.remove('ExpensesList');
  }

  void removeExpenseById(String expenseId) {
    final dataList = expensesListBox.read('ExpensesList') as List<dynamic>?;

    if (dataList != null) {
      dataList.removeWhere((data) => data['id'] == expenseId);
      expensesListBox.write('ExpensesList', dataList);
    }
  }
}
