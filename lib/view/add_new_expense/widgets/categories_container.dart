import 'package:expense_tracker/widgets/my_text.dart';
import 'package:flutter/material.dart';

class CategoriesContainer extends StatelessWidget {
  Color containerColor;
  Color iconColor;
  Color textColor;
  IconData icon;
  String title;
  Border? border;
  CategoriesContainer(
      {super.key,
      required this.containerColor,
      required this.iconColor,
      required this.textColor,
      required this.icon,
      required this.title,
      this.border,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(50),
            border: border,
            
          ),
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
          ),
        ),
        MyText(title: title, color: textColor, size: 10),
      ],
    );
  }
}
