import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/income_categories_controller.dart';
import 'package:self_test1/screens/first_half_screens/add_screens/add_income_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:self_test1/widgets/first_half_widgets/income_categories/income_categories_item.dart';

class IncomeCategoriesList extends StatefulWidget {
  const IncomeCategoriesList({super.key});

  @override
  State<IncomeCategoriesList> createState() => _IncomeCategoriesListState();
}

class _IncomeCategoriesListState extends State<IncomeCategoriesList> {
  void removeCategory(index) {
    var item = incomeController.incomeCategory[index];
    incomeController.incomeCategory.removeAt(index);
    incomeCategoryBox.remove('IncomeCategoriesList');
    Get.snackbar(
      'Başarılı',
      'Kategori Başarıyla Silindi',
      mainButton: TextButton(
          child: const Text('Geri Al'),
          onPressed: () {
            Get.closeCurrentSnackbar();
            setState(() {
              incomeController.incomeCategory.insert(index, item);
              incomeController.readIncomeCategory;
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    IncomeController incomeController = Get.put(IncomeController());

    incomeController.readIncomeCategory();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: incomeController.incomeCategory.length,
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
                key: ValueKey(incomeController.incomeCategory[index]),
                onDismissed: (direction) {
                  setState(() {
                    removeCategory(index);
                  });
                },
                child: IncomeCategoriesItem(
                    incomeController.incomeCategory[index]),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                await Get.dialog(const AddIncomeCategoryScreen());
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
                incomeController.resetCategory();
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
