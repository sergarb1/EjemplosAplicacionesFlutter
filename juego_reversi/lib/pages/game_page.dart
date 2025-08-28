// lib/pages/game_page.dart
// Página del juego con tablero prominente, casillas más pequeñas, puntuaciones, indicador de turno y botón de retroceso explícito.
// Logo movido a AppBar en CustomScaffold.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegación
import 'package:provider/provider.dart'; // Para consumir el provider

import '../models/game_model.dart'; // Constantes del modelo del juego
import '../providers/game_provider.dart'; // Proveedor del estado del juego
import '../widgets/board_widget.dart'; // Widget para el tablero
import '../widgets/custom_scaffold.dart'; // Scaffold personalizado
import '../widgets/score_widget.dart'; // Widget para mostrar puntuaciones

// Clase para la pantalla del juego Reversi
class GamePage extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor del estado del juego
    final gameProvider = Provider.of<GameProvider>(context);

    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      // Botón de retroceso explícito
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Icono de flecha atrás
        onPressed: () => context.go('/'), // Navega a la pantalla principal
        tooltip: 'Volver', // Texto de ayuda para accesibilidad
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calcula el tamaño del tablero: 80% del menor entre ancho y alto, limitado entre 200-350px
          final boardSize = constraints.maxWidth < constraints.maxHeight
              ? (constraints.maxWidth * 0.8).clamp(200.0, 350.0)
              : (constraints.maxHeight * 0.8).clamp(200.0, 350.0);
          
          // Contenido centrado en la pantalla
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
              children: [
                // Indicador de turno con ícono y texto
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle, // Icono de círculo
                      color: gameProvider.gameModel.currentTurn == GameModel.black
                          ? Colors.black // Negro si es el turno del jugador negro
                          : Colors.white, // Blanco si es el turno del jugador blanco
                      size: 18, // Tamaño del ícono
                      semanticLabel: gameProvider.gameModel.currentTurn == GameModel.black
                          ? 'Turno de negro'
                          : 'Turno de blanco', // Etiqueta para accesibilidad
                    ),
                    const SizedBox(width: 6), // Espacio horizontal
                    Text(
                      'Turno: ${gameProvider.gameModel.currentTurn == GameModel.black ? 'Negro' : 'Blanco'}', // Texto del turno
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600, // Negrita
                            color: Theme.of(context).colorScheme.primary, // Color del tema
                            fontSize: 14, // Tamaño de fuente
                          ),
                      semanticsLabel: gameProvider.gameModel.currentTurn == GameModel.black
                          ? 'Turno de negro'
                          : 'Turno de blanco', // Etiqueta para accesibilidad
                    ),
                  ],
                ),
                const SizedBox(height: 6), // Espacio vertical
                // Widget para mostrar las puntuaciones
                ScoreWidget(),
                const SizedBox(height: 6), // Espacio vertical
                // Contenedor para el tablero
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface, // Color de fondo del tema
                    borderRadius: BorderRadius.circular(12), // Bordes redondeados
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)), // Sombra
                    ],
                  ),
                  child: SizedBox(
                    width: boardSize, // Ancho del tablero
                    height: boardSize, // Altura del tablero
                    child: BoardWidget(), // Widget del tablero
                  ),
                ),
                // Mensaje de fin de juego si corresponde
                if (gameProvider.isGameOver)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6), // Espacio vertical
                    child: Text(
                      '¡Juego terminado!', // Mensaje de fin
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary, // Color del tema
                            fontWeight: FontWeight.bold, // Negrita
                            fontSize: 16, // Tamaño de fuente
                          ),
                      semanticsLabel: 'Juego terminado', // Etiqueta para accesibilidad
                    ),
                  ),
                const SizedBox(height: 6), // Espacio vertical
                // Botón para iniciar un nuevo juego
                _buildGradientButton(
                  context,
                  text: 'Nuevo Juego',
                  onPressed: gameProvider.resetGame, // Reinicia el juego
                  width: boardSize * 0.6, // Ancho relativo al tablero
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Método para construir un botón con gradiente
  Widget _buildGradientButton(
    BuildContext context, {
    required String text, // Texto del botón
    required VoidCallback onPressed, // Acción al presionar
    required double width, // Ancho del botón
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary], // Gradiente
          begin: Alignment.topLeft, // Inicio del gradiente
          end: Alignment.bottomRight, // Fin del gradiente
        ),
        borderRadius: BorderRadius.circular(12), // Bordes redondeados
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)), // Sombra
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed, // Acción al presionar
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Fondo transparente para mostrar el gradiente
          shadowColor: Colors.transparent, // Sin sombra adicional
          minimumSize: Size(width, 36), // Tamaño mínimo del botón
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), // Estilo del texto
        ),
        child: Text(text), // Texto del botón
      ),
    );
  }
}