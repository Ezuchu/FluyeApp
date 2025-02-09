import 'package:flutter/material.dart';
import 'package:fluyeapp/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    // Inicia la animación después de 500ms
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });

    // Después de 3 segundos, navega a la pantalla de bienvenida
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: Duration(seconds: 2), // Duración de la animación
          opacity: opacityLevel,
          child: Image.asset(
            'assets/logoMain.png', // Asegúrate de que este archivo esté en assets
            height: 200, // Ajusta el tamaño según sea necesario
          ),
        ),
      ),
    );
  }
}
