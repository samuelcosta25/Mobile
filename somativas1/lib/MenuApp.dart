import 'package:somativas1/MenuController.dart';
import 'package:somativas1/MenuView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Definindo a tela inicial como a MenuScreen e utilizando o Provider
      home: ChangeNotifierProvider(
        create: (context) => MenusController(),
        child: MenuScreen(),
      ),
    );
  }
}