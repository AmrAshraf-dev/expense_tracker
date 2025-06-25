import 'package:expense_tracker/view/dashboard/bloc/bloc.dart';
import 'package:expense_tracker/view/dashboard/bloc/state.dart';
import 'package:expense_tracker/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ExpenseError) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        } else if (state is ExpenseLoaded) {
          final totalAmount =
              state.expenses.fold<double>(0.0, (sum, e) => sum + e.amount);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_downward,
                            size: 16, color: Colors.white),
                      ),
                      SizedBox(width: 5.0),
                      MyText(
                        title: 'Income',
                        size: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  MyText(
                    title: '\$ 10,840.00',
                    size: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_upward,
                            size: 16, color: Colors.white),
                      ),
                      SizedBox(width: 5.0),
                      MyText(
                        title: 'Expenses',
                        size: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 120.0,
                    child: MyText(
                      title: '\$${totalAmount.toString()}',
                      size: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Center(
            child: Text('Unexpected state'),
          );
        }
      },
    );
  }
}
