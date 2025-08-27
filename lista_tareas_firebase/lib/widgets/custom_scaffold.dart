import 'package:flutter/material.dart';
import 'package:lista_tareas_firebase/widgets/logo.dart';

// Este widget personalizado extiende de StatelessWidget y actúa como un contenedor
// para construir una estructura básica de una aplicación con AppBar, body, y otros elementos.
class CustomScaffold extends StatelessWidget {
  // Propiedades opcionales para acciones en el AppBar y un botón flotante.
  final List<Widget>? actions;
  final Widget body; // El contenido principal de la pantalla.
  final Widget? floatingActionButton; // Botón flotante opcional.

  // Constructor de la clase, donde 'body' es obligatorio.
  const CustomScaffold({
    super.key,
    this.actions,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tema actual de la aplicación para usar colores y estilos.
    final theme = Theme.of(context);

    return Scaffold(
      // AppBar: Barra superior de la aplicación.
      appBar: AppBar(
        title: const Logo(), // Logo personalizado como título.
        centerTitle: true, // Centra el título en la barra.
        backgroundColor: theme.colorScheme.primary, // Color de fondo del AppBar.
        elevation: 0, // Sin sombra debajo del AppBar.
        actions: actions, // Acciones opcionales en el AppBar (íconos, botones, etc.).
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary), // Color de los íconos.
      ),
      body: body, // Contenido principal de la pantalla.
      floatingActionButton: floatingActionButton, // Botón flotante opcional.

      // Barra de navegación inferior personalizada.
      bottomNavigationBar: Container(
        height: 50, // Altura de la barra inferior.
        color: theme.colorScheme.primary.withValues(alpha:0.1), // Color con opacidad.
        child: Center(
          child: Text(
            'Copyright 2025 - Lista de tareas con filtros y Firebase', // Texto en la barra inferior.
            style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha:0.7), // Color del texto con opacidad.
              fontSize: 12, // Tamaño de la fuente.
            ),
          ),
        ),
      ),
    );
  }
}
