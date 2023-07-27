import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/expense_categories_controller.dart';
import 'package:self_test1/controllers/first_half_controllers/expenses_list_controller.dart';
import 'package:self_test1/controllers/first_half_controllers/income_categories_controller.dart';
import 'package:self_test1/controllers/first_half_controllers/incomes_list_controller.dart';
import 'package:self_test1/controllers/first_half_controllers/page_controller.dart';
import 'package:self_test1/models/first_half_models/expense.dart';
import 'package:self_test1/models/first_half_models/income.dart';
import 'package:self_test1/widgets/first_half_widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  void readAllData() {
    ExpenseController e = Get.put(ExpenseController());
    e.readExpenseCategory();
    IncomeController i = Get.put(IncomeController());
    i.readIncomeCategory();

    RegisteredExpensesController re = Get.put(RegisteredExpensesController());
    List<Expense> registeredExpenses = re.getAllExpenses();
    re.registeredExpenses = registeredExpenses;
    RegisteredIncomesController ri = Get.put(RegisteredIncomesController());
    List<Income> registeredIncomes = ri.getAllIncomes();
    ri.registeredIncomes = registeredIncomes;
  }

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.index = 1;
    readAllData();
  }

  PageSelecter pc = Get.put(PageSelecter());

  static List<Widget> myTabs = <Widget>[
    const Tab(
      text: 'Gelirler',
      icon: Icon(Icons.account_balance_rounded),
      height: 50,
    ),
    const Tab(
      text: 'Özet',
      icon: Icon(Icons.list_alt_rounded),
      height: 60,
    ),
    const Tab(
      text: 'Harcamalar',
      icon: Icon(Icons.add_card_rounded),
      height: 50,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    readAllData();
    //var currentPage = _tabController.index.obs;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: double.minPositive,
        automaticallyImplyLeading: false,
      ),
      endDrawer: const MainDrawer(),
      bottomNavigationBar: Material(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(25),
        type: MaterialType.card,
        child: Row(
          children: [
            Expanded(
              child: TabBar(
                indicatorWeight: 4,
                tabs: myTabs,
                controller: _tabController,
              ),
            ),
            EndDrawerButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(60, 60)),
                    maximumSize: null)),
          ],
        ),
      ),
      // const TabBar(
      //   dragStartBehavior: DragStartBehavior.down,
      //   enableFeedback: true,
      //   isScrollable: false,
      //   tabs: [
      //     Tab(
      //       icon: Icon(Icons.account_balance),
      //       text: 'Gelirler',
      //     ),
      //     Tab(
      //       icon: Icon(Icons.list_alt_outlined),
      //       text: 'Özet',
      //     ),
      //     Tab(
      //       icon: Icon(Icons.add_card_rounded),
      //       text: 'Harcamalar',
      //     ),
      //   ],
      // ),

      // BottomNavigationBar(
      // onTap: _selectPage,
      // currentIndex: _selectedPageIndex,
      // items: const [
      // BottomNavigationBarItem(
      // icon: Icon(
      // Icons.account_balance,
      // size: 20,
      // ),
      // label: 'Gelirler',
      // ),
      // BottomNavigationBarItem(
      // icon: Icon(
      // Icons.list_alt_outlined,
      // size: 30,
      // ),
      // label: 'Özet',
      // ),
      // BottomNavigationBarItem(
      // icon: Icon(
      // Icons.add_card_rounded,
      // size: 20,
      // ),
      // label: 'Harcamalar',
      // ),
      // ],
      // ),
      body: TabBarView(
        controller: _tabController,
        children: [
          pc.setScreen(2),
          pc.setScreen(0),
          pc.setScreen(1),
        ],
      ),
    );
  }
}
//pc.setScreen(convertSelectedIndex(_selectedPageIndex)),
