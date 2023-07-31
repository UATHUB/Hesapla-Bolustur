import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:self_test1/controllers/first_half_controllers/expense_categories_controller.dart';
import 'package:self_test1/controllers/second_half_controllers/activity_expense_list_controller.dart';
import 'package:self_test1/controllers/second_half_controllers/registered_persons_controller.dart';
import 'package:self_test1/main.dart';
import 'package:self_test1/models/second_half_models/expense.dart';
import 'package:self_test1/models/second_half_models/persons.dart';

class AddActivityExpenseScreen extends StatefulWidget {
  const AddActivityExpenseScreen(this.onAddExpense, {super.key});

  final void Function(ActivityExpense expense) onAddExpense;

  @override
  State<AddActivityExpenseScreen> createState() =>
      _AddActivityExpenseScreenState();
}

ExpenseController e = Get.put(ExpenseController());
String _selectedCategory = e.expenseCategory.first;
RegisteredPersonsController rpc = Get.put(RegisteredPersonsController());
RegisteredActivityExpensesController rae =
    Get.put(RegisteredActivityExpensesController());

List<Person> selectedPeopleList = [];

class _AddActivityExpenseScreenState extends State<AddActivityExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final List<Person> sharers = [];

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

  void _showTitleDialog() {
    Get.dialog(
      AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        title: Text(
          'Geçersiz Giriş',
          style: const TextStyle().copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        content: Text(
          'Aynı İsimde Birden Fazla Harcama Girilemez',
          style: const TextStyle().copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.close(1);
            },
            child: Text(
              'Tamam',
              style: const TextStyle().copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountIsInvalid) {
      _showDialog();
      return;
    }
    for (var expense in rae.registeredActivityExpenses) {
      if (expense.name == _titleController.text) {
        _showTitleDialog();
        return;
      }
    }

    widget.onAddExpense(
      ActivityExpense(
          name: _titleController.text,
          amount: enteredAmount,
          sharers: selectedPeopleList,
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

  List<String> getNameList(List<Person> personList) {
    List<String> returnList = [];
    for (int i = 0; i < personList.length; i++) {
      returnList[i] = personList[i].name.toString();
    }
    return returnList;
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
                        return 'Harcama başlığı en az 3 karakter içermelidir';
                      }
                      return null;
                    },
                    controller: _titleController,
                    maxLength: 50,
                    style:
                        TextStyle(color: kDarkColorScheme.onSecondaryContainer),
                    decoration: const InputDecoration(
                      label: Text('Harcama Başlığı Giriniz.'),
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
                            label: Text('Harcama Miktarını Giriniz.'),
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
                        items: e.expenseCategory.map<DropdownMenuItem<dynamic>>(
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
                  const SizedBox(height: 10),
                  MultiSelectDialogField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bu alan boş bırakılamaz';
                      }
                      return null;
                    },
                    isDismissible: true,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    itemsTextStyle: const TextStyle().copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                    unselectedColor: Theme.of(context)
                        .colorScheme
                        .errorContainer
                        .withOpacity(0.25),
                    barrierColor: Colors.transparent.withAlpha(175),
                    checkColor: Theme.of(context)
                        .colorScheme
                        .tertiaryContainer
                        .withOpacity(0.75),
                    selectedColor: Theme.of(context)
                        .colorScheme
                        .tertiaryContainer
                        .withOpacity(0.25),
                    chipDisplay: MultiSelectChipDisplay(
                        textStyle: const TextStyle().copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                        chipColor:
                            Theme.of(context).colorScheme.secondaryContainer),
                    selectedItemsTextStyle: const TextStyle().copyWith(
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer),
                    buttonIcon: const Icon(Icons.arrow_drop_down),
                    buttonText: Text(
                      'Harcamaya Dahil Olan Kişileri Seçiniz',
                      style: const TextStyle().copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                    confirmText: const Text('Kişileri Onayla'),
                    cancelText: const Text('İptal'),
                    separateSelectedItems: true,
                    listType: MultiSelectListType.CHIP,
                    title: Text(
                      'Kişileri Seçiniz',
                      style: const TextStyle().copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                      textAlign: TextAlign.center,
                    ),
                    items: rpc.personsList
                        .map((e) => MultiSelectItem(e.id, e.name))
                        .toList(),
                    onConfirm: (values) {
                      selectedPeopleList = values.map((id) {
                        return rpc.personsList
                            .firstWhere((person) => person.id == id);
                      }).toList();
                    },
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
