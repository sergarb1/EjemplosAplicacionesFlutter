// lib/providers/game_provider.dart
// Provider para gestionar el estado del juego Reversi.
// Usa ChangeNotifier para notificar cambios a la UI.
// Guarda el estado tras cada movimiento y cambio de turno.

import 'dart:convert'; // Para codificación y decodificación JSON
import 'package:flutter/material.dart'; // Para ChangeNotifier
import 'package:shared_preferences/shared_preferences.dart'; // Para persistencia local
import 'package:vibration/vibration.dart'; // Para vibración en dispositivos móviles

import '../models/game_model.dart'; // Modelo del juego Reversi

// Clase para manejar el estado del juego
class GameProvider extends ChangeNotifier {
  GameModel _gameModel; // Estado actual del juego
  bool _isGameOver = false; // Indica si el juego ha terminado
  final SharedPreferences prefs; // Instancia para persistencia

  // Getters para acceder al estado
  GameModel get gameModel => _gameModel;
  bool get isGameOver => _isGameOver;

  // Constructor: inicializa con SharedPreferences y carga partida guardada
  GameProvider(this.prefs) : _gameModel = GameModel() {
    _loadGame(); // Carga el estado guardado al iniciar
  }

  // Coloca una pieza en la posición (row, col)
  void placePiece(int row, int col) {
    if (_isValidMove(row, col)) { // Verifica si el movimiento es válido
      // Activa vibración si el dispositivo lo soporta
      Vibration.hasVibrator().then((hasVibrator) {
        if (hasVibrator) {
          Vibration.vibrate(duration: 100); // Vibración sutil de 100ms
        }
      });

      // Coloca la pieza en el tablero
      _gameModel.board[row][col] = _gameModel.currentTurn;

      // Voltea las piezas capturadas
      _flipPieces(row, col);

      // Actualiza las puntuaciones
      _updateScores();

      // Guarda el estado tras el movimiento
      _saveGame();

      // Cambia el turno al otro jugador
      _gameModel.currentTurn = _gameModel.currentTurn == GameModel.black
          ? GameModel.white
          : GameModel.black;

      // Verifica si hay movimientos válidos; si no, termina el juego
      if (!_hasValidMoves()) {
        _isGameOver = true;
      }

      // Guarda el estado tras cambio de turno o fin del juego
      _saveGame();

      notifyListeners(); // Notifica a la UI de los cambios
    }
  }

  // Verifica si un movimiento en (row, col) es válido
  bool _isValidMove(int row, int col) {
    if (_gameModel.board[row][col] != GameModel.empty) return false; // La casilla debe estar vacía
    final directions = [
      [-1, -1], [-1, 0], [-1, 1], // Diagonal arriba-izq, arriba, arriba-der
      [0, -1],          [0, 1],   // Izquierda, derecha
      [1, -1],  [1, 0],  [1, 1], // Diagonal abajo-izq, abajo, abajo-der
    ];
    for (var dir in directions) {
      int r = row + dir[0];
      int c = col + dir[1];
      bool hasOpponent = false; // Indica si se encontró una pieza del oponente
      // Explora en la dirección mientras esté dentro del tablero
      while (r >= 0 && r < GameModel.boardSize && c >= 0 && c < GameModel.boardSize) {
        if (_gameModel.board[r][c] == _gameModel.currentTurn) {
          if (hasOpponent) return true; // Movimiento válido si hay piezas del oponente entre las propias
          break;
        } else if (_gameModel.board[r][c] == GameModel.empty) {
          break; // Para si encuentra una casilla vacía
        } else {
          hasOpponent = true; // Marca que encontró una pieza del oponente
        }
        r += dir[0];
        c += dir[1];
      }
    }
    return false; // No es un movimiento válido
  }

  // Voltea las piezas capturadas tras un movimiento
  void _flipPieces(int row, int col) {
    final directions = [
      [-1, -1], [-1, 0], [-1, 1], // Diagonal arriba-izq, arriba, arriba-der
      [0, -1],          [0, 1],   // Izquierda, derecha
      [1, -1],  [1, 0],  [1, 1], // Diagonal abajo-izq, abajo, abajo-der
    ];
    for (var dir in directions) {
      List<List<int>> toFlip = []; // Lista de posiciones a voltear
      int r = row + dir[0];
      int c = col + dir[1];
      // Explora en la dirección mientras esté dentro del tablero
      while (r >= 0 && r < GameModel.boardSize && c >= 0 && c < GameModel.boardSize) {
        if (_gameModel.board[r][c] == _gameModel.currentTurn) {
          // Voltea todas las piezas marcadas
          for (var pos in toFlip) {
            _gameModel.board[pos[0]][pos[1]] = _gameModel.currentTurn;
          }
          break;
        } else if (_gameModel.board[r][c] == GameModel.empty) {
          break; // Para si encuentra una casilla vacía
        }
        toFlip.add([r, c]); // Agrega la posición a la lista de piezas a voltear
        r += dir[0];
        c += dir[1];
      }
    }
  }

  // Actualiza las puntuaciones de ambos jugadores
  void _updateScores() {
    _gameModel.blackScore = 0;
    _gameModel.whiteScore = 0;
    // Cuenta las piezas de cada color en el tablero
    for (var row in _gameModel.board) {
      for (var cell in row) {
        if (cell == GameModel.black) _gameModel.blackScore++;
        if (cell == GameModel.white) _gameModel.whiteScore++;
      }
    }
  }

  // Verifica si hay movimientos válidos para el turno actual
  bool _hasValidMoves() {
    for (int r = 0; r < GameModel.boardSize; r++) {
      for (int c = 0; c < GameModel.boardSize; c++) {
        if (_isValidMove(r, c)) return true; // Hay al menos un movimiento válido
      }
    }
    return false; // No hay movimientos válidos
  }

  // Reinicia el juego a su estado inicial
  void resetGame() {
    _gameModel = GameModel(); // Crea un nuevo modelo de juego
    _isGameOver = false; // Resetea el estado de fin de juego
    notifyListeners(); // Notifica a la UI
    _saveGame(); // Guarda el estado inicial
  }

  // Guarda el estado del juego en SharedPreferences
  void _saveGame() {
    prefs.setString('saved_game', jsonEncode(_gameModel.toJson())); // Guarda como JSON
  }

  // Carga el estado del juego desde SharedPreferences
  void _loadGame() {
    final saved = prefs.getString('saved_game'); // Obtiene el estado guardado
    if (saved != null) {
      _gameModel = GameModel.fromJson(jsonDecode(saved)); // Restaura el modelo
      _isGameOver = !_hasValidMoves(); // Verifica si el juego ha terminado
      notifyListeners(); // Notifica a la UI
    }
  }
}