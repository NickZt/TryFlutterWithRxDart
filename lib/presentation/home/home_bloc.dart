import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:nbu_currency/network/api_manager.dart';
import 'package:nbu_currency/presentation/base/base_bloc.dart';
import 'package:nbu_currency/presentation/home/home_state.dart';

class HomeBloc extends BaseBloc {
  HomeBloc._(this.onCurrenciesRequested, this.state) {
    reload();
  }

  final Sink onCurrenciesRequested;

  final Stream<HomeState> state;

  void reload() {
    onCurrenciesRequested.add(Object());
  }

  factory HomeBloc(ApiManager apiManager) {
    final onCurrenciesRequested = BehaviorSubject();

    final state = onCurrenciesRequested
        .switchMap<HomeState>((_) => _getCurrencies(apiManager))
        .startWith(HomeEmpty());

    return HomeBloc._(onCurrenciesRequested, state);
  }

  static Stream<HomeState> _getCurrencies(ApiManager apiManager) async* {
    print("Get Currencies");
    yield HomeLoading();

    try {
      final result = await apiManager.getCurrencies();
      if (result.isNotEmpty) {
        yield HomePopulated(
            UnmodifiableListView(result));
      } else {
        yield HomeEmpty();
      }
    } catch (e) {
      yield HomeError();
    }
  }

  void dispose() {
    super.dispose();
    onCurrenciesRequested.close();
  }
}
