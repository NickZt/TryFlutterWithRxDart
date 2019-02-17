import 'package:flutter/material.dart';
import 'package:nbu_currency/common/injector.dart';
import 'package:nbu_currency/common/navigation_utils.dart';
import 'package:nbu_currency/model/currencies_response.dart';
import 'package:nbu_currency/presentation/base/navigation_state.dart';
import 'package:nbu_currency/presentation/home/home_bloc.dart';
import 'package:nbu_currency/presentation/home/home_state.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.data}) : super(key: key);

  final String title;
  final Object data;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends NavigationState<HomePage, HomeBloc> {
  final padding = const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0);

  @override
  void initState() {
    bloc = HomeBloc(Injector.getApiManager());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<HomeState>(
          stream: bloc.state,
          initialData: HomeEmpty(),
          builder: (context, snapshot) {
            if (snapshot.data is HomePopulated)

              return ListView(
                children: (snapshot.data as HomePopulated)
                    .result
                    .map(_buildItem)
                    .toList(),
              );

            if (snapshot.data is HomeEmpty) {
              return GestureDetector(
                child: Center(child: Text("Empty")),
                onTap: bloc.reload,
              );
            }

            return Center(child: CircularProgressIndicator());
          }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Padding _createLabel(String text) =>
      Padding(padding: padding, child: Text(text));

  Widget _buildItem(CurrenciesResponse currency) {
    return Padding(
      key: PageStorageKey(currency.r030),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title:
            Text(currency.txt ?? '[no name]', style: TextStyle(fontSize: 24.0)),
        children: <Widget>[
          Row(
            children: <Widget>[
              _createLabel('currency id: ${currency.r030}'),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                  child: _createLabel('currency full name: ${currency.txt}'))
            ],
          ),
          Row(
            children: <Widget>[_createLabel('currency rate: ${currency.rate}')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('additional info'),
                onPressed: () {
                  bloc.navigateTo(Details(data: currency));
                },
                textColor: Theme.of(context).primaryColor,
              )
            ],
          )
        ],
      ),
    );
  }
}
