import 'package:nbu_currency/common/navigation_utils.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  final _navigationSubject = PublishSubject<Screen>();

  Stream<Screen> get navigation => _navigationSubject;

  void navigateTo(Screen screen) {
    print("Navigate from BLoC to screen: $screen");
    _navigationSubject.add(screen);
  }

  void dispose() {
    _navigationSubject.close();
  }
}
