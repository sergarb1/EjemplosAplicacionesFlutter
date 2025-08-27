// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:juego_memoria/models/card_model.dart'; // Modelo para las cartas
import 'package:shared_preferences/shared_preferences.dart'; // Para guardar puntuaciones

// Clase para manejar el estado del juego de memoria
class GameProvider extends ChangeNotifier {
  // Lista de cartas del juego
  List<CardModel> cards = [];
  // Puntuación actual y máxima
  int score = 0;
  int highScore = 0;
  // Índices de las cartas seleccionadas
  int? firstIndex;
  int? secondIndex;
  // Indica si se está procesando un movimiento
  bool isProcessing = false;
  // Dimensiones de la cuadrícula
  int rows = 4;
  int cols = 4;
  // Notificador para indicar si el juego se ganó
  final ValueNotifier<bool> gameWon = ValueNotifier<bool>(false);

  // Lista de rutas de imágenes para las cartas
  final List<String> _imageAssets = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
    'assets/images/8.png',
  ];

  // Inicializa el juego con una cuadrícula de filas y columnas
  Future<void> initGame(int rows, int cols) async {
    debugPrint('Initializing game: ${rows}x$cols'); // Log de inicio
    this.rows = rows; // Establece filas
    this.cols = cols; // Establece columnas
    score = 0; // Reinicia puntuación
    firstIndex = null; // Reinicia primera carta
    secondIndex = null; // Reinicia segunda carta
    isProcessing = false; // No hay procesamiento activo
    gameWon.value = false; // Juego no ganado

    // Calcula cuántos pares de cartas se necesitan
    final int pairsNeeded = (rows * cols) ~/ 2;
    debugPrint('Pairs needed: $pairsNeeded, Available images: ${_imageAssets.length}');

    try {
      // Selecciona imágenes para los pares
      List<String> selectedImages = [];
      while (selectedImages.length < pairsNeeded) {
        selectedImages.addAll(_imageAssets); // Añade todas las imágenes disponibles
      }
      // Toma solo las imágenes necesarias y duplica para crear pares
      selectedImages = selectedImages.take(pairsNeeded).toList();
      selectedImages.addAll(List.from(selectedImages));
      selectedImages.shuffle(); // Mezcla las imágenes
      debugPrint('Selected images count: ${selectedImages.length}');

      // Crea la lista de cartas
      cards = selectedImages.map((path) => CardModel(imagePath: path)).toList();
      // Verifica que el número de cartas sea correcto
      if (cards.length != rows * cols) {
        debugPrint('Error: Generated ${cards.length} cards, expected ${rows * cols}');
        cards = []; // Reinicia si hay error
      }
    } catch (e) {
      debugPrint('Error initializing cards: $e'); // Log de error
      cards = []; // Reinicia si hay error
    }
    notifyListeners(); // Notifica cambios

    // Carga la puntuación máxima desde almacenamiento
    try {
      final prefs = await SharedPreferences.getInstance();
      highScore = prefs.getInt('highScore') ?? 0; // Obtiene o usa 0
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading high score: $e'); // Log de error
    }
  }

  // Voltea una carta en el índice dado
  void flipCard(int index) {
    debugPrint('Flipping card at index: $index'); // Log de acción
    // Evita acciones si está procesando, índice inválido o carta ya volteada/emparejada
    if (isProcessing || index >= cards.length || cards[index].isFlipped || cards[index].isMatched) return;

    cards[index].isFlipped = true; // Voltea la carta

    // Asigna el índice a la primera o segunda carta seleccionada
    if (firstIndex == null) {
      firstIndex = index;
    } else if (secondIndex == null && index != firstIndex) {
      secondIndex = index;
      isProcessing = true; // Inicia procesamiento
      _checkMatch(); // Verifica si hay coincidencia
    }
    notifyListeners(); // Notifica cambios
  }

  // Verifica si las cartas seleccionadas coinciden
  void _checkMatch() async {
    // Verifica índices válidos
    if (firstIndex == null || secondIndex == null || firstIndex! >= cards.length || secondIndex! >= cards.length) {
      debugPrint('Invalid indices in _checkMatch: firstIndex=$firstIndex, secondIndex=$secondIndex');
      isProcessing = false;
      notifyListeners();
      return;
    }

    debugPrint('Checking match: card[$firstIndex]=${cards[firstIndex!].imagePath}, card[$secondIndex]=${cards[secondIndex!].imagePath}');

    // Espera un segundo para mostrar las cartas
    await Future.delayed(const Duration(milliseconds: 1000));

    // Compara las imágenes de las cartas
    if (cards[firstIndex!].imagePath == cards[secondIndex!].imagePath) {
      debugPrint('Match found!'); // Log de coincidencia
      cards[firstIndex!].isMatched = true; // Marca como emparejada
      cards[secondIndex!].isMatched = true; // Marca como emparejada
      score++; // Aumenta puntuación
      debugPrint('Score updated: $score'); // Log de puntuación
      _updateHighScore(); // Actualiza puntuación máxima
      firstIndex = null; // Reinicia primera carta
      secondIndex = null; // Reinicia segunda carta
      isProcessing = false; // Termina procesamiento
    } else {
      debugPrint('No match, preparing to flip back'); // Log de no coincidencia
      notifyListeners();
      // Espera medio segundo antes de voltear de nuevo
      await Future.delayed(const Duration(milliseconds: 500));
      debugPrint('Flipping back cards $firstIndex and $secondIndex');
      cards[firstIndex!].isFlipped = false; // Voltea de nuevo
      cards[secondIndex!].isFlipped = false; // Voltea de nuevo
      firstIndex = null; // Reinicia primera carta
      secondIndex = null; // Reinicia segunda carta
      isProcessing = false; // Termina procesamiento
    }

    notifyListeners(); // Notifica cambios

    // Verifica si todas las cartas están emparejadas
    if (cards.every((card) => card.isMatched)) {
      debugPrint('Game won!'); // Log de victoria
      gameWon.value = true; // Indica que el juego se ganó
    }
  }

  // Actualiza la puntuación máxima si es necesario
  Future<void> _updateHighScore() async {
    try {
      if (score > highScore) {
        highScore = score; // Actualiza puntuación máxima
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('highScore', score); // Guarda en almacenamiento
        debugPrint('High score updated: $highScore'); // Log de actualización
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error saving high score: $e'); // Log de error
    }
  }

  // Reinicia el juego
  void resetGame() {
    debugPrint('Resetting game'); // Log de reinicio
    initGame(rows, cols); // Llama a initGame con las mismas dimensiones
  }
}