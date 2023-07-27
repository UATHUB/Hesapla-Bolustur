import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_test1/models/second_half_models/persons.dart';

final registeredPersonsBox = GetStorage('RegisteredPersons');

class RegisteredPersonsController extends GetxController {
  List<Person> personsList = [];
  RxInt index = 0.obs;

  void readIncomeCategory() {
    personsList = registeredPersonsBox.read('RegisteredPersons') ?? [];
  }

  void resetCategory() {
    personsList = [];
    registeredPersonsBox.write('IncomeCategoryList', personsList);
  }
}
