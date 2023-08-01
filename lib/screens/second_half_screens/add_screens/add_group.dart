import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/second_half_controllers/registered_persons_controller.dart';
import 'package:self_test1/models/second_half_models/persons.dart';

RegisteredPersonsController rpc = Get.find();

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({super.key});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  RegisteredPersonsController personController =
      Get.put(RegisteredPersonsController());

  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Dialog(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || value == ' ') {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
                controller: _titleController,
                maxLength: 50,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer),
                decoration: const InputDecoration(
                  label: Text('Ekleyeceğiniz Kişinin İsmini Giriniz :'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'İptal',
                      style: const TextStyle().copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        personController.personsList.add(Person(
                            name: _titleController.text,
                            includedExpenses: [],
                            totalAmount: 0));
                        personController.saveAsGroup(
                            rpc.personsList, _titleController.text);
                        Get.snackbar('Başarılı', 'Grup Başarıyla Eklendi');
                        Get.close(1);
                      }
                    },
                    child: Text(
                      'Grubu Kaydet',
                      style: const TextStyle().copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
