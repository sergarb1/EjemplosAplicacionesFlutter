// Importamos el paquete necesario para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter

// Clase para mostrar el logo de la aplicación
class Logo extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    // Muestra una imagen desde los assets
    return Image.asset(
      'assets/images/logo.png', // Ruta del archivo del logo
      height: 150, // Altura fija de la imagen
      width: 150, // Ancho fijo de la imagen
      fit: BoxFit.contain, // Ajusta la imagen manteniendo proporciones
    );
  }
}