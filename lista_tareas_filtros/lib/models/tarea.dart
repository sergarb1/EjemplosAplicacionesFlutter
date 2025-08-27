// Definimos una clase llamada Tarea que representa una tarea en nuestra aplicación.
class Tarea {
  // Propiedades de la clase:
  String titulo; // Título de la tarea.
  String descripcion; // Descripción de la tarea.
  bool estaCompletada; // Indica si la tarea está completada o no.
  String categoria; // Categoría de la tarea (por ejemplo, "Trabajo", "Personal").

  // Constructor de la clase Tarea.
  Tarea({
    required this.titulo, // El título es obligatorio.
    this.descripcion = '', // La descripción es opcional y por defecto es una cadena vacía.
    this.estaCompletada = false, // Por defecto, la tarea no está completada.
    this.categoria = 'General', // Por defecto, la categoría es "General".
  });

  // Método para convertir una tarea a formato JSON (en este caso, una cadena de texto).
  // Esto es útil para guardar la tarea en un archivo o base de datos.
  String toJson() {
    // Concatenamos las propiedades separadas por el carácter '|'.
    return '$titulo|$descripcion|${estaCompletada ? 1 : 0}|$categoria';
  }

  // Método de fábrica para crear una instancia de Tarea a partir de una cadena JSON.
  // Esto es útil para cargar tareas guardadas previamente.
  factory Tarea.fromJson(String json) {
    // Dividimos la cadena JSON en partes usando el carácter '|' como separador.
    final parts = json.split('|');
    return Tarea(
      titulo: parts[0], // El primer elemento es el título.
      descripcion: parts.length > 1 ? parts[1] : '', // El segundo elemento es la descripción (si existe).
      estaCompletada: parts.length > 2 ? parts[2] == '1' : false, // El tercer elemento indica si está completada.
      categoria: parts.length > 3 ? parts[3] : 'General', // El cuarto elemento es la categoría (si existe).
    );
  }
}