// lib/models/dado.dart
// Modelo de datos para un dado.
// Representa un dado con una imagen SVG, siguiendo Clean Architecture.

class Dado {
  // Propiedad: ruta del asset SVG.
  final String assetPath;

  // Constructor: requiere la ruta del SVG.
  Dado({required this.assetPath});

  // Método para crear un Dado desde un String (para cargar desde persistencia).
  factory Dado.fromString(String path) {
    return Dado(assetPath: path);
  }

  // Método para convertir el Dado a String (para guardar en persistencia).
  @override
  String toString() {
    return assetPath;
  }
}