import 'package:currency_converter/screens/main.screen.dart';
import 'package:flutter/material.dart';

const requestURL = "https://api.hgbrasil.com/finance?format=json&key=bb1542a6";

void main() {
  runApp(MaterialApp(
    home: MainScreen(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}
