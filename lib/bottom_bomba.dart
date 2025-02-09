import 'package:flutter/material.dart';

class BottomBomba extends StatefulWidget {
  const BottomBomba({super.key});

  @override
  _BottomBombaState createState() => _BottomBombaState();
}

class _BottomBombaState extends State<BottomBomba> {
  bool isOn = false; // Estado de la bomba (encendido o apagado)

  @override
  Widget build(BuildContext context) {
    // Ejemplo de valores que puedes usar (asegúrate de tener estos valores disponibles o pásalos como parámetros)
    double porcentaje = 75.0; // Porcentaje de llenado
    double cantidadMl = 1500.0; // Cantidad de mililitros
    double limiteTanque = 2000.0; // Límite de capacidad del tanque

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bomba del Tanque'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .start, // Alinea el contenido en la parte superior
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centrado horizontalmente
          children: [
            // Mostrar porcentaje en negrita junto con cantidad de mililitros
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centrado de los elementos dentro de Row
              children: [
                Text(
                  '${porcentaje.toStringAsFixed(0)}%',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
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
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centrado de los elementos dentro de Row
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
            const SizedBox(
                height: 32), // Espacio adicional entre el contenido y el botón
            // Espaciador para empujar el botón hacia abajo
            const Spacer(),
            // Botón de encendido y apagado en la parte inferior con ícono
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Alternar el estado de la bomba
                  isOn = !isOn;
                });
                // Aquí puedes agregar la lógica para encender o apagar la bomba
                print(isOn ? "Bomba encendida" : "Bomba apagada");
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20), // Ajusta el tamaño del botón
                shape: const CircleBorder(), // Forma circular
                backgroundColor: isOn
                    ? Colors.green
                    : Colors.red, // Color de fondo basado en el estado
              ),
              child: Icon(
                Icons
                    .power_settings_new, // Mantenemos el ícono de encendido/apagado
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
