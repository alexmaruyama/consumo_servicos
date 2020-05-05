import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _cep = TextEditingController();
  String _textoRetorno = '';

  _onProcurar() async {
    String url = "https://viacep.com.br/ws/${_cep.text}/json/";
    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> vetor = json.decode(response.body);
    var logradouro = vetor['logradouro'];
    var complemento = vetor['complemento'];
    var bairro = vetor['bairro'];
    var uf = vetor['uf'];

    var texto =
        'Logradouro: $logradouro\nComplemento:$complemento\nBairro:$bairro\nUF:$uf\n';

    setState(() {
      _textoRetorno = texto;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumo serviços'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _cep,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'CEP Exempo: 12430203',
            ),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            child: RaisedButton(
              color: Colors.yellow,
              onPressed: _onProcurar,
              child: Text(
                'Procurar',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Text(_textoRetorno),
        ],
      ),
    );
  }
}
