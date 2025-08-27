// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:juego_memoria/widgets/logo.dart'; // Widget para mostrar el logo

// Clase para un scaffold personalizado
class CustomScaffold extends StatelessWidget {
  // Propiedades del scaffold
  final List<Widget>? actions; // Lista opcional de widgets para la barra superior
  final Widget body; // Contenido principal de la pantalla
  final Widget? floatingActionButton; // Botón flotante opcional
  final Widget? leading; // Widget opcional para el lado izquierdo de la barra

  // Constructor: requiere el body, otras propiedades son opcionales
  const CustomScaffold({
    super.key,
    this.actions,
    required this.body,
    this.floatingActionButton,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tema de la app para usar estilos
    final theme = Theme.of(context);

    // Construimos un Scaffold estándar de Flutter
    return Scaffold(
      appBar: AppBar(
        title: const Logo(), // Logo centrado en la barra superior
        centerTitle: true, // Centra el título
        backgroundColor: theme.colorScheme.primary, // Color de fondo de la barra
        elevation: 0, // Sin sombra en la barra
        actions: actions, // Widgets de acción en la barra superior
        leading: leading, // Widget para el lado izquierdo (ej. botón de retroceso)
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary), // Color de los íconos
      ),
      body: body, // Contenido principal de la pantalla
      floatingActionButton: floatingActionButton, // Botón flotante opcional
      // Barra inferior con texto de copyright
      bottomNavigationBar: Container(
        height: 50, // Altura fija
        color: theme.colorScheme.primary.withValues(alpha:0.1), // Fondo con opacidad
        child: Center(
          child: Text(
            'Copyright 2025 - Juego de Memoria', // Texto de copyright
            style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha:0.7), // Color del texto
              fontSize: 12, // Tamaño de fuente
            ),
          ),
        ),
      ),
    );
  }
}