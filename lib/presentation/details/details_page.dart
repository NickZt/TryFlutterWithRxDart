import 'package:flutter/material.dart';
import 'package:nbu_currency/common/injector.dart';
import 'package:nbu_currency/model/currencies_response.dart';
import 'package:nbu_currency/presentation/base/navigation_state.dart';
import 'package:nbu_currency/presentation/details/details_bloc.dart';
import 'package:nbu_currency/presentation/details/details_state.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.title, this.data}) : super(key: key) {
    if (data != null) print(data);
  }

  final String title;
  final Object data;

  @override
  State createState() => _DetailsState();
}

class _DetailsState extends NavigationState<DetailsPage, DetailsBloc> {
  final padding = const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0);

  @override
  void initState() {
    print("init state");
    bloc = DetailsBloc(Injector.getApiManager(), widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
          stream: bloc.state,
          builder: (context, snapshot) {
            //todo list records from bd
            if (snapshot.data is DetailsPopulated)
              return ListView(
                children: (snapshot.data as DetailsPopulated)
                    .data
                    .map(_buildItem)
                    .toList(),
              );

            if (snapshot.data is DetailsEmpty) {
              return GestureDetector(
                child: Center(child: Text("Empty")),
                onTap: bloc.reload,
              );
            }

            if (snapshot.data is DetailsError) {
              return Center(
                child: Text("Error: ${(snapshot.data as DetailsError).e}"),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Row _createRow(String text) => Row(
        children: <Widget>[
          Padding(padding: padding, child: Text(text)),
        ],
      );

  Widget _buildItem(CurrenciesResponse currency) {
    return Padding(
      key: PageStorageKey(currency.r030),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(
            currency.exchangedate + " " + currency.cc ??
                currency.txt ??
                currency.cc ??
                'Unknown code',
            style: TextStyle(fontSize: 24.0)),
        children: <Widget>[
          _createRow('exchange date: ${currency.exchangedate ?? "-"}'),
          _createRow('Currency name: ${currency.txt ?? "-"} '),
          _createRow('Currency code: ${currency.cc ?? "-"}'),
          _createRow('exchange rate: ${currency.rate ?? "-"} '),
        ],
      ),
    );
  }
}
