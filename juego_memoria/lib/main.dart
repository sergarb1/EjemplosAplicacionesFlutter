// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:juego_memoria/providers/game_provider.dart'; // Proveedor del estado del juego
import 'package:juego_memoria/routes/rutas.dart'; // Configuración de rutas

// Punto de entrada de la aplicación
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que Flutter esté inicializado
  runApp(
    // Configura múltiples proveedores para la gestión del estado
    MultiProvider(
      providers: [
        // Provee la instancia de GameProvider a toda la app
        ChangeNotifierProvider(create: (_) => GameProvider()),
      ],
      child: const MyApp(), // Widget principal de la app
    ),
  );
}

// Clase principal de la aplicación
class MyApp extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configura la app con enrutamiento
    return MaterialApp.router(
      title: 'Juego de Memoria', // Título de la app
      // Tema claro de la app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey, brightness: Brightness.light), // Esquema de color claro
        useMaterial3: true, // Usa Material Design 3
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme), // Aplica fuente Poppins
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados para tarjetas
          elevation: 2, // Sombra para tarjetas
        ),
      ),
      // Tema oscuro de la app
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey, brightness: Brightness.dark), // Esquema de color oscuro
        useMaterial3: true, // Usa Material Design 3
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.apply(bodyColor: Colors.white)), // Fuente Poppins para tema oscuro
      ),
      themeMode: ThemeMode.system, // Usa el tema del sistema (claro u oscuro)
      routerConfig: router, // Configuración de rutas de la app
    );
  }
}