// lib/routes/rutas.dart
// Configuración de rutas de la app usando go_router.
// Separado de main.dart para modularidad y escalabilidad.

import 'package:go_router/go_router.dart'; // Navegación.
import '../pages/home_page.dart'; // Página principal.

// Definimos el router como una variable exportada.
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/', // Ruta principal.
      builder: (context, state) => const HomePage(), // Página de inicio.
    ),
  ],
);