// To parse this JSON data, do
//
//     final currenciesResponse = currenciesResponseFromJson(jsonString);
//{
//"r030":36,"txt":"Австралійський долар","rate":19.263145,"cc":"AUD","exchangedate":"14.02.2019"
// }

import 'dart:convert';

List<CurrenciesResponse> currenciesResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<CurrenciesResponse>.from(jsonData.map((x) => CurrenciesResponse.fromJson(x)));
}

String currenciesResponseToJson(List<CurrenciesResponse> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class CurrenciesResponse {
  int r030;
  String txt;
  double rate;
  String cc;
  String exchangedate;

  CurrenciesResponse({
    this.r030,
    this.txt,
    this.rate,
    this.cc,
    this.exchangedate,
  });

  factory CurrenciesResponse.fromJson(Map<String, dynamic> json) => new CurrenciesResponse(
    r030: json["r030"],
    txt: json["txt"],
    rate: json["rate"].toDouble(),
    cc: json["cc"],
    exchangedate: json["exchangedate"],
  );

  Map<String, dynamic> toJson() => {
    "r030": r030,
    "txt": txt,
    "rate": rate,
    "cc": cc,
    "exchangedate": exchangedate,
  };
}
