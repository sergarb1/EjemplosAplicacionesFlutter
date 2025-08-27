// Clase que define el modelo de una tarea en la aplicación
class Tarea {
  // Propiedades de la tarea
  String titulo; // Título de la tarea, obligatorio
  String descripcion; // Descripción opcional de la tarea
  bool estaCompletada; // Indica si la tarea está completada o no

  // Constructor de la clase Tarea
  Tarea({
    required this.titulo, // El título es obligatorio
    this.descripcion = '', // La descripción es opcional, por defecto vacía
    this.estaCompletada = false, // Por defecto, la tarea no está completada
  });
}