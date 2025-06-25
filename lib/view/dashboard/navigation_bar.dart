import 'package:expense_tracker/utils/colors.dart';
import 'package:expense_tracker/view/add_new_expense/add_new_expense.dart';
import 'package:expense_tracker/view/chart/chart.dart';
import 'package:expense_tracker/view/dashboard/dashboard.dart';
import 'package:expense_tracker/view/profile/profile.dart';
import 'package:expense_tracker/view/wallet/wallet.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  final List screens = [
    Dashboard(),
    Chart(),
    AddNewExpense(),
    Wallet(),
    Profile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: MyColors.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'add expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
