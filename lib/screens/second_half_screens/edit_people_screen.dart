import 'package:flutter/material.dart';
import 'package:self_test1/widgets/second_half_widgets/people_list/people_list.dart';

class EditPeopleScreen extends StatelessWidget {
  const EditPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kişileri Düzenle'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: PeopleList(),
      ),
    );
  }
}
