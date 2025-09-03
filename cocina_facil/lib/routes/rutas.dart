// lib/routes/rutas.dart
import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';
import '../pages/add_edit_recipe_page.dart';

// Configuración del enrutador GoRouter para la navegación de la aplicación.
final GoRouter router = GoRouter(
  initialLocation: '/', // Ruta inicial: página principal.
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/add-recipe',
      builder: (context, state) => const AddEditRecipePage(),
    ),
    GoRoute(
      path: '/edit-recipe/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AddEditRecipePage(recipeId: id);
      },
    ),
  ],
);