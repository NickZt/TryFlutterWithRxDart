import 'package:flutter/material.dart';
import 'package:nbu_currency/common/injector.dart';
import 'package:nbu_currency/model/currencies_response.dart';
import 'package:nbu_currency/network/api_manager.dart';
import 'package:nbu_currency/presentation/home/home_page.dart';
import 'package:reactive_sqflite/reactive_database.dart';
import 'package:sqflite/sqflite.dart';

class App extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<App> {

//  todo after debug period refactor databases to inject
  /// Reactive database wrapped around the SQflite database
  ReactiveDatabase _db;

  /// SQflite database
  Database _currency_database;
//  Database _exchange_database;

  Stream stream;
  static const duration =
  Duration(minutes: 1); //to test set 1 instead of 30 in normal


  /// Creates a database and create a  tables
  /// Contains columns id, name
  ///
  /// Returns opened writable database
  Future<Database> _getSQfliteDatabase() async {
    var databasesPath = await getDatabasesPath();
    _currency_database = await openDatabase(databasesPath + "currency.db",
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Exchange (currency_id INTEGER PRIMARY KEY,  name TEXT, code TEXT )');
        });
    return _currency_database;
  }

  @override
  void initState() {
    _getSQfliteDatabase().then((Database database) {
      /// Wraps the created SQflite database with a ReactiveDatabase for reactive support
      setState(() {
        _db = ReactiveDatabase.from(database, logging: true);
      });
    });
    print(" periodical task: ");
    stream = new Stream.periodic(duration, (count) {
      print("Get Currencies Async periodically: $count ");

      return getCurrencies(Injector.getApiManager());
    });

    stream.listen((result) {
      // listen for the result of the periodic task
      print(
          "Get Currencies Async listen for the result of the hourly task: $result");
    });
    super.initState();
  }

  @override
  void dispose() {
    /// Closes reactive database, so no notifications after this
    _db.close();

    // Clase SQflite database
    _currency_database.close();

    super.dispose();
  }

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

  static Stream<List<CurrenciesResponse>> getCurrencies(
      ApiManager apiManager) async* {
    print("Get Currencies Async periodically ");
    try {
      final result = await apiManager.getCurrencies();
      if (result.isNotEmpty) {
        print("Result in periodical task: $result ");

// todo add to BD
      }
    } catch (e) {
      print("Error in periodical task: $e ");
      //
    }
  }
}
