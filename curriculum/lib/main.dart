// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:curriculum/providers/cv_provider.dart'; // Proveedor de datos del CV
import 'package:curriculum/routes/rutas.dart'; // Configuración de rutas

// Punto de entrada de la aplicación
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que Flutter esté inicializado
  final cvProvider = CvProvider(); // Crea una instancia del proveedor de CV
  await cvProvider.loadCvData(); // Carga los datos del CV
  runApp(
    // Provee la instancia de CvProvider a toda la app
    ChangeNotifierProvider(
      create: (_) => cvProvider,
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
      title: 'Curriculum Vitae', // Título de la app
      // Tema claro de la app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Esquema de color basado en azul
        useMaterial3: true, // Usa Material Design 3
        fontFamily: 'Poppins', // Fuente Poppins para todo el texto
      ),
      // Tema oscuro de la app
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark), // Esquema de color oscuro
        useMaterial3: true, // Usa Material Design 3
        fontFamily: 'Poppins', // Fuente Poppins para todo el texto
      ),
      routerConfig: router, // Configuración de rutas de la app
      debugShowCheckedModeBanner: false, // Oculta la bandera de modo debug
    );
  }
}