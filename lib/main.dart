import 'package:flutter/material.dart';
import 'package:fluyeapp/welcome_screen.dart'; // Importa la pantalla de bienvenida

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      // Cambia la pantalla inicial a WelcomeScreen
      home: const WelcomeScreen(),
    );
  }
}
