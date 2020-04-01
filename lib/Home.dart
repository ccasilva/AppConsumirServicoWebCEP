import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCep = TextEditingController();
  String                    _resultado = "Resultado";

  /*Comunicação sincrona e assincrona
    sincrona   - Resposta de forma instantanea. Você solicita e ele responde imediatamente.
    assincrona - Ela precisa de um tempo para processar sua mensagem.
  */
  _recuperarCep() async{

    String cepDigitado = _controllerCep.text;
    String         url = "https://viacep.com.br/ws/${cepDigitado}/json/";
    http.Response  response;

    // await - Aguarda a execução da resposta.
    response = await http.get(url);
    Map<String,dynamic> ObjRetorno = json.decode( response.body );

    String logradouro  = ObjRetorno["logradouro"];
    String complemento = ObjRetorno["complemento"];
    String bairro      = ObjRetorno["bairro"];
    String localidade  = ObjRetorno["localidade"];

    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro}, ${localidade}";
    });

    //print("respota: " + response.statusCode.toString() );
    //print("respota: " + response.body );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o cep: ex: 05428200"
              ),
              style: TextStyle(
                fontSize: 20
              ),
              controller: _controllerCep,
            ),
            RaisedButton(
              child: Text("Clique aqui"),
              onPressed: _recuperarCep,
            ),
            Text( _resultado )
          ],
        ),
      ),
    );
  }
}
