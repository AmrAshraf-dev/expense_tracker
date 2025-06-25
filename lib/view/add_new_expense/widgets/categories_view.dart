import 'package:expense_tracker/utils/colors.dart';
import 'package:expense_tracker/view/add_new_expense/widgets/categories_container.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CategoriesContainer(
              containerColor: Colors.grey[200] ?? Colors.transparent,
              iconColor: Colors.blue,
              textColor: Colors.black,
              icon: Icons.shopping_cart_outlined,
              title: 'Groceries',
            ),
            CategoriesContainer(
              containerColor: MyColors.primaryColor,
              iconColor: Colors.white,
              textColor: Colors.blue,
              icon: Icons.theaters_outlined,
              title: 'Entertainment',
            ),
            CategoriesContainer(
              containerColor: Colors.pink[100] ?? Colors.transparent,
              iconColor: Colors.pink,
              textColor: Colors.black,
              icon: Icons.local_gas_station_outlined,
              title: 'Gas',
            ),
            CategoriesContainer(
              containerColor: Colors.yellow[100] ?? Colors.transparent,
              iconColor: Colors.yellow,
              textColor: Colors.black,
              icon: Icons.shopping_bag_outlined,
              title: 'Shopping',
            ),
          ],
        ),
        SizedBox(height: 16.0),

        ///2ND LINE
        ///
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoriesContainer(
              containerColor: Colors.grey[100] ?? Colors.transparent,
              iconColor: Colors.orange[200] ?? Colors.transparent,
              textColor: Colors.black,
              icon: Icons.newspaper_outlined,
              title: 'News paper',
            ),
            CategoriesContainer(
              containerColor: Colors.purple[50] ?? Colors.transparent,
              iconColor: Colors.blue,
              textColor: Colors.black,
              icon: Icons.emoji_transportation_outlined,
              title: 'Transport',
            ),
            CategoriesContainer(
              containerColor: Colors.grey[100] ?? Colors.transparent,
              iconColor: Colors.orange[200] ?? Colors.transparent,
              textColor: Colors.black,
              icon: Icons.handshake_outlined,
              title: 'Rent',
            ),
            CategoriesContainer(
              containerColor: Colors.transparent,
              iconColor: Colors.blue,
              textColor: Colors.black,
              icon: Icons.add,
              title: 'Add category',
              border: Border.all(
                color: Colors.blue,
                width: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
