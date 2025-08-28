// lib/widgets/score_widget.dart
// Widget reutilizable para mostrar las puntuaciones del juego Reversi.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:provider/provider.dart'; // Para consumir el provider

import '../providers/game_provider.dart'; // Proveedor del estado del juego

// Clase para el widget de puntuaciones
class ScoreWidget extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor del estado del juego
    final gameProvider = Provider.of<GameProvider>(context);

    // Construimos una fila para mostrar las puntuaciones
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espacia los elementos uniformemente
      children: [
        // Puntuación del jugador negro
        Text(
          'Negro: ${gameProvider.gameModel.blackScore}', // Muestra la puntuación de negro
          style: Theme.of(context).textTheme.bodyMedium, // Estilo del texto
        ),
        // Puntuación del jugador blanco
        Text(
          'Blanco: ${gameProvider.gameModel.whiteScore}', // Muestra la puntuación de blanco
          style: Theme.of(context).textTheme.bodyMedium, // Estilo del texto
        ),
      ],
    );
  }
}