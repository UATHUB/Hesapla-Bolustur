import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/expense_categories_controller.dart';
import 'package:self_test1/screens/first_half_screens/add_screens/add_expense_category_screen.dart';
import 'package:self_test1/widgets/first_half_widgets/expense_categories/expense_categories_item.dart';
import 'package:flutter/material.dart';

class ExpensesCategoriesList extends StatefulWidget {
  const ExpensesCategoriesList({super.key});

  @override
  State<ExpensesCategoriesList> createState() => _ExpensesCategoriesListState();
}

class _ExpensesCategoriesListState extends State<ExpensesCategoriesList> {
  void removeCategory(index) {
    var item = expenseController.expenseCategory[index];
    expenseController.expenseCategory.removeAt(index);
    expenseCategoryBox.remove('ExpensesCategoriesList');
    Get.snackbar(
      'Başarılı',
      'Kategori Başarıyla Silindi',
      mainButton: TextButton(
        onPressed: () {
          Get.closeAllSnackbars();
          setState(() {
            expenseController.expenseCategory.insert(index, item);
            expenseController.readExpenseCategory;
          });
        },
        child: const Text('Geri Al'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ExpenseController expenseController = Get.put(ExpenseController());

    expenseController.readExpenseCategory();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: expenseController.expenseCategory.length,
            itemBuilder: (ctx, index) => Center(
              child: Dismissible(
                background: Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.error.withOpacity(0.50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: Theme.of(context).cardTheme.margin,
                ),
                key: ValueKey(expenseController.expenseCategory[index]),
                onDismissed: (direction) {
                  // e.expenseCategory.removeAt(index);
                  setState(() {
                    removeCategory(index);
                  });
                },
                child: ExpenseCategoriesItem(
                    expenseController.expenseCategory[index]),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                await Get.dialog(const AddExpenseCategoryScreen());
                setState(() {});
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  padding: const EdgeInsets.all(16),
                  width: 220,
                  height: 65,
                  margin: const EdgeInsets.all(12),
                  child: const Icon(Icons.add)),
            ),
            InkWell(
              onTap: () {
                expenseController.resetCategory();
                Get.showSnackbar(const GetSnackBar(
                  message: 'Kategoriler Başarıyla Sıfırlandı',
                ));
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  padding: const EdgeInsets.all(12),
                  height: 65,
                  width: 65,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(12),
                  child: const Icon(Icons.restore)),
            ),
          ],
        ),
      ],
    );
  }
}

//mvvm
//mvc
//flutterda kullanılacak mimariler (design patterns)

//Sorun dosyanın read işleminde oluyor