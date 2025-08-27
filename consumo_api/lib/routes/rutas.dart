// Importamos el paquete para manejar rutas
import 'package:go_router/go_router.dart'; // Herramienta para navegación
import 'package:consumo_api/pages/characters_page.dart'; // Página de personajes
import 'package:consumo_api/pages/episodes_page.dart'; // Página de episodios
import 'package:consumo_api/pages/home_page.dart'; // Página principal
import 'package:consumo_api/pages/locations_page.dart'; // Página de localizaciones
import 'package:consumo_api/pages/character_detail_page.dart'; // Página de detalles de personaje

// Definimos el enrutador de la app
final GoRouter router = GoRouter(
  routes: [
    // Ruta principal: muestra la página de inicio
    GoRoute(
      path: '/', // URL base
      builder: (context, state) => const HomePage(), // Carga HomePage
    ),
    // Ruta para la lista de personajes
    GoRoute(
      path: '/characters', // URL para personajes
      builder: (context, state) => const CharactersPage(), // Carga CharactersPage
    ),
    // Ruta para la lista de localizaciones
    GoRoute(
      path: '/locations', // URL para localizaciones
      builder: (context, state) => const LocationsPage(), // Carga LocationsPage
    ),
    // Ruta para la lista de episodios
    GoRoute(
      path: '/episodes', // URL para episodios
      builder: (context, state) => const EpisodesPage(), // Carga EpisodesPage
    ),
    // Ruta para los detalles de un personaje, usa un parámetro dinámico
    GoRoute(
      path: '/character/:id', // URL con ID del personaje (ej. /character/1)
      builder: (context, state) => CharacterDetailPage(
        id: int.parse(state.pathParameters['id']!), // Convierte el ID a entero
      ),
    ),
  ],
);