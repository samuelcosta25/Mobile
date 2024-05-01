import 'package:flutter/material.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loja de Carros!"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/listar'),
                  child: Text("Listar Carros")),
              SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/cadastrar'),
                  child: Text("Cadastrar Carros")),
            ],
          ),
        ),
      ),
    );
  }
}
