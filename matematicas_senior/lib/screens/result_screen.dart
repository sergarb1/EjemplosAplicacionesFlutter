import 'dart:math';
import 'package:flutter/material.dart';
import 'package:MatematicasSenior/utils/messages.dart'; // Lista de mensajes motivadores
import 'package:MatematicasSenior/widgets/custom_scaffold.dart'; // Scaffold personalizado con gradiente
import 'package:MatematicasSenior/screens/home_screen.dart'; // Pantalla de inicio

/// ===============================================================
/// PANTALLA DE RESULTADOS: ResultScreen
/// ===============================================================
/// Esta pantalla se muestra **al finalizar el juego** (20 preguntas).
///
/// Objetivo principal:
/// - Mostrar **puntuación final**
/// - **Felicitar al usuario** con un mensaje motivador
/// - Ofrecer **volver a jugar** con un botón grande y claro
///
/// Diseño accesible:
/// - Texto **grande y claro**
/// - Colores de **alto contraste**
/// - Icono de estrella para celebración
/// - Botón **muy visible**
///
/// Estructura visual:
/// ```
/// CustomScaffold
/// └── Center
///     └── SingleChildScrollView
///         └── Column
///             ├── Icono estrella
///             ├── Título: "¡Reto completado!"
///             ├── Mensaje motivador aleatorio
///             ├── Caja con puntuación
///             └── Botón "Jugar de nuevo"
/// ```
/// ===============================================================

class ResultScreen extends StatelessWidget {
  // =======================================================
  // PARÁMETROS OBLIGATORIOS
  // =======================================================

  /// Puntuación obtenida por el jugador
  /// (máximo: 40, ya que cada acierto al primer intento da +2)
  final int score;

  /// Número total de preguntas (siempre 20)
  /// Se usa para calcular la puntuación máxima: total * 2
  final int total;

  // Constructor que requiere `score` y `total`
  const ResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    // =======================================================
    // MENSAJE MOTIVADOR ALEATORIO
    // =======================================================
    // Se elige un mensaje diferente cada vez del archivo `messages.dart`
    // Ejemplo: "¡Eres un genio de las matemáticas!"
    final msg = encouragementMessages[Random().nextInt(encouragementMessages.length)];

    // =======================================================
    // ESTRUCTURA PRINCIPAL
    // =======================================================
    return CustomScaffold(
      // `CustomScaffold` proporciona:
      // - AppBar con logo
      // - Fondo gradiente (azul → violeta)
      // - SafeArea automático
      body: Center(
        // Centra todo el contenido vertical y horizontalmente
        child: SingleChildScrollView(
          // Permite desplazarse si la pantalla es pequeña
          padding: const EdgeInsets.all(24),
          child: Column(
            // Alinea todos los elementos verticalmente en el centro
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ===================================================
              // 1. ICONO DE ESTRELLA (CELEBRACIÓN)
              // ===================================================
              const Icon(
                Icons.star,
                size: 80, // Grande y visible
                color: Colors.orange,
              ),
              const SizedBox(height: 20),

              // ===================================================
              // 2. TÍTULO DE VICTORIA
              // ===================================================
              const Text(
                '¡Reto completado!',
                style: TextStyle(
                  fontSize: 32, // Grande
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // ===================================================
              // 3. MENSAJE MOTIVADOR PERSONALIZADO
              // ===================================================
              Text(
                msg,
                style: const TextStyle(
                  fontSize: 24, // Legible
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // ===================================================
              // 4. CAJA CON PUNTUACIÓN
              // ===================================================
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, // Fondo blanco para contraste
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Puntuación: $score / ${total * 2}',
                  // Ejemplo: "Puntuación: 36 / 40"
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C5CE7), // Color principal de la app
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // ===================================================
              // 5. BOTÓN "JUGAR DE NUEVO"
              // ===================================================
              ElevatedButton(
                // Al pulsar: vuelve a la pantalla de inicio
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Color llamativo
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ), // Botón grande
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ), // Bordes muy redondeados
                  elevation: 8,
                  textStyle: const TextStyle(
                    fontSize: 26, // Texto grande
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Jugar de nuevo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}