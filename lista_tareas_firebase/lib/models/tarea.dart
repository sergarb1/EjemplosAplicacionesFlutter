class Tarea {
  // Propiedades de la clase Tarea
  String titulo; // Título de la tarea
  String descripcion; // Descripción de la tarea
  bool estaCompletada; // Indica si la tarea está completada o no
  String categoria; // Categoría de la tarea (por defecto es 'General')
  String? documentId; // ID del documento en Firestore (puede ser nulo)

  // Constructor de la clase Tarea
  Tarea({
    this.documentId, // ID del documento (opcional)
    required this.titulo, // Título es obligatorio
    this.descripcion = '', // Descripción por defecto es una cadena vacía
    this.estaCompletada = false, // Por defecto, la tarea no está completada
    this.categoria = 'General', // Categoría por defecto es 'General'
  });

  // Método para convertir la tarea a un Map (útil para guardar en Firestore)
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo, // Se guarda el título
      'descripcion': descripcion, // Se guarda la descripción
      'estaCompletada': estaCompletada, // Se guarda el estado de completado
      'categoria': categoria, // Se guarda la categoría
      'documentId': documentId, // Se guarda el ID del documento
    };
  }

  // Método de fábrica para crear una tarea desde un Map (útil al leer de Firestore)
  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      documentId: json['documentId'], // Se obtiene el ID del documento
      titulo: json['titulo'], // Se obtiene el título
      descripcion: json['descripcion'] ?? '', // Si no hay descripción, se usa una cadena vacía
      estaCompletada: json['estaCompletada'] ?? false, // Si no hay estado, se asume no completada
      categoria: json['categoria'] ?? 'General', // Si no hay categoría, se usa 'General'
    );
  }
}