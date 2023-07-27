import 'package:self_test1/models/second_half_models/persons.dart';

class ActivityExpense {
  ActivityExpense(
      {required this.amount,
      required this.category,
      required this.name,
      required this.sharers});

  String category;
  String name;
  double amount;
  List<Person> sharers;

  void divideExpense(List<Person> sharers, double amount, String name) {
    double partOfEach = amount / sharers.length;

    for (var person in sharers) {
      person.totalAmount += partOfEach;
      person.includedExpenses.add(name);
    }
  }
}
