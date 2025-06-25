import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_tracker/controller/database_helper.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/utils/colors.dart';
import 'package:expense_tracker/view/dashboard/bloc/bloc.dart';
import 'package:expense_tracker/view/dashboard/bloc/event.dart';
import 'package:expense_tracker/view/dashboard/bloc/state.dart';
import 'package:expense_tracker/view/dashboard/widgets/balance_widget.dart';
import 'package:expense_tracker/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<String> options = ['This month', 'Last 7 days', 'Yesterday'];
  String? selectedValue;

  final ScrollController _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<ExpenseBloc>().add(LoadMoreExpenses());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseBloc()..add(LoadExpenses()),
      child: Builder(
        builder: (context) {
          _setupScrollController(context);
          return Scaffold(
            body: Column(
              children: [
                Container(
                  color: MyColors.primaryColor,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: const CircleAvatar(
                              //radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                title: 'Good Morning',
                                size: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                              MyText(
                                title: 'Shihab Rahman',
                                size: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          //dropdown list
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child:

                                //Dropdown
                                DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                border: InputBorder.none,
                                fillColor: Colors.grey[200],
                                filled: true,
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color:
                                        Colors.grey[200] ?? Colors.transparent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              hint: const Text(
                                'Select',
                                style: TextStyle(fontSize: 14),
                              ),
                              items: options
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                //Do something when selected item is changed.
                                selectedValue = value.toString();
                              },
                              onSaved: (value) {
                                selectedValue = value.toString();
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.black45,
                                ),
                                iconSize: 24,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Transform.translate(
                        offset: const Offset(0, 60),
                        child: Container(
                          // height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            color: MyColors.secondaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            MyText(
                                              title: 'Total Balance',
                                              size: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            const SizedBox(width: 10),
                                            Icon(
                                              Icons.keyboard_arrow_up_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        MyText(
                                          title:
                                              '\$ 2,548.00', //Total balance should be Income - Expense but i don't have the income data to calculate the total balance
                                          size: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    // Icon
                                    Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ],
                                ),
                                //Income and Expense
                                SizedBox(height: 25.0),
                                BalanceWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        title: 'Recent Expenses',
                        size: 17,
                      ),
                      MyText(
                        title: 'see all',
                        size: 13,
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ExpenseBloc, ExpenseState>(
                    builder: (context, state) {
                  if (state is ExpenseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ExpenseLoaded) {
                    return Expanded(
                      child: state.expenses.isEmpty
                          ? Center(child: Text('No expenses found.'))
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: state.expenses.length + 1,
                              itemBuilder: (context, index) {
                                if (index < state.expenses.length) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                  Icons.shopping_cart_outlined,
                                                  size: 30,
                                                  color: Colors.blue),
                                            ),
                                            SizedBox(width: 10.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText(
                                                  title: state.expenses[index]
                                                          .category ??
                                                      '',
                                                  size: 17,
                                                ),
                                                MyText(
                                                  title: 'Manually',
                                                  size: 13,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 70,
                                                  child: MyText(
                                                    title:
                                                        '\$${state.expenses[index].amount.toString() ?? ''}',
                                                    size: 17,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                MyText(
                                                  title: state.expenses[index]
                                                          .date ??
                                                      '',
                                                  size: 13,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return state.hasReachedMax
                                      ? const SizedBox.shrink()
                                      : const Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                }
                              },
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics()),
                    );
                  } else if (state is ExpenseError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('No data found.'));
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
