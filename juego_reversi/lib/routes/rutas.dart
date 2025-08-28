// lib/routes/rutas.dart
// Configuración de navegación con go_router. Incluye transiciones de deslizamiento.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegación

import '../pages/about_page.dart'; // Página "Acerca de"
import '../pages/game_page.dart'; // Página del juego
import '../pages/home_page.dart'; // Página principal
import '../pages/instructions_page.dart'; // Página de instrucciones

// Definimos el enrutador con transiciones personalizadas
final GoRouter router = GoRouter(
  routes: [
    // Ruta para la página principal
    GoRoute(
      path: '/', // URL base
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey, // Clave única para la página
        child: const HomePage(), // Widget de la página principal
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0), // Comienza desde la derecha
              end: Offset.zero, // Termina en la posición original
            ).animate(animation), // Aplica la animación
            child: child,
          );
        },
      ),
    ),
    // Ruta para la página del juego
    GoRoute(
      path: '/game', // URL para el juego
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const GamePage(), // Widget de la página del juego
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0), // Comienza desde la derecha
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    // Ruta para la página de instrucciones
    GoRoute(
      path: '/instructions', // URL para instrucciones
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const InstructionsPage(), // Widget de la página de instrucciones
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0), // Comienza desde la derecha
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    // Ruta para la página "Acerca de"
    GoRoute(
      path: '/about', // URL para "Acerca de"
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AboutPage(), // Widget de la página "Acerca de"
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0), // Comienza desde la derecha
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
  ],
);