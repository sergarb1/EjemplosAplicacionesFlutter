// Clase para representar una carta en un juego (por ejemplo, un juego de memoria)
class CardModel {
  // Propiedades de la carta
  final String imagePath; // Ruta de la imagen de la carta
  bool isFlipped; // Indica si la carta está volteada
  bool isMatched; // Indica si la carta ha sido emparejada

  // Constructor: requiere la ruta de la imagen, con valores por defecto para volteada y emparejada
  CardModel({
    required this.imagePath, // Ruta de la imagen, obligatoria
    this.isFlipped = false, // Por defecto, la carta no está volteada
    this.isMatched = false, // Por defecto, la carta no está emparejada
  });

  // Método para crear una copia de la carta con los mismos valores
  CardModel copy() => CardModel(
        imagePath: imagePath, // Copia la ruta de la imagen
        isFlipped: isFlipped, // Copia el estado de volteo
        isMatched: isMatched, // Copia el estado de emparejamiento
      );
}