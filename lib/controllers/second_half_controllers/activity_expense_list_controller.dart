import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_test1/controllers/second_half_controllers/registered_persons_controller.dart';
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

  void divideExpenses() {
    RegisteredActivityExpensesController rae =
        Get.put(RegisteredActivityExpensesController());
    List<ActivityExpense> allExpenses = rae.getAllExpenses();
    RegisteredPersonsController rpc = Get.put(RegisteredPersonsController());
    rpc.resetAllData();

    for (var currentExpense in allExpenses) {
      print(currentExpense.name);
      double partOfEach = 0;
      partOfEach = currentExpense.amount / currentExpense.sharers.length;
      print('Harcamaların kaç kişi tarafından bölüşüldüğü:');
      print(currentExpense.sharers.length);
      for (var person in currentExpense.sharers) {
        Person? existingPerson =
            rpc.personsList.firstWhereOrNull((p) => p.name == person.name);
        if (existingPerson != null) {
          existingPerson.includedExpenses.add(currentExpense.name);
          existingPerson.totalAmount += partOfEach;
        } else {
          print('kişi eşleşmedi');
        }
        print(
            '${currentExpense.name} harcaması ${person.name} kişisine eklenmiş olmalı...');
        print('_____________');
      }
    }
    print('TÜM KAYITLI HARCAMALAR:');
    for (var element in rae.registeredActivityExpenses) {
      print(element.name);
    }
    print('KİŞİLERİN HARCAMALARI:');
    for (var person in rpc.personsList) {
      print(person.name);
      print(person.includedExpenses);
      print('__________');
    }
    print('Harcamaları Paylaşanlar');
    for (var element in rae.registeredActivityExpenses) {
      print(element.name);

      for (var i = 0; i < element.sharers.length; i++) {
        print(element.sharers[i].name);
      }
      print(element.amount.toString());
      print('__________');
    }
  }
}
