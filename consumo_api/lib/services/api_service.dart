// Importamos el paquete para hacer solicitudes HTTP
import 'package:http/http.dart' as http; // Biblioteca para consumir APIs
import 'dart:convert'; // Para convertir JSON a datos de Dart

// Clase para manejar solicitudes a la API de Rick and Morty
class ApiService {
  // URL base de la API
  final String baseUrl = 'https://rickandmortyapi.com/api';

  // Obtiene personajes desde la API
  Future<Map<String, dynamic>> getCharacters({int page = 1, String? name, String? status}) async {
    // Crea la URL con parámetros de página, nombre y estado (si existen)
    final uri = Uri.parse('$baseUrl/character').replace(queryParameters: {
      'page': page.toString(), // Número de página
      if (name != null) 'name': name, // Filtro por nombre (opcional)
      if (status != null) 'status': status, // Filtro por estado (opcional)
    });
    // Hace la solicitud HTTP GET
    final response = await http.get(uri);
    // Verifica si la solicitud fue exitosa (código 200)
    if (response.statusCode == 200) {
      // Convierte el cuerpo de la respuesta (JSON) a un mapa
      return jsonDecode(response.body);
    }
    // Lanza un error si la solicitud falla
    throw Exception('Failed to load characters');
  }

  // Obtiene localizaciones desde la API
  Future<Map<String, dynamic>> getLocations({int page = 1}) async {
    // Crea la URL con parámetro de página
    final uri = Uri.parse('$baseUrl/location').replace(queryParameters: {'page': page.toString()});
    // Hace la solicitud HTTP GET
    final response = await http.get(uri);
    // Verifica si la solicitud fue exitosa (código 200)
    if (response.statusCode == 200) {
      // Convierte el cuerpo de la respuesta (JSON) a un mapa
      return jsonDecode(response.body);
    }
    // Lanza un error si la solicitud falla
    throw Exception('Failed to load locations');
  }

  // Obtiene episodios desde la API
  Future<Map<String, dynamic>> getEpisodes({int page = 1}) async {
    // Crea la URL con parámetro de página
    final uri = Uri.parse('$baseUrl/episode').replace(queryParameters: {'page': page.toString()});
    // Hace la solicitud HTTP GET
    final response = await http.get(uri);
    // Verifica si la solicitud fue exitosa (código 200)
    if (response.statusCode == 200) {
      // Convierte el cuerpo de la respuesta (JSON) a un mapa
      return jsonDecode(response.body);
    }
    // Lanza un error si la solicitud falla
    throw Exception('Failed to load episodes');
  }
}