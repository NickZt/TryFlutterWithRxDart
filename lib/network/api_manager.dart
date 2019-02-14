import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nbu_currency/model/currencies_response.dart';

class ApiManager {
  Future<List<CurrenciesResponse>> getCurrencies() async {
    final response = await http.get(
        "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange-?format=json");

    print("Response: $response");
    if (response.statusCode == 200) {
      return currenciesResponseFromJson(response.body);
    } else {
      throw Exception("Failed to load Currencies");
    }
  }

}
