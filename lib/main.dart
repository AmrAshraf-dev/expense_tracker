import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/utils/colors.dart';
import 'package:expense_tracker/view/add_new_expense/bloc/bloc.dart';
import 'package:expense_tracker/view/dashboard/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

double convertToUSD(double amount, double rate) {
  return amount / rate;
}

bool isValidExpense(ExpenseModel expense) {
  return expense.category.isNotEmpty && expense.amount > 0;
}

void main() {
  //Unit Test: Currency Conversion Logic
  test('Currency conversion from EGP to USD', () {
    final egpAmount = 100.0;
    final egpToUsdRate = 50.0; // Example rate
    final expected = 2.0;

    expect(convertToUSD(egpAmount, egpToUsdRate), expected);
  });
  //Unit Test: Expense Validation
  group('Expense Validation', () {
    test('Valid expense returns true', () {
      final expense = ExpenseModel(
          category: 'Groceries', amount: 100.0, date: '2025-06-17');
      expect(isValidExpense(expense), isTrue);
    });

    test('Empty category returns false', () {
      final expense = ExpenseModel(
          category: 'Transportation', amount: 100.0, date: '2025-06-01');
      expect(isValidExpense(expense), isFalse);
    });

    test('Zero amount returns false', () {
      final expense =
          ExpenseModel(category: 'Rent', amount: 0.0, date: '2025-06-18');
      expect(isValidExpense(expense), isFalse);
    });
  });
//
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColor),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        // Add your Bloc providers here
        BlocProvider<CurrencyBloc>(create: (context) => CurrencyBloc()),
      ], child: MyNavigationBar()),
    );
  }
}
