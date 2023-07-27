import 'package:flutter/material.dart';

class ExpensesGoalsScreen extends StatefulWidget {
  const ExpensesGoalsScreen({super.key});

  @override
  State<ExpensesGoalsScreen> createState() => _ExpensesGoalsScreenState();
}

class _ExpensesGoalsScreenState extends State<ExpensesGoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harcama Hedefleriniz'),
      ),
      body: const Text(
        'Harcama Hedefleri Sayfası Önizleme',
        style: TextStyle(fontSize: 60),
      ),
    );
  }
}
