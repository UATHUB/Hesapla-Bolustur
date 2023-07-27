import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/expense_categories_controller.dart';

import 'package:self_test1/main.dart';

class AddExpenseCategoryScreen extends StatefulWidget {
  const AddExpenseCategoryScreen({super.key});

  @override
  State<AddExpenseCategoryScreen> createState() =>
      _AddExpenseCategoryScreenState();
}

ExpenseController expenseController = Get.find();

class _AddExpenseCategoryScreenState extends State<AddExpenseCategoryScreen> {
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

    return Scaffold(
      body: Padding(
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
                style: TextStyle(color: kDarkColorScheme.onSecondaryContainer),
                decoration: const InputDecoration(
                  label: Text('Ekleyeceğiniz Kategori İsmini Giriniz :'),
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
                      style: const TextStyle()
                          .copyWith(color: kDarkColorScheme.onPrimaryContainer),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        expenseController.expenseCategory
                            .add(_titleController.text);
                        await expenseCategoryBox.write('ExpenseCategoryList',
                            expenseController.expenseCategory);
                        Get.snackbar('Başarılı', 'Kategori Başarıyla Eklendi');
                        Get.close(1);
                      }
                    },
                    child: Text(
                      'Kategoriyi Ekle',
                      style: const TextStyle()
                          .copyWith(color: kDarkColorScheme.onPrimaryContainer),
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
