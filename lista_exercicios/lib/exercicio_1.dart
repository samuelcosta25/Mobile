//Layout Básico com Container:
//Crie um aplicativo Flutter que utilize o widget Container para criar um layout básico.
//Adicione pelo menos três widgets filhos dentro do Container com diferentes estilos e
//cores.

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// Obtém informações sobre o ambiente de exibição
    MediaQueryData mediaQueryData = MediaQuery.of(context);

// Determina a largura da tela
    double screenWidth = mediaQueryData.size.width;

// Calcula o tamanho do texto com base na largura da tela
    double textSize = screenWidth * 0.05;

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Exercicio 1'),
            ),
            body: Column(children: [
              Container(
                  color: Color.fromARGB(255, 0, 55, 122),
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Text(
                      'Container 02',
                      style: TextStyle(color: Colors.white), // Cor do texto
                    ),
                  )),
              Container(
                  color: Color.fromARGB(255, 0, 145, 131),
                  width: 130,
                  height: 130,
                  child: Center(
                    child: Text(
                      'Container 02',
                      style: TextStyle(color: Colors.white), // Cor do texto
                    ),
                  )),
              Container(
                  color: Color.fromARGB(255, 97, 0, 0),
                  width: 160,
                  height: 160,
                  child: Center(
                    child: Text(
                      'Container 03',
                      style: TextStyle(color: Colors.white), // Cor do texto
                    ),
                  ))
            ])));
  }
}
