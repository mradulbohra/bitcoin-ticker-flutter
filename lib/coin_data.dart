import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
const api = '52CA647B-81BC-4662-A6C7-4F2AA6526613';
const api2 = 'E33B34DD-F5FB-441E-9C99-36A154D56403';
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

class CoinData {

//  final String url;
//  CoinData({});

  Future getData(String from, String to) async
  {
    http.Response response = await http.get('https://rest.coinapi.io/v1/exchangerate/$from/$to?apikey=$api2');
//    http.Response response = await  http.get('https://rest.coinapi.io/v1/exchangerate/$from/$to?apikey=$api');

    //  print(response.statusCode);
    if(response.statusCode==200)
    {
      String data = response.body;
      // print(data);
      return jsonDecode(data);
    }
    else{
      print(response.statusCode);
      return null;
    }

  }

}
