// Importamos el paquete necesario para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter

// Clase para un scaffold personalizado
class CustomScaffold extends StatelessWidget {
  // Propiedades del scaffold
  final Widget body; // Contenido principal de la pantalla
  final Widget?
      leading; // Widget opcional para el lado izquierdo de la barra (ej. botón de retroceso)
  final List<Widget>?
      actions; // Lista opcional de widgets para el lado derecho de la barra

  // Constructor: requiere el body, leading y actions son opcionales
  const CustomScaffold({
    super.key,
    required this.body,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    // Construimos un Scaffold estándar de Flutter
    return Scaffold(
      appBar: AppBar(
        title: Text('Curriculum Vitae'),
        centerTitle: true,
        leading:
            leading, // Widget para el lado izquierdo (ej. botón de retroceso)
        actions:
            actions, // Widgets para el lado derecho (ej. botones de acción)
        backgroundColor:
            Theme.of(context).colorScheme.primary, // Color de fondo de la barra
        foregroundColor: Theme.of(context)
            .colorScheme
            .onPrimary, // Color de los elementos (ej. íconos)
        elevation: 0, // Sin sombra en la barra
      ),
      body: SafeArea(
          child:
              body), // Asegura que el contenido no se superponga con áreas del sistema
    );
  }
}
