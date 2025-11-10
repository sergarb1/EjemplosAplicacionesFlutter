// Clase que representa una pregunta matemática con sus opciones y estado
class MathQuestion {
  // Operando A de la operación (por ejemplo, 3 en "3 + 4")
  final int a;

  // Operando B de la operación (por ejemplo, 4 en "3 + 4")
  final int b;

  // Operación a realizar: puede ser "+", "-", "×", "÷", etc.
  final String operation;

  // Resultado correcto de la operación
  final int correctAnswer;

  // Lista de posibles respuestas (incluye la correcta y opciones falsas)
  final List<int> options;

  // Opción elegida por el usuario (puede ser null si aún no ha respondido)
  int? selectedOption;           

  // Indica si respondió correctamente al primer intento
  bool answeredCorrectlyFirstTry = false;

  // Indica si el usuario ya intentó responder (aunque se equivocara)
  bool hasAttempted = false;     

  // Constructor que obliga a pasar los valores necesarios al crear la pregunta
  MathQuestion({
    required this.a,
    required this.b,
    required this.operation,
    required this.correctAnswer,
    required this.options,
  });
}
