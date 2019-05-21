import 'package:currency_converter/main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Map> getData() async {
  http.Response response = await http.get(requestURL);
  return json.decode(response.body)['results']['currencies'];
}