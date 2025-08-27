// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para manejar la navegación
import 'package:juego_memoria/pages/home_page.dart'; // Página principal
import 'package:juego_memoria/pages/game_page.dart'; // Página del juego

// Definimos el enrutador de la app
final GoRouter router = GoRouter(
  routes: [
    // Ruta principal: muestra la página de inicio
    GoRoute(
      path: '/', // URL base
      builder: (context, state) => const HomePage(), // Carga HomePage
    ),
    // Ruta para el juego, con parámetros dinámicos para filas y columnas
    GoRoute(
      path: '/game/:rows/:cols', // URL con parámetros (ej. /game/4/4)
      builder: (context, state) {
        try {
          // Convierte los parámetros de filas y columnas a enteros
          final rows = int.parse(state.pathParameters['rows']!);
          final cols = int.parse(state.pathParameters['cols']!);
          // Verifica que las filas sean 4, 5 o 6 y que las columnas sean 4
          if (![4, 5, 6].contains(rows) || cols != 4) {
            // Muestra un mensaje si la cuadrícula no es válida
            return const Scaffold(body: Center(child: Text('Grid no válido')));
          }
          // Carga la página del juego con las filas y columnas válidas
          return GamePage(rows: rows, cols: cols);
        } catch (e) {
          // Muestra un mensaje de error si falla la conversión de parámetros
          return Scaffold(body: Center(child: Text('Error: $e')));
        }
      },
    ),
  ],
);