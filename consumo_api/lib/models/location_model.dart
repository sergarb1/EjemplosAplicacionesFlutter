// Clase para representar una ubicación en Flutter
class LocationModel {
  // Propiedades de la ubicación, no cambian tras crearse
  final int id; // ID de la ubicación
  final String name; // Nombre de la ubicación
  final String type; // Tipo de ubicación (ej. Planeta)
  final String dimension; // Dimensión de la ubicación (ej. Dimensión C-137)

  // Constructor: crea un objeto con datos requeridos
  LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
  });

  // Convierte un JSON en un objeto LocationModel
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? 0, // ID, 0 si no hay dato
      name: json['name'] ?? 'Unknown', // Nombre, "Unknown" si no hay dato
      type: json['type'] ?? 'Unknown', // Tipo, "Unknown" si no hay dato
      dimension: json['dimension'] ?? 'Unknown', // Dimensión, "Unknown" si no hay dato
    );
  }
}