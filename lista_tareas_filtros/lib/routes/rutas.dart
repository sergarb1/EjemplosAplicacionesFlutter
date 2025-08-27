import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lista_tareas_filtros/pages/pagina_principal.dart';
import 'package:lista_tareas_filtros/pages/pagina_agregar_tarea.dart';

// Configuración de rutas con GoRouter
// GoRouter es una herramienta para manejar la navegación en Flutter de manera declarativa.
final GoRouter router = GoRouter(
  // Define la ubicación inicial al iniciar la aplicación.
  initialLocation: '/principal',
  routes: [
    // Ruta para la página principal.
    GoRoute(
      path: '/principal', // Ruta asociada a esta página.
      builder: (context, state) => const PaginaPrincipal(), // Constructor de la página.
    ),
    // Ruta para la página de agregar tarea.
    GoRoute(
      path: '/agregar', // Ruta asociada a esta página.
      builder: (context, state) => const PaginaAgregarTarea(), // Constructor de la página.
    ),
  ],
  // Configuración para manejar errores de navegación.
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      // Mensaje que se muestra si la ruta no es válida.
      child: Text('Página no encontrada: ${state.error}'),
    ),
  ),
);