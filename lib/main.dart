import 'package:flutter/material.dart';
import 'package:fluyeapp/splash_screen.dart';

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
      home: SplashScreen(),
    );
  }
}
