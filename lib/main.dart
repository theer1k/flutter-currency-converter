import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const requestURL = "https://api.hgbrasil.com/finance?format=json&key=bb1542a6";

void main() async {
  runApp(MaterialApp(
    home: new HomeWidget(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  double dolar, euro;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(color: Colors.amber),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar dados :(",
                    style: TextStyle(color: Colors.amber),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data["USD"]["buy"];
                euro = snapshot.data["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                          size: 150.0, color: Colors.amber),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "R\$"),
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Dólares",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "US\$"),
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Euros",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "€\$"),
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(requestURL);
  return json.decode(response.body)['results']['currencies'];
}
