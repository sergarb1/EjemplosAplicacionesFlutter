// lib/main.dart
// Punto de entrada de la app. Inicializa providers, tema moderno y navegación.
// Usa fuente Roboto (integrada) para un diseño profesional.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:provider/provider.dart'; // Para gestión de estado
import 'package:shared_preferences/shared_preferences.dart'; // Para persistencia local

import 'providers/game_provider.dart'; // Proveedor del estado del juego
import 'routes/rutas.dart'; // Configuración de rutas con transiciones

// Función principal que inicia la aplicación
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que Flutter esté inicializado
  final prefs = await SharedPreferences.getInstance(); // Instancia de SharedPreferences

  // Inicia la app con los proveedores
  runApp(
    MultiProvider(
      providers: [
        // Provee la instancia de GameProvider con SharedPreferences
        ChangeNotifierProvider(create: (_) => GameProvider(prefs)),
      ],
      child: const MyApp(), // Widget principal de la app
    ),
  );
}

// Clase principal de la aplicación, sin estado interno
class MyApp extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configura la app con enrutamiento
    return MaterialApp.router(
      title: 'Reversi Game', // Título de la app
      // Tema claro de la app
      theme: ThemeData(
        useMaterial3: true, // Usa Material Design 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal, // Color base teal para el tema
          primary: Colors.teal, // Color principal
          secondary: Colors.amber, // Color secundario para acentos
        ),
        textTheme: ThemeData.light().textTheme.apply(
              fontFamily: 'Roboto', // Fuente Roboto para el texto
              bodyColor: Colors.teal.shade900, // Color del texto principal
              displayColor: Colors.teal.shade900, // Color del texto de títulos
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) => Colors.teal), // Fondo teal
            foregroundColor: WidgetStateProperty.all(Colors.white), // Texto blanco
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
            ),
            elevation: WidgetStateProperty.all(4), // Sombra de los botones
            textStyle: WidgetStateProperty.all(
              const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600), // Estilo del texto
            ),
          ),
        ),
        brightness: Brightness.light, // Tema claro
      ),
      // Tema oscuro de la app
      darkTheme: ThemeData(
        useMaterial3: true, // Usa Material Design 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal, // Color base teal
          brightness: Brightness.dark, // Tema oscuro
          primary: Colors.teal.shade300, // Color principal más claro
          secondary: Colors.amber.shade300, // Color secundario más claro
        ),
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Roboto', // Fuente Roboto para el texto
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) => Colors.teal.shade700), // Fondo teal oscuro
            foregroundColor: WidgetStateProperty.all(Colors.white), // Texto blanco
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
            ),
            textStyle: WidgetStateProperty.all(
              const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600), // Estilo del texto
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.system, // Usa el modo del sistema (claro u oscuro)
      routerConfig: router, // Configuración de rutas con transiciones
    );
  }
}