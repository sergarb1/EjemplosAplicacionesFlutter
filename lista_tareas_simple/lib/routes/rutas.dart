import 'package:flutter/material.dart';
import 'package:lista_tareas_simple/pages/pagina_principal.dart';
import 'package:lista_tareas_simple/pages/pagina_agregar_tarea.dart';

// Clase que gestiona las rutas de la aplicación
class Rutas {
  // Nombres de las rutas, usados como identificadores
  static const String paginaPrincipal = '/';
  static const String paginaAgregarTareas = '/agregar-tareas';

  // Método que genera las rutas según el nombre
  static Route<dynamic> generarRuta(RouteSettings settings) {
    switch (settings.name) {
      case paginaPrincipal:
        // Ruta para la página principal
        return MaterialPageRoute(
          builder: (_) => const PaginaPrincipal(),
        );
      case paginaAgregarTareas:
        // Ruta para la página de agregar tareas
        return MaterialPageRoute(
          builder: (_) => PaginaAgregarTarea(),
        );
      default:
        // Ruta por defecto en caso de error
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Error: Ruta no encontrada'),
            ),
          ),
        );
    }
  }
}