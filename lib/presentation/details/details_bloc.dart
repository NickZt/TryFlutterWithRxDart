import 'package:collection/collection.dart';
import 'package:nbu_currency/model/currencies_response.dart';
import 'package:nbu_currency/presentation/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:nbu_currency/network/api_manager.dart';
import 'package:nbu_currency/presentation/details/details_state.dart';

class DetailsBloc extends BaseBloc {
  DetailsBloc._(this.onDetailsRequested, this.state) {
    reload();
  }

  final Sink onDetailsRequested;

  final Stream<DetailsState> state;

  factory DetailsBloc(ApiManager apiManager, CurrenciesResponse manufacturer) {
    final onDetailsRequested = BehaviorSubject();

    final state = onDetailsRequested
        .switchMap((_) => _getManufacturerDetails(apiManager, manufacturer))
        .startWith(DetailsEmpty());

    return DetailsBloc._(onDetailsRequested, state);
  }

  static Stream<DetailsState> _getManufacturerDetails(
      ApiManager apiManager, CurrenciesResponse manufacturer) async* {
    yield DetailsLoading();

    try {
      print("manufacturer: $manufacturer");
      var result = new List<CurrenciesResponse>();
      result.add(manufacturer);
//      if (result.isNotEmpty) {

      yield DetailsPopulated(UnmodifiableListView(result));
//      } else {
//        yield DetailsEmpty();
//      }
    } catch (e, stacktrace) {
      print(stacktrace);
      yield DetailsError(e);
    }
  }

  void reload() {
    onDetailsRequested.add(Object());
  }

  @override
  void dispose() {
    super.dispose();
    onDetailsRequested.close();
  }
}
