// Clase para representar información de paginación en Flutter
class InfoModel {
  // Propiedades de la información, no cambian tras crearse
  final int count; // Total de elementos
  final int pages; // Total de páginas
  final String? next; // URL de la siguiente página, puede ser nulo
  final String? prev; // URL de la página anterior, puede ser nulo

  // Constructor: crea un objeto con datos requeridos y opcionales
  InfoModel({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  // Convierte un JSON en un objeto InfoModel
  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      count: json['count'] ?? 0, // Total de elementos, 0 si no hay dato
      pages: json['pages'] ?? 0, // Total de páginas, 0 si no hay dato
      next: json['next'], // URL siguiente, puede ser nulo
      prev: json['prev'], // URL anterior, puede ser nulo
    );
  }
}