// lib/widgets/logo_widget.dart
// Widget reutilizable para mostrar el logo de la app en PNG.
// Usa Image.asset para renderizar el logo con animación suave.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter

// Widget con estado para el logo
class LogoWidget extends StatefulWidget {
  // Constructor constante, no requiere parámetros
  const LogoWidget({super.key});

  @override
  LogoWidgetState createState() => LogoWidgetState();
}

// Estado del widget LogoWidget
class LogoWidgetState extends State<LogoWidget> {
  double _scale = 0.8; // Escala inicial para la animación

  @override
  void initState() {
    super.initState();
    // Animación de entrada: escala desde 0.8 a 1.0 después de 100ms
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0; // Aumenta la escala a su tamaño normal
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ancho de la pantalla para diseño responsivo
    final screenWidth = MediaQuery.of(context).size.width;
    // Tamaño del logo: 150px para pantallas grandes, 100px para móviles
    final logoSize = screenWidth > 600 ? 150.0 : 100.0;

    // Widget con animación de escala
    return AnimatedScale(
      scale: _scale, // Escala actual para la animación
      duration: const Duration(milliseconds: 300), // Duración de la animación
      child: Image.asset(
        'assets/images/logo.png', // Ruta del logo en PNG
        width: logoSize, // Ancho responsivo
        height: logoSize, // Altura responsiva
        semanticLabel: 'Logo de Dados Cuentacuentos', // Etiqueta para accesibilidad
      ),
    );
  }
}