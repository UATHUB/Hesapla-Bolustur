import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/second_half_controllers/activity_expense_list_controller.dart';
import 'package:self_test1/controllers/second_half_controllers/registered_persons_controller.dart';
import 'package:self_test1/models/second_half_models/expense.dart';
import 'package:self_test1/models/second_half_models/persons.dart';
import 'package:self_test1/screens/second_half_screens/b_home_screen.dart';
import 'package:self_test1/screens/first_half_screens/drawer_screens/customize_expense_categories_screen.dart';
import 'package:self_test1/screens/first_half_screens/drawer_screens/customize_income_categories_screen.dart';
import 'package:self_test1/screens/first_half_screens/drawer_screens/expense_goals_screen.dart';
import 'package:self_test1/screens/first_half_screens/drawer_screens/savings_goals_screen.dart';
import 'package:self_test1/screens/first_half_screens/expenses_screen.dart';
import 'package:self_test1/screens/first_half_screens/incomes_screen.dart';
import 'package:self_test1/screens/first_half_screens/summary_screen.dart';
import 'package:self_test1/screens/first_half_screens/tabs.dart';
import 'package:self_test1/screens/second_half_screens/edit_people_screen.dart';

class PageSelecter extends GetxController {
  List<Widget> pagesList = const [
    /*0*/ SummaryScreen(),
    /*1*/ ExpensesScreen(),
    /*2*/ IncomesScreen(),
    /*3*/ CustomizeExpenseCategoriesScreen(),
    /*4*/ CustomizeIncomeCategoriesScreen(),
    /*5*/ ExpensesGoalsScreen(),
    /*6*/ SavingGoalsScreen(),
    /*7*/ BHomeScreen(),
    /*8*/ EditPeopleScreen(),
  ];

  void getScreen(int index) {
    Get.close(1);
    Get.to(() => setScreen(index),
        transition: Transition.topLevel,
        duration: const Duration(milliseconds: 650));
  }

  Widget setScreen(int index) {
    return pagesList[index];
  }

  void goToSecondPart() {
    Get.to(
      const BHomeScreen(),
      transition: Transition.circularReveal,
      duration: const Duration(milliseconds: 600),
    );
    RegisteredActivityExpensesController rae = Get.find();
    List<ActivityExpense> previousList = rae.getAllExpenses();
    RegisteredPersonsController rpc = Get.find();
    List<Person> previousPeople = rpc.getAllPersons();
    rae.registeredActivityExpenses = previousList;
    rpc.personsList = previousPeople;
    for (var element in previousList) {
      print(element.name);
    }
  }

  void goToFirstPart() {
    Get.to(
      const HomeScreen(),
      transition: Transition.circularReveal,
      duration: const Duration(milliseconds: 600),
    );
    RegisteredActivityExpensesController rae = Get.find();
    rae.saveExpenses(rae.registeredActivityExpenses);
    RegisteredPersonsController rpc = Get.find();
    rpc.savePersons(rpc.personsList);
  }
}
