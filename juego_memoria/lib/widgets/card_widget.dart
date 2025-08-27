// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:juego_memoria/providers/game_provider.dart'; // Proveedor del estado del juego

// Clase para mostrar una carta en el juego de memoria
class CardWidget extends StatelessWidget {
  // Índice de la carta en la lista
  final int index;

  // Constructor: requiere el índice de la carta
  const CardWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor del juego para acceder al estado
    final gameProvider = context.watch<GameProvider>();
    // Obtenemos la carta en el índice especificado
    final card = gameProvider.cards[index];

    // Widget para detectar toques en la carta
    return GestureDetector(
      onTap: () {
        // Solo permite voltear si no está emparejada ni en procesamiento
        if (!card.isMatched && !gameProvider.isProcessing) {
          debugPrint('Tapped card at index: $index'); // Log del toque
          gameProvider.flipCard(index); // Voltea la carta
        }
      },
      // Widget para animar el cambio de estado de la carta
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500), // Duración de la animación
        transitionBuilder: (child, animation) {
          // Transición de desvanecimiento
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: Card(
          key: ValueKey<bool>(card.isFlipped || card.isMatched), // Clave para la animación
          color: card.isMatched ? Colors.green[100] : Colors.blueGrey, // Color según estado
          child: Center(
            child: card.isFlipped || card.isMatched
                ? (card.imagePath.isNotEmpty
                    ? Image.asset(
                        card.imagePath, // Muestra la imagen de la carta
                        fit: BoxFit.cover, // Ajusta la imagen al espacio
                        width: double.infinity, // Ocupa todo el ancho
                        height: double.infinity, // Ocupa toda la altura
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('Error loading image: ${card.imagePath}, $error'); // Log de error
                          return Text(
                            card.imagePath.split('/').last, // Muestra el nombre del archivo
                            style: const TextStyle(color: Colors.red, fontSize: 20),
                            textAlign: TextAlign.center,
                          );
                        },
                      )
                    : const Text(
                        'No Image', // Texto si no hay imagen
                        style: TextStyle(color: Colors.red, fontSize: 20),
                        textAlign: TextAlign.center,
                      ))
                : const Icon(Icons.question_mark, size: 40), // Icono si la carta no está volteada
          ),
        ),
      ),
    );
  }
}