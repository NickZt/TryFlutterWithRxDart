import 'package:flutter/material.dart';
import 'package:nbu_currency/presentation/home/home_page.dart';

class App extends StatelessWidget {
  App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NBU Rates',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: HomePage(
          title: 'NBU Rates',
        ));
  }
}
