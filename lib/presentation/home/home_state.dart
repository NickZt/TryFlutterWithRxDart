import 'package:nbu_currency/model/currencies_response.dart';

class HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}

class HomePopulated extends HomeState {
  final List<CurrenciesResponse > result;

  HomePopulated(this.result);
}

class HomeEmpty extends HomeState {}
