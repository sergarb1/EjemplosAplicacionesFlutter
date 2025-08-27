import 'package:flutter/material.dart';

// Widget reutilizable para mostrar el logo de la aplicación
class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png', // Ruta de la imagen del logo
      height: 150, // Altura fija para el logo
      width: 150, // Ancho fijo para el logo
      fit: BoxFit.contain, // Ajusta la imagen sin deformarla
    );
  }
}