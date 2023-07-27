import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/income_categories_controller.dart';
import 'package:self_test1/widgets/first_half_widgets/income_categories/income_categories_list.dart';

class CustomizeIncomeCategoriesScreen extends StatefulWidget {
  const CustomizeIncomeCategoriesScreen({super.key});

  @override
  State<CustomizeIncomeCategoriesScreen> createState() =>
      _CustomizeIncomeCategoriesScreenState();
}

IncomeController i = Get.find();

class _CustomizeIncomeCategoriesScreenState
    extends State<CustomizeIncomeCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gelir Kategorileri'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 10.0, left: 5, right: 5),
        child: IncomeCategoriesList(),
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
      //       onPressed: () => i.resetCategory(),
      //       icon: const Icon(Icons.restore),
      //     ),
      //   ],
      // ),
    );
  }
}
