import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_tareas_filtros/providers/tarea_provider.dart';
import 'package:lista_tareas_filtros/routes/rutas.dart';
import 'package:provider/provider.dart';

// Punto de entrada de la aplicación
void main() async {
  // Aseguramos que los widgets de Flutter estén inicializados antes de ejecutar el código
  WidgetsFlutterBinding.ensureInitialized();

  // Creamos una instancia del proveedor de tareas y cargamos los datos iniciales
  final tareaProvider = TareaProvider();
  await tareaProvider.cargarDatos();

  // Iniciamos la aplicación con un ChangeNotifierProvider para manejar el estado global
  runApp(
    ChangeNotifierProvider.value(
      value: tareaProvider, // Proveedor que contiene el estado de las tareas
      child: const AplicacionTareas(), // Widget principal de la aplicación
    ),
  );
}

// Clase principal de la aplicación
class AplicacionTareas extends StatelessWidget {
  const AplicacionTareas({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor de tareas para determinar el tema actual (claro u oscuro)
    final temaProvider = Provider.of<TareaProvider>(context);

    return MaterialApp.router(
      title: 'Lista de Tareas con Filtros', // Título de la aplicación

      // Tema claro de la aplicación
      theme: ThemeData(
        primaryColor: const Color(0xFF4A90E2), // Color principal
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Fondo de la aplicación
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4A90E2), // Color primario
          secondary: Color(0xFFF5A623), // Color secundario
          surface: Color(0xFFFFFFFF), // Color de superficie
          onPrimary: Color(0xFF2D3748), // Color del texto sobre el color primario
          onSecondary: Color(0xFFF5F7FA), // Color del texto sobre el color secundario
          onSurface: Color(0xFF2D3748), // Color del texto sobre la superficie
          error: Color(0xFFE53E3E), // Color para errores
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.light().textTheme.copyWith(
                bodyMedium: const TextStyle(color: Color(0xFF2D3748)), // Texto de tamaño medio
                bodyLarge: const TextStyle(color: Color(0xFF2D3748)), // Texto de tamaño grande
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A90E2), // Fondo del botón elevado
            foregroundColor: const Color(0xFF2D3748), // Color del texto del botón
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bordes redondeados
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Espaciado interno
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFFFFFFFF), // Fondo de las tarjetas
          elevation: 4, // Sombra de las tarjetas
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bordes redondeados de las tarjetas
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity, // Densidad visual adaptativa
      ),

      // Tema oscuro de la aplicación
      darkTheme: ThemeData(
        primaryColor: const Color(0xFF4A90E2), // Color principal
        scaffoldBackgroundColor: const Color(0xFF1A202C), // Fondo oscuro
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4A90E2), // Color primario
          secondary: Color(0xFFF5A623), // Color secundario
          surface: Color(0xFF2D3748), // Color de superficie
          onPrimary: Color(0xFFF5F7FA), // Color del texto sobre el color primario
          onSecondary: Color(0xFF1A202C), // Color del texto sobre el color secundario
          onSurface: Color(0xFFF5F7FA), // Color del texto sobre la superficie
          error: Color(0xFFE53E3E), // Color para errores
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme.copyWith(
                bodyMedium: const TextStyle(color: Color(0xFFF5F7FA)), // Texto de tamaño medio
                bodyLarge: const TextStyle(color: Color(0xFFF5F7FA)), // Texto de tamaño grande
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A90E2), // Fondo del botón elevado
            foregroundColor: const Color(0xFFF5F7FA), // Color del texto del botón
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bordes redondeados
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Espaciado interno
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF2D3748), // Fondo de las tarjetas
          elevation: 4, // Sombra de las tarjetas
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bordes redondeados de las tarjetas
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity, // Densidad visual adaptativa
      ),

      // Determinamos el tema actual (claro u oscuro) según el estado del proveedor
      themeMode: temaProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,

      // Configuración del enrutador (GoRouter)
      routerConfig: router,
    );
  }
}