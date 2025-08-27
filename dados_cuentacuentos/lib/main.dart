// lib/main.dart
// Punto de entrada de la aplicación.
// Configura el tema y los providers, e importa las rutas desde routes/rutas.dart.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:google_fonts/google_fonts.dart'; // Para fuentes modernas
import 'package:provider/provider.dart'; // Para gestión de estado
import 'package:shared_preferences/shared_preferences.dart'; // Para persistencia local

import 'providers/dados_provider.dart'; // Proveedor para manejar el estado de los dados
import 'routes/rutas.dart'; // Configuración de rutas

// Función principal que inicia la aplicación
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que Flutter esté inicializado
  final prefs = await SharedPreferences.getInstance(); // Instancia de SharedPreferences

  // Inicia la app con los proveedores
  runApp(
    MultiProvider(
      providers: [
        // Provee la instancia de DadosProvider con SharedPreferences
        ChangeNotifierProvider(create: (_) => DadosProvider(prefs)),
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
      title: 'Dados Cuentacuentos', // Título de la app
      // Tema claro de la app
      theme: ThemeData(
        useMaterial3: true, // Usa Material Design 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade300, // Color base para el tema
          secondary: Colors.green.shade300, // Color secundario
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.black87, // Color del texto principal
                displayColor: Colors.black87, // Color del texto de títulos
              ),
        ),
        brightness: Brightness.light, // Tema claro
        cardTheme: CardThemeData(
          elevation: 2, // Sombra de las tarjetas
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
        ),
      ),
      // Tema oscuro de la app
      darkTheme: ThemeData(
        useMaterial3: true, // Usa Material Design 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade700, // Color base para el tema oscuro
          secondary: Colors.green.shade700, // Color secundario oscuro
          brightness: Brightness.dark, // Tema oscuro
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white70, // Color del texto principal
                displayColor: Colors.white70, // Color del texto de títulos
              ),
        ),
        brightness: Brightness.dark, // Tema oscuro
      ),
      themeMode: ThemeMode.system, // Usa el tema del sistema (claro u oscuro)
      routerConfig: router, // Configuración de rutas importada desde rutas.dart
    );
  }
}