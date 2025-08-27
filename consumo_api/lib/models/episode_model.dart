// Clase para representar un episodio en Flutter
class EpisodeModel {
  // Propiedades del episodio, no cambian después de crearse
  final int id; // ID del episodio
  final String name; // Nombre del episodio
  final String airDate; // Fecha de emisión
  final String episode; // Código del episodio (ej. S01E01)

  // Constructor: crea un episodio con los datos requeridos
  EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
  });

  // Convierte un JSON en un objeto EpisodeModel
  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] ?? 0, // ID, 0 si no hay dato
      name: json['name'] ?? 'Unknown', // Nombre, "Unknown" si no hay dato
      airDate: json['air_date'] ?? 'Unknown', // Fecha, "Unknown" si no hay dato
      episode: json['episode'] ?? 'Unknown', // Código, "Unknown" si no hay dato
    );
  }
}