class Person {
  Person(
      {required this.name,
      required this.includedExpenses,
      required this.totalAmount});

  String name;
  List<dynamic> includedExpenses;
  double totalAmount;
}
