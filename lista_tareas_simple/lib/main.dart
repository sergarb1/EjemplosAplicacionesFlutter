import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_tareas_simple/routes/rutas.dart';

// Punto de entrada de la aplicación
void main() {
  // Inicia la aplicación Flutter
  runApp(const AplicacionTareas());
}

// Clase principal de la aplicación
class AplicacionTareas extends StatelessWidget {
  const AplicacionTareas({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp configura la estructura general de la app
    return MaterialApp(
      title: 'Lista de Tareas Simple', // Título de la app
      theme: ThemeData(
        // Paleta de colores clara basada en un diseño moderno
        primaryColor: const Color(0xFF4A90E2), // Azul suave profesional
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Fondo gris claro
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4A90E2), // Color principal
          secondary: Color(0xFFF5A623), // Amarillo ámbar para acentos
          surface: Color(0xFFFFFFFF), // Fondo blanco para tarjetas
          onPrimary: Color(0xFF2D3748), // Texto sobre color principal
          onSecondary: Color(0xFFF5F7FA), // Texto sobre color secundario
          onSurface: Color(0xFF2D3748), // Texto sobre fondo
        ),
        // Fuente moderna: Inter
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.light().textTheme.copyWith(
                bodyMedium: const TextStyle(color: Color(0xFF2D3748)),
                bodyLarge: const TextStyle(color: Color(0xFF2D3748)),
              ),
        ),
        // Estilo para botones elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A90E2), // Color principal para botones
            foregroundColor: const Color(0xFF2D3748), // Texto/iconos de botones
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bordes redondeados
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        // Estilo para tarjetas
        cardTheme: CardThemeData(
          color: const Color(0xFFFFFFFF), // Fondo blanco para tarjetas
          elevation: 4, // Sombra sutil
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bordes redondeados
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define la ruta inicial
      initialRoute: Rutas.paginaPrincipal,
      // Usa el generador de rutas definido en rutas.dart
      onGenerateRoute: Rutas.generarRuta,
    );
  }
}