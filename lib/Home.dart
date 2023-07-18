import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerAlcohol = TextEditingController();
  TextEditingController _controllerGasoline = TextEditingController();
  String _textResult = "";

  void _calculate() {
    double ?alcoholPrice = double.tryParse(_controllerAlcohol.text);
    double ?gasolinePrice = double.tryParse(_controllerGasoline.text);

    if(alcoholPrice == null || alcoholPrice <= 0 || gasolinePrice == null || gasolinePrice <= 0) {
      setState(() {
        _textResult = "Número inválido, digite números maiores que 0 e utilizando (.)";
      });
    } else {
      /*
      * Se o preço do álcool dividido pelo preço da gasolina
      * for >= 0.7, é melhor abastecer com gasolina
      * se não, é melhor utilizar álcool
      */

      if((alcoholPrice / gasolinePrice) >= 0.7) {
        setState(() {
          _textResult = "Melhor abastecer com gasolina";
        });
      } else {
        setState(() {
          _textResult = "Melhor abastecer com álcool";
        });
      }

      _controllerAlcohol.text = "";
      _controllerGasoline.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false, // para não quebrar o layout com o teclado
      appBar: AppBar(
        title: const Text("Álcool ou Gasolina"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly, - não funciona dentro do scrollView
            children: [
              Image.asset("images/logo.png"),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Saiba qual a melhor opção para abastecer seu carro (baseado no real)",
                  style:
                  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
                child:
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Preço Álcool, ex: 1.59"
                  ),
                  controller: _controllerAlcohol,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child:
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Preço Gasoline, ex: 3.15"
                    ),
                    controller: _controllerGasoline,
                  ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo, // Define a cor de fundo do botão
                        minimumSize: Size.fromHeight(50) // 50 de altura e width infinito
                    ),
                    onPressed: _calculate,
                    child: const Text(
                      "Calcular",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                  _textResult,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  )
              ))
            ],
          ),
        ),
      ),
    );
  }
}
