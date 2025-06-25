import 'package:expense_tracker/controller/expense_database.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/view/dashboard/bloc/event.dart';
import 'package:expense_tracker/view/dashboard/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  
  static const int _pageSize = 10;

  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<LoadMoreExpenses>(_onLoadMoreExpenses);
  }

  int _offset = 0;

  Future<void> _onLoadExpenses(
      LoadExpenses event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    try {
      _offset = 0;
      final expenses = await ExpenseDatabase.instance
          .getExpenses(offset: _offset, limit: _pageSize);
      emit(ExpenseLoaded(expenses, hasReachedMax: expenses.length < _pageSize));
    } catch (e) {
      emit(ExpenseError("Failed to load expenses: $e"));
    }
  }

  Future<void> _onLoadMoreExpenses(
      LoadMoreExpenses event, Emitter<ExpenseState> emit) async {
    if (state is ExpenseLoaded) {
      final currentState = state as ExpenseLoaded;
      if (currentState.hasReachedMax) return;

      try {
        _offset += _pageSize;
        final newExpenses = await ExpenseDatabase.instance
            .getExpenses(offset: _offset, limit: _pageSize);
        final allExpenses = List<ExpenseModel>.from(currentState.expenses)
          ..addAll(newExpenses);

        emit(ExpenseLoaded(
          allExpenses,
          hasReachedMax: newExpenses.length < _pageSize,
        ));
      } catch (e) {
        emit(ExpenseError("Failed to load more expenses: $e"));
      }
    }
  }
}
