// lib/widgets/cell_widget.dart
// Widget reutilizable para una casilla del tablero.
// Casillas más pequeñas con neumorphic style y fondo oscuro para contraste con piezas blancas.
// Animación de rebote al colocar piezas.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:provider/provider.dart'; // Para consumir el provider

import '../models/game_model.dart'; // Constantes del modelo del juego
import '../providers/game_provider.dart'; // Proveedor del estado del juego

// Widget con estado para una casilla del tablero
class CellWidget extends StatefulWidget {
  final int row; // Fila de la casilla
  final int col; // Columna de la casilla

  // Constructor: requiere fila y columna
  const CellWidget({super.key, required this.row, required this.col});

  @override
  CellWidgetState createState() => CellWidgetState();
}

// Estado del widget CellWidget
class CellWidgetState extends State<CellWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controlador para la animación
  late Animation<double> _scaleAnimation; // Animación de escala

  @override
  void initState() {
    super.initState();
    // Configura la animación de rebote
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // Duración de la animación
      vsync: this, // Sincroniza con el ciclo de refresco
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut), // Curva de rebote
    );
  }

  @override
  void didUpdateWidget(CellWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Obtiene el estado actual de la casilla
    final newCell = Provider.of<GameProvider>(context, listen: false)
        .gameModel
        .board[widget.row][widget.col];
    // Determina el estado anterior de la casilla
    final oldCell = oldWidget.row == widget.row && oldWidget.col == widget.col
        ? Provider.of<GameProvider>(context, listen: false)
            .gameModel
            .board[widget.row][widget.col]
        : GameModel.empty;
    // Activa la animación si la casilla cambió y no está vacía
    if (newCell != oldCell && newCell != GameModel.empty) {
      _controller.forward().then((_) => _controller.reverse()); // Anima y regresa
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera el controlador de animación
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene el proveedor del juego
    final gameProvider = Provider.of<GameProvider>(context);
    // Estado de la casilla actual
    final cell = gameProvider.gameModel.board[widget.row][widget.col];

    // Detecta toques para colocar una pieza
    return GestureDetector(
      onTap: () => gameProvider.placePiece(widget.row, widget.col), // Coloca la pieza
      child: ScaleTransition(
        scale: _scaleAnimation, // Aplica la animación de escala
        child: Container(
          margin: const EdgeInsets.all(2), // Margen reducido para casillas más pequeñas
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.teal.shade50 // Fondo claro para tema claro
                : Colors.teal.shade900, // Fondo oscuro para tema oscuro
            borderRadius: BorderRadius.circular(6), // Bordes redondeados
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.1), // Sombra oscura
                offset: const Offset(2, 2), // Desplazamiento reducido
                blurRadius: 2, // Difuminado reducido
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha:0.2), // Sombra clara
                offset: const Offset(-2, -2), // Desplazamiento reducido
                blurRadius: 2, // Difuminado reducido
              ),
            ],
          ),
          child: Center(
            child: cell == GameModel.empty
                ? null // No muestra nada si la casilla está vacía
                : Icon(
                    Icons.circle, // Icono de pieza
                    color: cell == GameModel.black ? Colors.black : Colors.white, // Color según el jugador
                    size: 20, // Tamaño reducido para casillas más pequeñas
                    semanticLabel: cell == GameModel.black
                        ? 'Pieza negra'
                        : 'Pieza blanca', // Etiqueta para accesibilidad
                  ),
          ),
        ),
      ),
    );
  }
}