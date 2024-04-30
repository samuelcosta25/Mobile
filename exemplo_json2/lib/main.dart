import 'package:exemplo_json2/View/livros-view.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Livros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LivrosPage(),
    );
  }
}
