import 'package:flutter/material.dart';

class SavingGoalsScreen extends StatefulWidget {
  const SavingGoalsScreen({super.key});

  @override
  State<SavingGoalsScreen> createState() => _SavingGoalsScreenState();
}

class _SavingGoalsScreenState extends State<SavingGoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Birikim Hedefleriniz'),
      ),
      body: const Text(
        'Birikim Hedeflerş Sayfası Önizleme',
        style: TextStyle(fontSize: 60),
      ),
    );
  }
}
