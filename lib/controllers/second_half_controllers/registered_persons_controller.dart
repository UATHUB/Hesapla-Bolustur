import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_test1/models/second_half_models/persons.dart';

final registeredPersonsBox = GetStorage('RegisteredPersons');
final registeredGroupsBox = GetStorage('RegisteredGroups');
final List<String> groupsList = [];

class RegisteredPersonsController extends GetxController {
  List<Person> personsList = [
    Person(name: 'ayşe', includedExpenses: [], totalAmount: 0)
  ];

  void savePersons(List<Person> persons) {
    final List<Map<String, dynamic>> dataList = persons.map((person) {
      return {
        'name': person.name,
        'includedExpenses': person.includedExpenses.toList(),
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
        persons.add(Person.fromJson(data));
      }
    }
    return persons;
  }

  void removeAllExpenses() {
    registeredPersonsBox.remove('ExpensesList');
  }

  void resetAllData() {
    for (var person in personsList) {
      person.includedExpenses.clear();
      person.totalAmount = 0;
    }
  }

  void saveAsGroup(List<Person> persons, String name) {
    final List<Map<String, dynamic>> dataList = persons.map((person) {
      return {
        'name': person.name,
        'includedExpenses': person.includedExpenses.toList(),
        'totalAmount': person.totalAmount,
      };
    }).toList();
    int index = groupsList.indexOf(groupsList.last) + 1;
    registeredGroupsBox.write(index.toString(), dataList);
    groupsList[index] = name;
    registeredGroupsBox.write('groupsList', groupsList);
  }

  List<Person> retrieveGroup(String name) {
    int index = groupsList.indexWhere((element) => element == name);

    final List<Person> persons = [];

    final dataList = registeredGroupsBox.read(index.toString());

    if (dataList != null) {
      for (final data in dataList) {
        persons.add(Person.fromJson(data));
      }
    }
    return persons;
  }
}
