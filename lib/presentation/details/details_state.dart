import 'package:nbu_currency/model/currencies_response.dart';

class DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsError extends DetailsState {
  final dynamic e;

  DetailsError(this.e);
}

class DetailsPopulated extends DetailsState {
  final List<CurrenciesResponse> data;

  DetailsPopulated(this.data);
}

class DetailsEmpty extends DetailsState {}
