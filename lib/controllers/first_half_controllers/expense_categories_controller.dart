import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final expenseCategoryBox = GetStorage('expenseCategory');

class ExpenseController extends GetxController {
  List<dynamic> expenseCategory = [].obs;
  RxInt index = 0.obs;

  void readExpenseCategory() async {
    expenseCategory = expenseCategoryBox.read('ExpenseCategoryList') ??
        ['yemek', 'seyehat', 'eğlence', 'iş', 'okul', 'alışveriş'];
  }

  void resetCategory() {
    expenseCategory = [
      'yemek',
      'seyehat',
      'eğlence',
      'iş',
      'okul',
      'alışveriş'
    ];
    expenseCategoryBox.write('ExpenseCategoryList', expenseCategory);
  }
}
