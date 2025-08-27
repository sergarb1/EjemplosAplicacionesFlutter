import 'package:flutter/material.dart'; // Paquete principal de Flutter para widgets y herramientas de UI
import 'package:provider/provider.dart'; // Para manejo de estado (gestión de datos compartidos)
import 'package:consumo_api/providers/api_provider.dart'; // Nuestro proveedor personalizado para manejar la API
import 'package:consumo_api/routes/rutas.dart'; // Nuestro archivo de configuración de rutas

// Función principal que inicia la aplicación
void main() async {
  // 'async' porque vamos a realizar operaciones asíncronas al inicio
// Aseguramos que Flutter esté inicializado antes de hacer cualquier cosa
  WidgetsFlutterBinding.ensureInitialized();

// Creamos una instancia de nuestro proveedor de API
  final apiProvider = ApiProvider();

// Cargamos datos iniciales antes de iniciar la app (personajes, episodios, etc.)
  await apiProvider
      .loadInitialData(); // 'await' espera a que se complete esta operación

// Ejecutamos la aplicación
  runApp(
// Provider nos permite compartir datos a través del árbol de widgets
    ChangeNotifierProvider(
// Creamos el proveedor que estará disponible en toda la app
      create: (_) => apiProvider,
// Nuestra aplicación principal
      child: const MyApp(),
    ),
  );
}

// Widget principal de nuestra aplicación (Stateless porque no cambia su estado interno)
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor con key opcional

  @override
  Widget build(BuildContext context) {
// MaterialApp.router es para apps que usan enrutamiento con go_router
    return MaterialApp.router(
      title: 'Rick and Morty API', // Título de la app

      // Tema claro de la aplicación
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green), // Esquema de colores basado en verde
        useMaterial3: true, // Usa Material Design 3
        fontFamily: 'Poppins', // Fuente personalizada para toda la app
      ),

      // Tema oscuro (se activa automáticamente según la configuración del dispositivo)
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.dark // Versión oscura del esquema de colores
            ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),

      routerConfig: router, // Configuración de rutas definida en rutas.dart
      debugShowCheckedModeBanner:
          false, // Oculta la cinta de debug en esquina superior derecha
    );
  }
}
