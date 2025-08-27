import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_tareas_firebase/providers/tarea_provider.dart';
import 'package:lista_tareas_firebase/routes/rutas.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Función principal de la aplicación
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que los widgets estén inicializados antes de ejecutar el código
  await dotenv.load(fileName: ".env"); // Cargar variables de entorno desde el archivo .env
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY']!, // Clave de la API de Firebase
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!, // Dominio de autenticación de Firebase
      projectId: dotenv.env['FIREBASE_PROJECT_ID']!, // ID del proyecto de Firebase
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!, // Bucket de almacenamiento de Firebase
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!, // ID del remitente de mensajes de Firebase
      appId: dotenv.env['FIREBASE_APP_ID']!, // ID de la aplicación de Firebase
      measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID'], // ID de medición de Firebase (opcional)
    ),
  );
  final tareaProvider = TareaProvider(); // Inicializa el proveedor de tareas
  await tareaProvider.cargarDatos(); // Carga los datos iniciales de las tareas
  runApp(
    ChangeNotifierProvider.value(
      value: tareaProvider, // Proveedor de estado para la aplicación
      child: const AplicacionTareas(), // Widget principal de la aplicación
    ),
  );
}

// Clase principal de la aplicación
class AplicacionTareas extends StatelessWidget {
  const AplicacionTareas({super.key});

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<TareaProvider>(context); // Obtiene el proveedor de tareas para gestionar el tema
    return MaterialApp.router(
      title: 'Lista de Tareas con Filtros y usando Firebase', // Título de la aplicación
      theme: ThemeData(
        primaryColor: const Color(0xFF4A90E2), // Color primario del tema claro
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Color de fondo del scaffold
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
                bodyMedium: const TextStyle(color: Color(0xFF2D3748)), // Estilo de texto para cuerpo medio
                bodyLarge: const TextStyle(color: Color(0xFF2D3748)), // Estilo de texto para cuerpo grande
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A90E2), // Color de fondo de los botones elevados
            foregroundColor: const Color(0xFF2D3748), // Color del texto de los botones elevados
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bordes redondeados
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Padding de los botones
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFFFFFFFF), // Color de fondo de las tarjetas
          elevation: 4, // Elevación de las tarjetas
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bordes redondeados de las tarjetas
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity, // Densidad visual adaptativa
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFF4A90E2), // Color primario del tema oscuro
        scaffoldBackgroundColor: const Color(0xFF1A202C), // Color de fondo del scaffold en tema oscuro
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
                bodyMedium: const TextStyle(color: Color(0xFFF5F7FA)), // Estilo de texto para cuerpo medio
                bodyLarge: const TextStyle(color: Color(0xFFF5F7FA)), // Estilo de texto para cuerpo grande
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A90E2), // Color de fondo de los botones elevados
            foregroundColor: const Color(0xFFF5F7FA), // Color del texto de los botones elevados
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bordes redondeados
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Padding de los botones
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF2D3748), // Color de fondo de las tarjetas en tema oscuro
          elevation: 4, // Elevación de las tarjetas
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bordes redondeados de las tarjetas
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity, // Densidad visual adaptativa
      ),
      themeMode: temaProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light, // Selección del tema según el estado
      routerConfig: router, // Configuración de rutas de la aplicación
    );
  }
}