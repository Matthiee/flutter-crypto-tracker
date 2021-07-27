import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<Map<String, String>> getBitcoinPrice(String currency) async {
    Map<String, String> priceList = {};

    final apiKey = env['COINAPI'];

    for (var crypto in cryptoList) {
      final url = '$apiURL/$crypto/$currency?apikey=$apiKey';
      final result = await http.get(Uri.parse(url));

      final body = result.body;
      final json = jsonDecode(body) as Map<String, dynamic>;

      double price = json['rate'];

      priceList[crypto] = price.toStringAsFixed(1);
    }

    return priceList;
  }
}
