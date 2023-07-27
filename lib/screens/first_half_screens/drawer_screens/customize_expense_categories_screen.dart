import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/expense_categories_controller.dart';
import 'package:self_test1/widgets/first_half_widgets/expense_categories/expense_categories_list.dart';

class CustomizeExpenseCategoriesScreen extends StatefulWidget {
  const CustomizeExpenseCategoriesScreen({super.key});

  @override
  State<CustomizeExpenseCategoriesScreen> createState() =>
      _CustomizeExpenseCategoriesScreenState();
}

ExpenseController e = Get.find();

class _CustomizeExpenseCategoriesScreenState
    extends State<CustomizeExpenseCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harcama Kategorileri'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 10.0, left: 5, right: 5),
        child: ExpensesCategoriesList(),
      ),
      // bottomNavigationBar: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     IconButton.outlined(
      //       style: const ButtonStyle().copyWith(
      //           fixedSize: MaterialStateProperty.all(const Size(400, 60)),
      //           maximumSize: null),
      //       onPressed: () => Get.to(() => const AddExpenseCategoryScreen()),
      //       icon: const Icon(Icons.add_box_rounded),
      //     ),
      //     IconButton(
      //       onPressed: () => e.resetCategory(),
      //       icon: const Icon(Icons.restore),
      //     ),
      //   ],
      // ),
    );
  }
}
