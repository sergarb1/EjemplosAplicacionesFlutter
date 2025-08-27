// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:juego_memoria/providers/game_provider.dart'; // Proveedor del estado del juego
import 'package:juego_memoria/widgets/card_widget.dart'; // Widget para las cartas
import 'package:juego_memoria/widgets/custom_scaffold.dart'; // Scaffold personalizado

// Clase para la pantalla del juego de memoria
class GamePage extends StatelessWidget {
  // Propiedades para definir el tamaño de la cuadrícula
  final int rows; // Número de filas
  final int cols; // Número de columnas

  // Constructor: requiere filas y columnas
  const GamePage({super.key, required this.rows, required this.cols});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor del juego para acceder al estado
    final gameProvider = context.watch<GameProvider>();
    // Obtenemos el tema de la app para usar estilos
    final theme = Theme.of(context);

    // Escucha cambios en el estado de victoria del juego
    return ValueListenableBuilder<bool>(
      valueListenable: gameProvider.gameWon, // Observa si el juego fue ganado
      builder: (context, gameWon, child) {
        // Si se ganó, mostramos un diálogo
        if (gameWon) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              barrierDismissible: false, // No se cierra al tocar afuera
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
                title: const Text('¡Enhorabuena!'), // Título del diálogo
                content: Text(
                  '¡Has ganado! Tu puntuación: ${gameProvider.score}\nMáxima puntuación: ${gameProvider.highScore}', // Muestra puntuación
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16), // Estilo del texto
                ),
                actions: [
                  // Botón para reiniciar el juego
                  TextButton(
                    onPressed: () {
                      gameProvider.resetGame(); // Reinicia el juego
                      Navigator.of(context).pop(); // Cierra el diálogo
                    },
                    child: const Text('Jugar de nuevo'), // Texto del botón
                  ),
                ],
              ),
            );
          });
        }
        return child!; // Retorna el contenido de la pantalla
      },
      child: CustomScaffold(
        // Botón para regresar a la pantalla principal
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Icono de flecha atrás
          onPressed: () => context.go('/'), // Navega a la ruta principal
        ),
        // Acciones en la barra superior
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0), // Espacio alrededor
            child: Text(
              'Puntos: ${gameProvider.score} | High: ${gameProvider.highScore}', // Muestra puntuación actual y máxima
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary, // Color del texto
              ),
            ),
          ),
        ],
        // Cuerpo de la pantalla con desplazamiento
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), // Espacio interno
          child: Column(
            children: [
              // Título animado con Hero para transiciones
              Hero(
                tag: 'logo', // Identificador para animaciones
                child: Text(
                  'Grid ${rows}x$cols', // Muestra el tamaño de la cuadrícula
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSurface, // Color del texto
                    fontWeight: FontWeight.bold, // Negrita
                  ),
                ),
              ),
              const SizedBox(height: 16), // Espacio vertical
              // Cuadrícula de cartas
              GridView.builder(
                shrinkWrap: true, // Ajusta el tamaño al contenido
                physics: const NeverScrollableScrollPhysics(), // Desactiva desplazamiento propio
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols, // Número de columnas
                  mainAxisSpacing: 8, // Espacio vertical entre cartas
                  crossAxisSpacing: 8, // Espacio horizontal entre cartas
                  childAspectRatio: 1, // Proporción cuadrada para las cartas
                ),
                itemCount: gameProvider.cards.length, // Número de cartas
                itemBuilder: (context, index) {
                  return CardWidget(index: index); // Crea un widget para cada carta
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}