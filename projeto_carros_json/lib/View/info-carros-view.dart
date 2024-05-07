import 'package:flutter/material.dart';
import 'package:projeto_carros_json/Model/carros_model.dart';


class CarrosInfoPage extends StatelessWidget {
  Carros info;
  CarrosInfoPage({required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(info.imagem),
          Text(info.placa),
          Text(info.modelo),
          Text(info.marca),
          Text("${info.ano}"),
          Text(info.cor),
          Text(info.descricao),
          Text("${info.valor}")
        ],
      )),
      ),
    );
  }
}
