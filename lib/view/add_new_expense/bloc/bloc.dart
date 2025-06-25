import 'dart:convert';
import 'package:expense_tracker/view/add_new_expense/bloc/event.dart';
import 'package:expense_tracker/view/add_new_expense/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyInitial()) {
    on<FetchCurrencies>(_onFetchCurrencies);
  }

  Future<void> _onFetchCurrencies(FetchCurrencies event, Emitter<CurrencyState> emit) async {
    emit(CurrencyLoading());

    final url = 'https://v6.exchangerate-api.com/v6/d1dee0aed7e5e2c99bc4f9eb/latest/USD';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Map<String, dynamic> conversions = data['conversion_rates'];
        final currencies = conversions.keys.toList();
        final rates = conversions.map((k, v) => MapEntry(k, (v as num).toDouble()));
        emit(CurrencyLoaded(currencies, rates));
      } else {
        emit(CurrencyError("Failed to fetch currencies"));
      }
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }
}