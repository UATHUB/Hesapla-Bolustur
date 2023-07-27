import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_test1/controllers/first_half_controllers/expenses_list_controller.dart';
import 'package:self_test1/controllers/first_half_controllers/incomes_list_controller.dart';
import 'package:self_test1/screens/first_half_screens/tabs.dart';

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 154, 187, 157),
);

final kLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 213, 231, 174),
);

@override
void main() async {
  RegisteredExpensesController re;
  RegisteredIncomesController ri;

  re = Get.put(RegisteredExpensesController());
  ri = Get.put(RegisteredIncomesController());
  final previousExpensesList = re.getAllExpenses();
  final previousIncomesList = ri.getAllIncomes();
  re.registeredExpenses = previousExpensesList;
  ri.registeredIncomes = previousIncomesList;
  Future.delayed(const Duration(seconds: 1));
  await GetStorage.init('storage');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        scaffoldBackgroundColor: kDarkColorScheme.background,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.secondaryContainer,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData()
            .copyWith(backgroundColor: kDarkColorScheme.secondaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer.withOpacity(0.85),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.secondaryContainer,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData()
            .copyWith(backgroundColor: kDarkColorScheme.secondaryContainer),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.onSecondaryContainer,
              ),
            ),
      ),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kLightColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kLightColorScheme.secondaryContainer,
            foregroundColor: kLightColorScheme.onPrimaryContainer,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData()
              .copyWith(
                  backgroundColor: kLightColorScheme.secondaryContainer,
                  selectedItemColor: kLightColorScheme.onPrimaryContainer),
          cardTheme: const CardTheme().copyWith(
            color: kLightColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kLightColorScheme.primaryContainer,
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData()
              .copyWith(backgroundColor: kLightColorScheme.secondaryContainer),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kLightColorScheme.onSecondaryContainer,
                ),
              )),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    ),
  );
}


// liste içine sayfaları tanımla
//selected index ve index tanımla
// sayfa döndürecek fonksiyon tanımla

//getx dosyasını dağıt