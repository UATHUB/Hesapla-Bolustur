import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final incomeCategoryBox = GetStorage('incomeCategory');

class IncomeController extends GetxController {
  List<dynamic> incomeCategory = [].obs;
  RxInt index = 0.obs;

  void readIncomeCategory() {
    incomeCategory = incomeCategoryBox.read('IncomeCategoryList') ??
        ['maaş', 'harçlık', 'ek iş', 'borç', 'ekstra'];
  }

  void resetCategory() {
    incomeCategory = ['maaş', 'harçlık', 'ek iş', 'borç', 'ekstra'];
    incomeCategoryBox.write('IncomeCategoryList', incomeCategory);
  }
}
