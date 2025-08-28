// lib/widgets/logo_widget.dart
// Widget reutilizable para el logo (logo.png) con animación Hero.
// Tamaño más grande para AppBar.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter

// Widget para mostrar el logo de la app
class LogoWidget extends StatelessWidget {
  final bool appBar; // Indica si el logo se usa en la AppBar

  // Constructor: appBar es opcional y por defecto es falso
  const LogoWidget({super.key, this.appBar = false});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ancho de la pantalla para diseño responsivo
    final screenWidth = MediaQuery.of(context).size.width;
    // Define el tamaño del logo: 100px para pantallas grandes, 80px para móviles
    final logoSize = appBar
        ? (screenWidth > 600 ? 100.0 : 80.0) // Tamaño para AppBar
        : (screenWidth > 600 ? 100.0 : 80.0); // Tamaño para el cuerpo (no usado)

    // Usamos Hero para animaciones suaves entre pantallas
    return Hero(
      tag: 'logo', // Identificador para la animación Hero
      child: Image.asset(
        'assets/images/logo.png', // Ruta del logo en PNG
        width: logoSize, // Ancho del logo
        height: logoSize, // Altura del logo
        semanticLabel: 'Logo de Reversi', // Etiqueta para accesibilidad
      ),
    );
  }
}