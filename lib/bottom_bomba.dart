import 'dart:async';
import 'dart:convert';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluyeapp/ip.dart';
import 'package:http/http.dart' as http;

class BottomBomba extends StatefulWidget {
  const BottomBomba({super.key});

  @override
  _BottomBombaState createState() => _BottomBombaState();
}

class _BottomBombaState extends State<BottomBomba> {
  bool isOn = false; // Estado de la bomba (encendido o apagado)
  int porcentaje = 75; // Porcentaje de llenado
  double cantidadMl = 1500; // Cantidad de mililitros
  int limiteTanque = 2000; // Límite de capacidad del tanque
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _getDatosBomba();
    _iniciarTimer();
  }

  _iniciarTimer()
  {
    timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _getDatosBomba();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _getDatosBomba() async {
    var url = Uri.parse("http://$ip/fluye/bomba.php?num=1&proceso=1");
    var response = await http.get(url);
    if(response.statusCode == 200)
    {
      final Map<String,dynamic> resultado =jsonDecode(response.body);
      if(resultado['estado']== 'on')
      {
        setState(() {
          isOn = true;
        });
      }
      else
      {
        setState(() {
          isOn = false;
        });
      }
      setState(() {
        porcentaje = int.parse(resultado['proceso']);
        limiteTanque = int.parse(resultado['capacidad'])*1000;
        cantidadMl = ((porcentaje * limiteTanque) / 100);
      });
    }
  }

  _accionarBomba() async
  {
    String estado = isOn ? "off" : "on";
    print(estado);
    var url = Uri.parse("http://$ip/fluye/PutPump.php");
    final response = await http.put(url, body: jsonEncode(<String,Object>{'cod_proceso': 1, 'num_bomba': 1, 'estado': estado}));
    if(response.statusCode == 200)
    {
      _getDatosBomba();
    }else{
      print('Error al cambiar el estado de la bomba');
    }
  }

 @override
Widget build(BuildContext context) {
  // Ejemplo de valores que puedes usar (asegúrate de tener estos valores disponibles o pásalos como parámetros)
  double alturaTanque = 200.0; // Altura del tanque en píxeles
  double nivelAgua = (cantidadMl / limiteTanque) * alturaTanque; // Nivel de agua en píxeles

  return Scaffold(
    appBar: AppBar(
      title: const Text('Bomba del Tanque'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Alinea el contenido en la parte superior
        crossAxisAlignment: CrossAxisAlignment.center, // Centrado horizontalmente
        children: [
          // Mostrar porcentaje en negrita junto con cantidad de mililitros
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centrado de los elementos dentro de Row
            children: [
              Text(
                '${porcentaje.toStringAsFixed(0)}%',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                '${cantidadMl.toStringAsFixed(0)} ml',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Mostrar límite de tanque centrado
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centrado de los elementos dentro de Row
            children: [
              const Text(
                'Límite de tanque: ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '${limiteTanque.toStringAsFixed(0)} ml',
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Visualización del tanque de agua
          Container(
            height: alturaTanque,
            width: 100, // Ancho del tanque
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRect(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: nivelAgua / alturaTanque,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Espaciador para empujar el botón hacia abajo
          const Spacer(),
          // Botón de encendido y apagado en la parte inferior con ícono
          ElevatedButton(
            onPressed: _accionarBomba,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20), // Ajusta el tamaño del botón
              shape: const CircleBorder(), // Forma circular
              backgroundColor: isOn ? Colors.green : Colors.red, // Color de fondo basado en el estado
            ),
            child: Icon(
              Icons.power_settings_new, // Mantenemos el ícono de encendido/apagado
              size: 50, // Ajusta el tamaño del ícono
              color: Colors.white, // Color del ícono
            ),
          ),
          const SizedBox(height: 32), // Espacio adicional debajo del botón
        ],
      ),
    ),
  );
}
}
