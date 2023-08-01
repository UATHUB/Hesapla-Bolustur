import 'package:self_test1/models/second_half_models/persons.dart';
import 'package:uuid/uuid.dart';

class ActivityExpense {
  ActivityExpense(
      {required this.amount,
      required this.category,
      required this.name,
      required this.sharers});

  final id = const Uuid().v4();
  String category;
  String name;
  double amount;
  List<Person> sharers;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'category': category,
      'sharers': sharers.map((sharer) => sharer.toJson()).toList(),
    };
  }

  factory ActivityExpense.fromJson(Map<String, dynamic> json) {
    return ActivityExpense(
      name: json['name'],
      amount: json['amount'],
      category: json['category'],
      sharers: List<Person>.from(
          json['sharers'].map((sharerJson) => Person.fromJson(sharerJson))),
    );
  }
}
