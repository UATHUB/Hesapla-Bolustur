import 'package:uuid/uuid.dart';

// class Person {
//   Person(
//       {required this.name,
//       required this.includedExpenses,
//       required this.totalAmount});
//   final id = const Uuid().v4();
//   String name;
//   List<dynamic> includedExpenses;
//   double totalAmount;
// }

class Person {
  final id = const Uuid().v4();
  final String name;
  final List<dynamic> includedExpenses;
  double totalAmount;

  Person({
    required this.name,
    required this.includedExpenses,
    required this.totalAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'includedExpenses': includedExpenses,
      'totalAmount': totalAmount,
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      includedExpenses: json['includedExpenses'],
      totalAmount: json['totalAmount'],
    );
  }
}
