// lib/widgets/board_widget.dart
// Widget reutilizable para el tablero de Reversi.
// Usa GridView para un diseño responsivo de 8x8 casillas.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import '../widgets/cell_widget.dart'; // Widget para cada casilla
import '../models/game_model.dart'; // Modelo con constantes del juego

// Clase para el widget del tablero
class BoardWidget extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Construimos un GridView para mostrar el tablero 8x8
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: GameModel.boardSize, // 8 columnas (tamaño del tablero)
        mainAxisSpacing: 2.0, // Espacio vertical entre casillas
        crossAxisSpacing: 2.0, // Espacio horizontal entre casillas
        childAspectRatio: 1.0, // Relación de aspecto 1:1 para casillas cuadradas
      ),
      itemCount: GameModel.boardSize * GameModel.boardSize, // 64 casillas en total
      itemBuilder: (context, index) {
        // Calcula la fila y columna a partir del índice
        final row = index ~/ GameModel.boardSize; // División entera para la fila
        final col = index % GameModel.boardSize; // Módulo para la columna
        // Devuelve un widget de casilla para la posición (row, col)
        return CellWidget(row: row, col: col); // Casilla reutilizable
      },
    );
  }
}