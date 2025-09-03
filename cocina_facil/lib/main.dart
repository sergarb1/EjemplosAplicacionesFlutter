// lib/main.dart
import 'package:flutter/material.dart'; // Biblioteca principal de Flutter para widgets y temas de Material Design.
import 'package:provider/provider.dart'; // Paquete para gestión de estado con Provider.
import 'providers/recipe_provider.dart'; // Importa el proveedor de recetas para gestionar datos.
import 'routes/rutas.dart'; // Importa la configuración de rutas definida con GoRouter.

// Punto de entrada de la aplicación "Cocina Fácil".
// Configura el estado global con Provider y ejecuta la aplicación.
void main() {
  // runApp inicia la aplicación Flutter pasando el widget raíz.
  // ChangeNotifierProvider crea una instancia de RecipeProvider y la hace
  // accesible a todos los widgets descendientes para gestionar las recetas.
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecipeProvider(), // Crea una instancia de RecipeProvider.
      child: const MyApp(), // Widget raíz de la aplicación.
    ),
  );
}

// Clase principal de la aplicación, define la estructura y el tema visual.
// Es un StatelessWidget porque no maneja estado interno.
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor con una key opcional.

  @override
  Widget build(BuildContext context) {
    // MaterialApp.router configura la aplicación con soporte para navegación avanzada.
    return MaterialApp.router(
      title: 'Cocina Fácil', // Título de la aplicación, visible en el sistema operativo.
      theme: ThemeData(
        // Define el tema visual de la aplicación para un diseño consistente.
        primarySwatch: Colors.orange, // Usa una paleta de colores naranja para botones y elementos principales.
        scaffoldBackgroundColor: Colors.grey[100], // Fondo suave para las pantallas, mejora la legibilidad.
        visualDensity: VisualDensity.adaptivePlatformDensity, // Ajusta la densidad visual según la plataforma (web, móvil).
        // Configura el estilo de la barra superior (AppBar).
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange[700], // Color de fondo naranja oscuro para la AppBar.
          elevation: 0, // Sin sombra para un diseño limpio.
          iconTheme: const IconThemeData(color: Colors.white), // Iconos blancos en la AppBar.
          titleTextStyle: const TextStyle(
            color: Colors.white, // Texto blanco para el título.
            fontSize: 20, // Tamaño del texto del título.
            fontWeight: FontWeight.bold, // Texto en negrita para destacar.
          ),
        ),
        // Configura el estilo de los botones elevados (como el botón "Agregar Receta").
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[600], // Fondo naranja para botones.
            foregroundColor: Colors.white, // Texto/iconos blancos en botones.
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados.
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Espaciado interno.
          ),
        ),
        // Configura el estilo de los campos de texto (TextFormField).
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Bordes redondeados para campos.
            borderSide: BorderSide(color: Colors.orange[300]!), // Borde naranja claro.
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Bordes redondeados al enfocar.
            borderSide: BorderSide(color: Colors.orange[700]!, width: 2), // Borde más grueso y oscuro al enfocar.
          ),
          filled: true, // Relleno activado para los campos.
          fillColor: Colors.white, // Fondo blanco para los campos.
        ),
        // Configura el estilo de las tarjetas (Card) usadas en las recetas.
        cardTheme: CardThemeData(
          elevation: 4, // Sombra ligera para dar profundidad.
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados.
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Margen externo de las tarjetas.
        ),
        // Configura los estilos de texto para un diseño consistente.
        // Usa la fuente Roboto incluida por defecto en Material Design.
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'Roboto', // Fuente Roboto para títulos grandes.
                fontSize: 20, // Tamaño grande para títulos principales.
                fontWeight: FontWeight.bold, // Negrita para destacar.
                color: Colors.black87, // Color oscuro para buena legibilidad.
              ),
              titleMedium: const TextStyle(
                fontFamily: 'Roboto', // Fuente Roboto para títulos medianos.
                fontSize: 16, // Tamaño mediano para subtítulos.
                fontWeight: FontWeight.w600, // Negrita media.
                color: Colors.black87, // Color oscuro.
              ),
              bodyMedium: const TextStyle(
                fontFamily: 'Roboto', // Fuente Roboto para texto normal.
                fontSize: 14, // Tamaño estándar para texto general.
                color: Colors.black54, // Color más claro para texto secundario.
              ),
            ),
      ),
      routerConfig: router, // Configura GoRouter para manejar la navegación entre pantallas.
      debugShowCheckedModeBanner: false, // Oculta la bandera de "debug" en la app.
    );
  }
}
