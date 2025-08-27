// Esta es una clase en Dart, el lenguaje usado en Flutter, que define un modelo de datos para representar un "personaje" (Character).
// Un modelo es una estructura que organiza los datos de manera ordenada para usarlos en la aplicación, como en listas o pantallas.
class CharacterModel {
  // Definimos las propiedades del modelo, que representan las características de un personaje.
  // Todas son de tipo String o int y están marcadas como 'final', lo que significa que no pueden cambiar después de ser inicializadas.
  // Esto es común en modelos para garantizar que los datos sean inmutables y seguros.
  final int id; // Identificador único del personaje (por ejemplo, 1, 2, 3...).
  final String name; // Nombre del personaje (por ejemplo, "Rick Sanchez").
  final String status; // Estado del personaje (por ejemplo, "Alive", "Dead").
  final String species; // Especie del personaje (por ejemplo, "Human", "Alien").
  final String gender; // Género del personaje (por ejemplo, "Male", "Female").
  final String image; // URL de la imagen del personaje (por ejemplo, un enlace a una foto).
  final String origin; // Lugar de origen del personaje (por ejemplo, "Earth").
  final String location; // Ubicación actual del personaje (por ejemplo, "Dimension C-137").

  // Este es el constructor de la clase. Permite crear un objeto CharacterModel proporcionando valores para todas las propiedades.
  // La palabra 'required' indica que cada parámetro es obligatorio, es decir, no puede ser nulo al crear un personaje.
  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
  });

  // Este es un "factory constructor", una forma especial de constructor en Dart que no siempre crea una nueva instancia,
  // sino que puede devolver una existente o procesar datos antes de crear el objeto.
  // En este caso, convierte un JSON (un formato de datos común en APIs) en un objeto CharacterModel.
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    // Creamos y devolvemos una nueva instancia de CharacterModel usando los datos del JSON.
    return CharacterModel(
      // Extraemos el valor de 'id' del JSON. Si no existe ('null'), usamos 0 como valor por defecto.
      // El operador '??' se llama "null-coalescing operator" y proporciona un valor alternativo si el primero es nulo.
      id: json['id'] ?? 0,
      // Extraemos el nombre. Si es nulo, usamos 'Unknown' para evitar errores.
      name: json['name'] ?? 'Unknown',
      // Lo mismo para el estado, especie y género: si no hay datos, usamos 'Unknown'.
      status: json['status'] ?? 'Unknown',
      species: json['species'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      // La imagen es una URL, así que si no está disponible, devolvemos una cadena vacía.
      image: json['image'] ?? '',
      // Para 'origin' y 'location', accedemos a un subcampo 'name' dentro de un mapa anidado en el JSON.
      // Usamos el operador '?.' para evitar errores si 'origin' o 'location' son nulos.
      // Si no hay datos, devolvemos 'Unknown'.
      origin: json['origin']?['name'] ?? 'Unknown',
      location: json['location']?['name'] ?? 'Unknown',
    );
  }
}