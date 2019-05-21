import 'package:currency_converter/bloc/main.bloc.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainBloc _bloc;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: _bloc.finance,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar dados :(",
                style: TextStyle(color: Colors.amber),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.monetization_on,
                      size: 150.0, color: Colors.amber),
                  _bloc.buildTextField(
                      "Reais", "R\$", _bloc.realController, _bloc.realChanged),
                  Divider(),
                  _bloc.buildTextField(
                      "Dólares", "US\$", _bloc.dolarController, _bloc.dolarChanged),
                  Divider(),
                  _bloc.buildTextField("Euros", "€", _bloc.euroController, _bloc.euroChanged)
                ],
              ),
            );
          }

          return Center(
            child: Text(
              "Carregando dados...",
              style: TextStyle(color: Colors.amber),
              textAlign: TextAlign.center,
            ),
          );
        },
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _bloc = MainBloc()..init();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
