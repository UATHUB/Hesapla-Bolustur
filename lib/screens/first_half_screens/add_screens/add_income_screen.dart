import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/income_categories_controller.dart';
import 'package:self_test1/models/first_half_models/income.dart';
import 'package:self_test1/main.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen(this.onAddIncome, {super.key});

  final void Function(Income income) onAddIncome;

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

IncomeController i = Get.put(IncomeController());
String _selectedCategory = i.incomeCategory.first;

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDay = DateTime(now.year - 1, now.month, now.day);
    final lastDay = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDay,
      lastDate: lastDay,
      cancelText: 'İptal',
      confirmText: 'Tamam',
      helpText: 'Tarih Seçiniz',
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          title: Text(
            'Geçersiz Giriş',
            style: const TextStyle().copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
          content: Text(
            'Lütfen tüm verilerin doğru bir şekilde girildiğine emin olun.',
            style: const TextStyle().copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text(
                'Tamam',
                style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onErrorContainer),
              ),
            ),
          ],
        );
      },
    );
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddIncome(
      Income(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constrains) {
        return SingleChildScrollView(
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
                      if (value.length < 3) {
                        return 'Gelir başlığı en az 3 karakter içermelidir';
                      }
                      return null;
                    },
                    controller: _titleController,
                    maxLength: 50,
                    style:
                        TextStyle(color: kDarkColorScheme.onSecondaryContainer),
                    decoration: const InputDecoration(
                      label: Text('Gelir Başlığı Giriniz.'),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == ' ') {
                              return 'Bu alan boş bırakılamaz';
                            }
                            return null;
                          },
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: kDarkColorScheme.onSecondaryContainer),
                          decoration: const InputDecoration(
                            suffixText: '₺',
                            label: Text('Gelir Miktarını Giriniz.'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Harcama Kategorisi Seçiniz :',
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      const Spacer(),
                      DropdownButton(
                        dropdownColor: kDarkColorScheme.secondaryContainer,
                        value: _selectedCategory,
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                        underline: Container(
                          height: 1,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer
                              .withOpacity(0.65),
                        ),
                        items: i.incomeCategory.map<DropdownMenuItem<dynamic>>(
                          (dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Harcama Tarihi Seçiniz: ',
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _selectedDate == null
                            ? 'Tarih Seçilmedi'
                            : formatter.format(_selectedDate!),
                        style: _selectedDate == null
                            ? const TextStyle().copyWith(
                                color: kDarkColorScheme.errorContainer)
                            : const TextStyle().copyWith(
                                color: kDarkColorScheme.onSecondaryContainer),
                      ),
                      IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedDate = DateTime.now();
                            });
                          },
                          icon: const Icon(Icons.add_to_home_screen_outlined)),
                    ],
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
                              color: kDarkColorScheme.onPrimaryContainer),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _submitExpense();
                          }
                        },
                        child: Text(
                          'Harcamayı Ekle',
                          style: const TextStyle().copyWith(
                              color: kDarkColorScheme.onPrimaryContainer),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
