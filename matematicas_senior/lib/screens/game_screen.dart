import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:MatematicasSenior/models/question.dart';
import 'package:MatematicasSenior/screens/result_screen.dart';
import 'package:MatematicasSenior/widgets/custom_scaffold.dart';

/// ===============================================================
/// PANTALLA PRINCIPAL DEL JUEGO: GameScreen
/// ===============================================================
/// Esta clase representa la pantalla donde el usuario juega.
/// Muestra una operación matemática (+, -, x), tres opciones de respuesta,
/// feedback visual, sonoro y táctil, y avanza automáticamente tras 6 segundos.
///
/// Objetivo pedagógico:
/// - Reforzar operaciones básicas
/// - Mejorar concentración y memoria
/// - Usar interfaz clara y grande para personas mayores
///
/// Características clave:
/// - 20 preguntas aleatorias
/// - Sin números negativos
/// - Animaciones suaves
/// - Vibración y sonido
/// - Avance automático con temporizador visual
/// ===============================================================

class GameScreen extends StatefulWidget {
  // Constructor con clave opcional (buena práctica en Flutter)
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with TickerProviderStateMixin {
  // =======================================================
  // VARIABLES DE ESTADO (State)
  // =======================================================

  /// Lista que contiene todas las preguntas generadas (20 en total)
  /// Se crea una sola vez al iniciar la pantalla
  late List<MathQuestion> questions;

  /// Índice de la pregunta actual (empieza en 0, va hasta 19)
  int currentIndex = 0;

  /// Puntuación total del jugador
  /// +2 si acierta al primer intento
  /// +1 si acierta en intentos posteriores
  int score = 0;

  // =======================================================
  // CONTROLADORES DE ANIMACIÓN
  // =======================================================

  /// Controlador para la animación de "temblor" cuando el usuario falla
  /// Hace que la operación se mueva de lado a lado rápidamente
  late AnimationController _shakeCtrl;

  /// Animación que define cómo se mueve el temblor
  late Animation<double> _shakeAnim;

  /// Controlador para el círculo de tiempo (6 segundos)
  /// Controla el progreso del círculo naranja
  late AnimationController _timerCtrl;

  /// Animación que va de 1.0 (lleno) a 0.0 (vacío) en 6 segundos
  late Animation<double> _timerAnim;

  // =======================================================
  // REPRODUCTOR DE SONIDO
  // =======================================================

  /// Instancia del reproductor de audio
  /// Se usa para reproducir 'correct.wav' y 'error.wav'
  final AudioPlayer _player = AudioPlayer();

  // =======================================================
  // TEMPORIZADOR AUTOMÁTICO
  // =======================================================

  /// Temporizador que se activa tras acertar
  /// Si no se pulsa "Siguiente", avanza solo tras 6 segundos
  Timer? _autoNextTimer;

  // =======================================================
  // ANIMACIONES DE BOTONES INCORRECTOS
  // =======================================================

  /// Mapa que guarda el controlador de animación para cada botón incorrecto
  /// La clave es el índice del botón (0, 1 o 2)
  final Map<int, AnimationController> _slideControllers = {};

  /// Mapa que guarda la animación de deslizamiento para cada botón
  final Map<int, Animation<Offset>> _slideAnimations = {};

  // =======================================================
  // MÉTODO initState()
  // =======================================================

  @override
  void initState() {
    super.initState();

    // 1. Generar las 20 preguntas al iniciar la pantalla
    questions = _generateQuestions();

    // 2. Configurar animación de temblor (error)
    _shakeCtrl = AnimationController(
      duration: const Duration(milliseconds: 400), // Duración del temblor
      vsync: this, // Necesario para animaciones en StatefulWidget
    );
    _shakeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeCtrl, curve: Curves.elasticIn),
    );

    // 3. Configurar animación del círculo de tiempo
    _timerCtrl = AnimationController(
      duration: const Duration(seconds: 6), // 6 segundos de espera
      vsync: this,
    );
    _timerAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _timerCtrl, curve: Curves.linear),
    );
  }

  // =======================================================
  // GENERACIÓN DE PREGUNTAS
  // =======================================================

  /// Genera 20 preguntas aleatorias con suma, resta y multiplicación
  /// Garantiza:
  /// - Sin números negativos
  /// - Opciones distintas
  /// - Resultados razonables para personas mayores
  List<MathQuestion> _generateQuestions() {
    // Generador de números aleatorios
    final rnd = Random();

    // Lista de operaciones posibles
    final ops = ['+', '-', 'x'];

    // Lista final de preguntas
    final List<MathQuestion> list = [];

    // Bucle para crear 20 preguntas
    for (int i = 0; i < 20; i++) {
      // Elegir operación aleatoria
      final op = ops[rnd.nextInt(3)];
      int a, b, correct;

      // === GENERAR OPERACIÓN SEGÚN TIPO ===
      if (op == '+') {
        // Suma: números del 1 al 15
        a = rnd.nextInt(15) + 1;
        b = rnd.nextInt(15) + 1;
        correct = a + b;
      } else if (op == '-') {
        // Resta: siempre positiva (b ≤ a)
        a = rnd.nextInt(16) + 5; // 5 a 20
        b = rnd.nextInt(a - 1) + 1; // 1 hasta a-1
        correct = a - b;
      } else {
        // Multiplicación: tablas del 1 al 10
        a = rnd.nextInt(10) + 1;
        b = rnd.nextInt(10) + 1;
        correct = a * b;
      }

      // === GENERAR OPCIONES INCORRECTAS ===
      int wrong1, wrong2;
      do {
        // Variar ±3 del resultado correcto
        wrong1 = correct + rnd.nextInt(6) - 3;
        wrong2 = correct + rnd.nextInt(6) - 3;
      } while (
          // Evitar: misma que correcta, repetidas o negativas
          wrong1 == correct ||
          wrong2 == correct ||
          wrong1 == wrong2 ||
          wrong1 < 0 ||
          wrong2 < 0
      );

      // Mezclar las 3 opciones (correcta + 2 incorrectas)
      final options = [correct, wrong1, wrong2]..shuffle();

      // Crear y añadir la pregunta a la lista
      list.add(MathQuestion(
        a: a,
        b: b,
        operation: op,
        correctAnswer: correct,
        options: options,
      ));
    }

    return list;
  }

  // =======================================================
  // PROCESAR RESPUESTA DEL USUARIO
  // =======================================================

  /// Se llama cuando el usuario pulsa una opción
  /// Gestiona acierto/error, puntos, sonido, vibración y animaciones
  Future<void> _answer(int selected) async {
    // Obtener la pregunta actual
    final q = questions[currentIndex];

    // Marcar que ya se intentó responder (evita múltiples intentos)
    if (!q.hasAttempted) q.hasAttempted = true;

    // Guardar la opción seleccionada
    q.selectedOption = selected;

    // === CASO 1: ACIERTO ===
    if (selected == q.correctAnswer) {
      // Puntuación: +2 al primer intento, +1 después
      if (!q.answeredCorrectlyFirstTry) {
        q.answeredCorrectlyFirstTry = true;
        score += 2;
      } else {
        score += 1;
      }

      // Reproducir sonido de acierto
      await _playSound('correct.wav');

      // Vibración suave
      await _vibrateSuccess();

      // Mostrar resultado y activar temporizador de 6 segundos
      _startTimer();

    // === CASO 2: ERROR ===
    } else {
      // Reproducir sonido de error
      await _playSound('error.wav');

      // Vibración doble (error)
      await _vibrateError();

      // Animación de temblor en la operación
      _shakeCtrl.forward().then((_) => _shakeCtrl.reset());

      // === ANIMAR DESAPARICIÓN DEL BOTÓN INCORRECTO ===
      final index = q.options.indexOf(selected);
      final ctrl = AnimationController(
          duration: const Duration(milliseconds: 300), vsync: this);
      final anim = Tween<Offset>(begin: Offset.zero, end: const Offset(-1.5, 0))
          .animate(CurvedAnimation(parent: ctrl, curve: Curves.easeIn));
      _slideControllers[index] = ctrl;
      _slideAnimations[index] = anim;
      ctrl.forward(); // Iniciar deslizamiento
    }

    // Actualizar la interfaz
    setState(() {});
  }

  // =======================================================
  // TEMPORIZADOR DE 6 SEGUNDOS
  // =======================================================

  /// Inicia el círculo de tiempo y el temporizador automático
  void _startTimer() {
    // Reiniciar y comenzar la animación del círculo
    _timerCtrl.reset();
    _timerCtrl.forward();

    // Cancelar temporizador anterior (por si acaso)
    _autoNextTimer?.cancel();

    // Crear nuevo temporizador: avanza tras 6 segundos
    _autoNextTimer = Timer(const Duration(seconds: 6), () {
      if (mounted) {
        _nextQuestion();
      }
    });
  }

  // =======================================================
  // PASAR A LA SIGUIENTE PREGUNTA
  // =======================================================

  /// Avanza manualmente (botón) o automáticamente
  void _nextQuestion() {
    // Cancelar temporizador y detener animación
    _autoNextTimer?.cancel();
    _timerCtrl.stop();

    // Si hay más preguntas
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        // Limpiar animaciones de botones deslizados
        _slideControllers.clear();
        _slideAnimations.clear();
      });
    } else {
      // Si es la última, ir a pantalla de resultados
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(score: score, total: questions.length),
        ),
      );
    }
  }

  // =======================================================
  // SONIDOS
  // =======================================================

  /// Reproduce un archivo de sonido desde assets/sounds/
  Future<void> _playSound(String file) async {
    try {
      await _player.play(AssetSource('sounds/$file'));
    } catch (e) {
      debugPrint("Error al reproducir sonido: $e");
    }
  }

  // =======================================================
  // VIBRACIÓN
  // =======================================================

  /// Vibración corta y suave al acertar
  Future<void> _vibrateSuccess() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 120);
    }
  }

  /// Vibración doble al fallar
  Future<void> _vibrateError() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(pattern: [0, 80, 40, 80]);
    }
  }

  // =======================================================
  // LIMPIEZA DE RECURSOS
  // =======================================================

  @override
  void dispose() {
    // Liberar controladores de animación
    _shakeCtrl.dispose();
    _timerCtrl.dispose();

    // Liberar reproductor de audio
    _player.dispose();

    // Cancelar temporizador
    _autoNextTimer?.cancel();

    // Liberar animaciones de botones
    _slideControllers.values.forEach((c) => c.dispose());

    super.dispose();
  }

  // =======================================================
  // INTERFAZ GRÁFICA (UI)
  // =======================================================

  @override
  Widget build(BuildContext context) {
    // Pregunta actual
    final q = questions[currentIndex];

    // ¿Se ha acertado?
    final isAnswered = q.selectedOption == q.correctAnswer && q.answeredCorrectlyFirstTry;

    return CustomScaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // =========================================
                // BARRA DE PROGRESO
                // =========================================
                LinearProgressIndicator(
                  value: (currentIndex + 1) / questions.length,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation(Colors.orange),
                  minHeight: 6,
                ),
                const SizedBox(height: 8),

                // =========================================
                // NÚMERO DE PREGUNTA
                // =========================================
                Text(
                  '${currentIndex + 1} / ${questions.length}',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 16),

                // =========================================
                // OPERACIÓN MATEMÁTICA (GRANDE)
                // =========================================
                AnimatedBuilder(
                  animation: _shakeAnim,
                  builder: (_, child) {
                    final offset = 2.5 * sin(_shakeAnim.value * 2 * pi);
                    return Transform.translate(
                      offset: Offset(offset, 0),
                      child: child,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
                    ),
                    child: Text(
                      '${q.a} ${q.operation} ${q.b} = ?',
                      style: const TextStyle(
                        fontSize: 48, // Grande y claro
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C5CE7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // =========================================
                // RESULTADO Y MENSAJE (TRAS ACIERTO)
                // =========================================
                if (isAnswered) ...[
                  // Contenedor con borde verde
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Column(
                      children: [
                        // Operación completa con resultado
                        Text(
                          '${q.a} ${q.operation} ${q.b} = ${q.correctAnswer}',
                          style: const TextStyle(
                            fontSize: 40, // Más pequeño que la operación
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Mensaje motivador
                        Text(
                          _getRandomEncouragement(),
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // =====================================
                  // CÍRCULO DE TIEMPO (SIN NÚMERO)
                  // =====================================
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: AnimatedBuilder(
                      animation: _timerAnim,
                      builder: (_, __) {
                        return CircularProgressIndicator(
                          value: _timerAnim.value,
                          strokeWidth: 10,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation(Colors.orange),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // =====================================
                  // BOTÓN SIGUIENTE
                  // =====================================
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Siguiente'),
                  ),
                  const SizedBox(height: 40),
                ] else
                  // =========================================
                  // OPCIONES DE RESPUESTA (GRANDES)
                  // =========================================
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final buttonWidth = (constraints.maxWidth - 24) / 3;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: q.options.asMap().entries.map((entry) {
                          final index = entry.key;
                          final opt = entry.value;
                          final isCorrect = opt == q.correctAnswer;
                          final wasSelected = q.selectedOption == opt;
                          final isWrong = wasSelected && !isCorrect;

                          final slideCtrl = _slideControllers[index];
                          final slideAnim = _slideAnimations[index];

                          return SizedBox(
                            width: buttonWidth - 8,
                            child: (slideCtrl != null && slideAnim != null)
                                ? SlideTransition(
                                    position: slideAnim,
                                    child: const SizedBox(width: 0),
                                  )
                                : ElevatedButton(
                                    onPressed: isWrong
                                        ? null
                                        : () {
                                            setState(() => q.selectedOption = opt);
                                            _answer(opt);
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isWrong
                                          ? Colors.red.shade400
                                          : isCorrect && q.answeredCorrectlyFirstTry
                                              ? Colors.green
                                              : Colors.orange,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: isWrong ? 0 : 6,
                                      textStyle: const TextStyle(
                                        fontSize: 36, // Grande como la operación
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: Text('$opt'),
                                  ),
                          );
                        }).toList(),
                      );
                    },
                  ),

                // Espacio final para que el gradiente se vea completo
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =======================================================
  // MENSAJES MOTIVADORES ALEATORIOS
  // =======================================================

  /// Devuelve un mensaje positivo diferente cada vez
  String _getRandomEncouragement() {
    final messages = [
      "¡Genial! ¡Tu mente brilla!",
      "¡Perfecto! ¡Sigue así!",
      "¡Eres un crack!",
      "¡Impresionante! ¡Otro acierto!",
      "¡Muy bien! ¡Vas como un cohete!",
      "¡Ole tú! ¡Qué máquina!",
      "¡Fantástico! ¡Tu cerebro es oro!",
      "¡Súper! ¡Nadie te para!",
      "¡Increíble! ¡Eres un genio!",
      "¡Bravo! ¡Sigue entrenando!",
      "¡Excelente! ¡Eres el mejor!",
      "¡Qué crack! ¡Otro punto!",
      "¡Magnífico! ¡Tu memoria vuela!",
      "¡Sigue así! ¡Vas imparable!",
      "¡Qué listo! ¡Otro acierto!",
      "¡Tremendo! ¡Tu mente es rápida!",
      "¡Genial! ¡Eres un campeón!",
      "¡Perfecto! ¡Sigue sumando!",
      "¡Increíble! ¡Tu cerebro brilla!",
      "¡Ole! ¡Otro punto ganado!",
    ];
    return messages[Random().nextInt(messages.length)];
  }
}