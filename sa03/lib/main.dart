import 'package:flutter/material.dart';
import '/View/ViewLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LoginView(), 
      // Definindo LoginView como a tela inicial
    );
  }
}
