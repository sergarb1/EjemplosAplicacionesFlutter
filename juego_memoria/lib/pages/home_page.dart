// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:juego_memoria/providers/game_provider.dart'; // Proveedor del estado del juego
import 'package:juego_memoria/widgets/custom_scaffold.dart'; // Scaffold personalizado

// Clase para la pantalla principal del juego de memoria
class HomePage extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor del juego para acceder al estado
    final gameProvider = context.watch<GameProvider>();
    // Obtenemos el tema de la app para usar estilos
    final theme = Theme.of(context);

    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), // Espacio interno
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
            children: [
              // Título animado con Hero para transiciones
              Hero(
                tag: 'logo', // Identificador para animaciones
                child: Text(
                  '¡Encuentra las Parejas!', // Título de la pantalla
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary, // Color del tema
                    fontWeight: FontWeight.bold, // Negrita
                  ),
                ),
              ),
              const SizedBox(height: 24), // Espacio vertical
              // Muestra la puntuación máxima
              Text(
                'Puntuación Máxima: ${gameProvider.highScore}', // Puntuación máxima
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface, // Color del texto
                ),
              ),
              const SizedBox(height: 32), // Espacio vertical
              // Opción para iniciar un juego fácil (4x4)
              _buildGridOption(
                context,
                title: 'Fácil: 4x4',
                icon: Icons.grid_3x3, // Icono para el nivel fácil
                onTap: () {
                  context.read<GameProvider>().initGame(4, 4); // Inicia juego 4x4
                  context.go('/game/4/4'); // Navega a la pantalla del juego
                },
                theme: theme,
              ),
              const SizedBox(height: 16), // Espacio vertical
              // Opción para iniciar un juego medio (5x4)
              _buildGridOption(
                context,
                title: 'Medio: 5x4',
                icon: Icons.grid_view, // Icono para el nivel medio
                onTap: () {
                  context.read<GameProvider>().initGame(5, 4); // Inicia juego 5x4
                  context.go('/game/5/4'); // Navega a la pantalla del juego
                },
                theme: theme,
              ),
              const SizedBox(height: 16), // Espacio vertical
              // Opción para iniciar un juego difícil (6x4)
              _buildGridOption(
                context,
                title: 'Difícil: 6x4',
                icon: Icons.grid_4x4, // Icono para el nivel difícil
                onTap: () {
                  context.read<GameProvider>().initGame(6, 4); // Inicia juego 6x4
                  context.go('/game/6/4'); // Navega a la pantalla del juego
                },
                theme: theme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir una tarjeta de opción de juego
  Widget _buildGridOption(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap, required ThemeData theme}) {
    return Card(
      elevation: 4, // Sombra de la tarjeta
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
      child: InkWell(
        borderRadius: BorderRadius.circular(12), // Bordes redondeados para el toque
        onTap: onTap, // Acción al tocar la tarjeta
        child: Container(
          padding: const EdgeInsets.all(16), // Espacio interno
          width: MediaQuery.of(context).size.width * 0.8, // Ancho del 80% de la pantalla
          child: Row(
            children: [
              // Icono representativo del nivel
              Icon(icon, size: 32, color: theme.colorScheme.primary),
              const SizedBox(width: 16), // Espacio horizontal
              // Título del nivel
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface, // Color del texto
                    fontWeight: FontWeight.bold, // Negrita
                  ),
                ),
              ),
              // Icono de flecha para indicar acción
              Icon(Icons.arrow_forward, color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}