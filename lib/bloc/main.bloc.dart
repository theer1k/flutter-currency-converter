import 'package:currency_converter/services/main.service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  BehaviorSubject<Map<String, dynamic>> _finance = BehaviorSubject<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get finance => _finance.stream;

  BehaviorSubject<double> _dolar = BehaviorSubject<double>();
  Stream<double> get dolar => _dolar.stream;

  BehaviorSubject<double> _euro = BehaviorSubject<double>();
  Stream<double> get euro => _euro.stream;

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  init() async {
    var data = await getData();
    _finance.add(data);
    _dolar.add(data["USD"]["buy"]);
    _euro.add(data["EUR"]["buy"]);
  }

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double real = double.parse(text);
    dolarController.text = (real / _dolar.value).toStringAsFixed(2);
    euroController.text = (real / _euro.value).toStringAsFixed(2);
  }

  void dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double dolar = double.parse(text);
    realController.text = (dolar * _dolar.value).toStringAsFixed(2);
    euroController.text = (dolar * _dolar.value / _euro.value).toStringAsFixed(2);
  }

  void euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double euro = double.parse(text);
    realController.text = (euro * _euro.value).toStringAsFixed(2);
    dolarController.text = (euro * _euro.value / _dolar.value).toStringAsFixed(2);
  }

  Widget buildTextField(String label, String prefix, TextEditingController c, Function f) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.amber),
          border: OutlineInputBorder(),
          prefixText: prefix),
      style: TextStyle(color: Colors.amber, fontSize: 25.0),
      onChanged: f,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }

  void dispose() {
    _finance.close();
    _dolar.close();
    _euro.close();
  }
}