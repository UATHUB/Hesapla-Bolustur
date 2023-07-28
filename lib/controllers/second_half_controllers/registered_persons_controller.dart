import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_test1/models/second_half_models/persons.dart';

final registeredPersonsBox = GetStorage('RegisteredPersons');

class RegisteredPersonsController extends GetxController {
  List<Person> personsList = [
    Person(name: 'ayşe', includedExpenses: [], totalAmount: 31)
  ];

  void savePersons(List<Person> persons) {
    final List<Map<String, dynamic>> dataList = persons.map((person) {
      return {
        'name': person.name,
        'includedExpenses': person.includedExpenses,
        'totalAmount': person.totalAmount,
      };
    }).toList();

    registeredPersonsBox.write('RegisteredPersons', dataList);
  }

  List<Person> getAllPersons() {
    final List<Person> persons = [];

    final dataList = registeredPersonsBox.read('RegisteredPersons');

    if (dataList != null) {
      for (final data in dataList) {
        persons.add(Person(
            name: data['name'],
            includedExpenses: data['includedExpenses'],
            totalAmount: data['totalAmount']));
      }
    }
    return persons;
  }

  void removeAllExpenses() {
    registeredPersonsBox.remove('ExpensesList');
  }
}
