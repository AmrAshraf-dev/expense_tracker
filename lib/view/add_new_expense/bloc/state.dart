abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<String> currencies;
  final Map<String, double> rates;

  CurrencyLoaded(this.currencies, this.rates);
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError(this.message);
}