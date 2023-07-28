import 'package:uuid/uuid.dart';

class Person {
  Person(
      {required this.name,
      required this.includedExpenses,
      required this.totalAmount});
  final id = const Uuid().v4();
  String name;
  List<dynamic> includedExpenses;
  double totalAmount;
}
