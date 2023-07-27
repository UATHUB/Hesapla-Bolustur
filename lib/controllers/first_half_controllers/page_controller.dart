import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:self_test1/screens/second_half_screens/b_home_screen.dart';
import 'package:self_test1/screens/first_half_screens/drawer_screens/customize_expense_categories_screen.dart';
import 'package:self_test1/screens/first_half_screens/drawer_screens/customize_income_categories_screen.dart';
import 'package:self_test1/screens/first_half_screens/drawer_screens/expense_goals_screen.dart';
import 'package:self_test1/screens/first_half_screens/drawer_screens/savings_goals_screen.dart';
import 'package:self_test1/screens/first_half_screens/expenses_screen.dart';
import 'package:self_test1/screens/first_half_screens/incomes_screen.dart';
import 'package:self_test1/screens/first_half_screens/summary_screen.dart';
import 'package:self_test1/screens/first_half_screens/tabs.dart';

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
  ];

  void goToSecondPart() {
    Get.off(
      const BHomeScreen(),
      transition: Transition.circularReveal,
      duration: const Duration(milliseconds: 600),
    );
  }

  void goToFirstPart() {
    Get.off(
      const HomeScreen(),
      transition: Transition.circularReveal,
      duration: const Duration(milliseconds: 600),
    );
  }

  void getScreen(int index) {
    Get.close(1);
    Get.to(() => setScreen(index),
        transition: Transition.topLevel,
        duration: const Duration(milliseconds: 650));
  }

  Widget setScreen(int index) {
    return pagesList[index];
  }
}
