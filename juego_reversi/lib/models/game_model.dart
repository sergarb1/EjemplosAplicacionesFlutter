// lib/models/game_model.dart
// Modelo de datos para el juego Reversi. Representa el estado del tablero y jugadores.

class GameModel {
  // Constantes del juego
  static const int boardSize = 8; // Tablero 8x8
  static const int empty = 0; // Casilla vacía
  static const int black = 1; // Jugador negro
  static const int white = 2; // Jugador blanco

  // Tablero como matriz 2D
  List<List<int>> board;

  // Turno actual (inicia el jugador negro)
  int currentTurn;

  // Puntuaciones de los jugadores
  int blackScore;
  int whiteScore;

  // Constructor: Inicializa el tablero vacío con posiciones iniciales
  GameModel()
      : board = List.generate(boardSize, (_) => List.filled(boardSize, empty)), // Crea matriz 8x8 vacía
        currentTurn = black, // Turno inicial para el jugador negro
        blackScore = 2, // Puntuación inicial para negro
        whiteScore = 2 { // Puntuación inicial para blanco
    // Configura las posiciones iniciales del Reversi
    board[3][3] = white; // Ficha blanca en (3,3)
    board[3][4] = black; // Ficha negra en (3,4)
    board[4][3] = black; // Ficha negra en (4,3)
    board[4][4] = white; // Ficha blanca en (4,4)
  }

  // Constructor para copiar un modelo existente (útil para persistencia o reinicios)
  GameModel.copy(GameModel other)
      : board = other.board.map((row) => List<int>.from(row)).toList(), // Copia profunda del tablero
        currentTurn = other.currentTurn, // Copia el turno
        blackScore = other.blackScore, // Copia la puntuación de negro
        whiteScore = other.whiteScore; // Copia la puntuación de blanco

  // Método para convertir el modelo a JSON (persistencia)
  Map<String, dynamic> toJson() {
    return {
      'board': board.map((row) => row.toList()).toList(), // Convierte el tablero a una lista
      'currentTurn': currentTurn, // Turno actual
      'blackScore': blackScore, // Puntuación de negro
      'whiteScore': whiteScore, // Puntuación de blanco
    };
  }

  // Método para crear un modelo desde JSON (cargar desde persistencia)
  factory GameModel.fromJson(Map<String, dynamic> json) {
    final model = GameModel(); // Crea un nuevo modelo
    model.board = (json['board'] as List).map((row) => List<int>.from(row as List)).toList(); // Restaura el tablero
    model.currentTurn = json['currentTurn']; // Restaura el turno
    model.blackScore = json['blackScore']; // Restaura la puntuación de negro
    model.whiteScore = json['whiteScore']; // Restaura la puntuación de blanco
    return model;
  }
}