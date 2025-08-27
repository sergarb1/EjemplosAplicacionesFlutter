// lib/widgets/dado_widget.dart
// Widget reutilizable para mostrar un dado con animación.
// Usa PNG de 50x50 píxeles para un diseño compacto.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter

import '../models/dado.dart'; // Modelo de Dado

// Widget con estado para mostrar un dado con animación
class DadoWidget extends StatefulWidget {
  final Dado dado; // Dado a mostrar

  // Constructor: requiere un objeto Dado
  const DadoWidget({super.key, required this.dado});

  @override
  DadoWidgetState createState() => DadoWidgetState();
}

// Estado del widget DadoWidget
class DadoWidgetState extends State<DadoWidget> {
  double _scale = 1.0; // Escala inicial para la animación

  @override
  void didUpdateWidget(DadoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Detecta si el dado cambió para activar la animación
    if (oldWidget.dado.assetPath != widget.dado.assetPath) {
      setState(() {
        _scale = 1.2; // Aumenta la escala para efecto de animación
      });
      // Vuelve a la escala original después de 200ms
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _scale = 1.0; // Restaura la escala
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget con animación de escala
    return AnimatedScale(
      scale: _scale, // Escala actual para la animación
      duration: const Duration(milliseconds: 200), // Duración de la animación
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, // Color de fondo del tema
          borderRadius: BorderRadius.circular(8), // Bordes redondeados
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 2), // Sombra sutil
          ],
        ),
        child: Center(
          child: Image.asset(
            widget.dado.assetPath, // Ruta de la imagen del dado
            width: 50, // Ancho fijo para PNG 50x50
            height: 50, // Altura fija para PNG 50x50
            semanticLabel: 'Imagen de dado', // Etiqueta para accesibilidad
          ),
        ),
      ),
    );
  }
}