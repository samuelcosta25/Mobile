import 'package:flutter/material.dart';
import 'package:sa03/View/LoginView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SA03 - Somativa",
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}