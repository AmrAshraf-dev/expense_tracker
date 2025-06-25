import 'package:expense_tracker/model/expense_model.dart';

abstract class ExpenseState {
  final List<ExpenseModel>? expenses;
  final bool hasMore;

  ExpenseState({this.expenses, this.hasMore = true});
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<ExpenseModel> expenses;
  final bool hasReachedMax;

  ExpenseLoaded(this.expenses, {this.hasReachedMax = false});
}

class ExpenseError extends ExpenseState {
  final String message;

  ExpenseError(this.message);
}
