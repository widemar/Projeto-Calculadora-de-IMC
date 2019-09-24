import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoTexto = TextEditingController();
  TextEditingController alturaTexto = TextEditingController();

  String _infoTexto = "Informe seus dados!!!";

  GlobalKey<FormState> chaveFormulario = GlobalKey<FormState>();

  void _resetarCampos() {
    pesoTexto.text = "";
    alturaTexto.text = "";
    setState(() {
      _infoTexto = "Informe seus dados!!!";
    });
  }

  void _calculaIMC() {
    setState(() {
      double peso = double.parse(pesoTexto.text);
      double altura = double.parse(alturaTexto.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.5) {
        _infoTexto = "Magreza (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc <= 24.9) {
        _infoTexto = "Normal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25 && imc <= 29.9) {
        _infoTexto = "Sobrepeso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30 && imc <= 39.9) {
        _infoTexto = "Obesidade (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoTexto = "Obesidade Grave (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ("Calculadora de IMC"),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetarCampos,
          ),
        ],
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Form(
          key: chaveFormulario,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.white,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso KG",
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: "Monospaced"),
                ),
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                  fontFamily: "Monospaced",
                ),
                controller: pesoTexto,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura CM",
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: "Monospaced"),
                ),
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                  fontFamily: "Monospaced",
                ),
                controller: alturaTexto,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (chaveFormulario.currentState.validate()) {
                        _calculaIMC();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                ),
              ),
              Text(
                _infoTexto,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: "Monospaced"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
