// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:consumo_api/models/character_model.dart'; // Modelo para personajes
import 'package:consumo_api/models/episode_model.dart'; // Modelo para episodios
import 'package:consumo_api/models/info_model.dart'; // Modelo para información de paginación
import 'package:consumo_api/models/location_model.dart'; // Modelo para localizaciones
import 'package:consumo_api/services/api_service.dart'; // Servicio para consumir la API

// Clase para manejar el estado de los datos de la API
class ApiProvider extends ChangeNotifier {
  // Instancia del servicio para hacer solicitudes a la API
  final ApiService _apiService = ApiService();
  // Listas para almacenar personajes, localizaciones y episodios
  List<CharacterModel> characters = [];
  List<LocationModel> locations = [];
  List<EpisodeModel> episodes = [];
  // Información de paginación para cada tipo de dato
  InfoModel? characterInfo;
  InfoModel? locationInfo;
  InfoModel? episodeInfo;
  // Indicador de carga y mensaje de error
  bool isLoading = false;
  String? error;

  // Carga los datos iniciales de personajes, localizaciones y episodios
  Future<void> loadInitialData() async {
    await loadCharacters(); // Carga personajes
    await loadLocations(); // Carga localizaciones
    await loadEpisodes(); // Carga episodios
  }

  // Carga personajes desde la API
  Future<void> loadCharacters({int page = 1, String? name, String? status}) async {
    isLoading = true; // Indica que está cargando
    error = null; // Resetea el error
    notifyListeners(); // Notifica a los widgets que el estado cambió
    try {
      // Solicita datos de personajes a la API
      final response = await _apiService.getCharacters(page: page, name: name, status: status);
      // Convierte los resultados del JSON a una lista de CharacterModel
      characters = response['results'].map<CharacterModel>((json) => CharacterModel.fromJson(json)).toList();
      // Convierte la información de paginación a InfoModel
      characterInfo = InfoModel.fromJson(response['info']);
    } catch (e) {
      // Si hay un error, guarda el mensaje y usa datos de prueba
      error = 'Error loading characters: $e';
      debugPrint(error); // Muestra el error en la consola
      characters = _mockCharacters(); // Carga datos de prueba
      characterInfo = InfoModel(count: characters.length, pages: 1); // Info de paginación falsa
    }
    isLoading = false; // Termina la carga
    notifyListeners(); // Notifica el cambio de estado
  }

  // Carga localizaciones desde la API
  Future<void> loadLocations({int page = 1}) async {
    isLoading = true; // Indica que está cargando
    error = null; // Resetea el error
    notifyListeners(); // Notifica a los widgets que el estado cambió
    try {
      // Solicita datos de localizaciones a la API
      final response = await _apiService.getLocations(page: page);
      // Convierte los resultados del JSON a una lista de LocationModel
      locations = response['results'].map<LocationModel>((json) => LocationModel.fromJson(json)).toList();
      // Convierte la información de paginación a InfoModel
      locationInfo = InfoModel.fromJson(response['info']);
    } catch (e) {
      // Si hay un error, guarda el mensaje y usa datos de prueba
      error = 'Error loading locations: $e';
      debugPrint(error); // Muestra el error en la consola
      locations = _mockLocations(); // Carga datos de prueba
      locationInfo = InfoModel(count: locations.length, pages: 1); // Info de paginación falsa
    }
    isLoading = false; // Termina la carga
    notifyListeners(); // Notifica el cambio de estado
  }

  // Carga episodios desde la API
  Future<void> loadEpisodes({int page = 1}) async {
    isLoading = true; // Indica que está cargando
    error = null; // Resetea el error
    notifyListeners(); // Notifica a los widgets que elTema cambió
    try {
      // Solicita datos de episodios a la API
      final response = await _apiService.getEpisodes(page: page);
      // Convierte los resultados del JSON a una lista de EpisodeModel
      episodes = response['results'].map<EpisodeModel>((json) => EpisodeModel.fromJson(json)).toList();
      // Convierte la información de paginación a InfoModel
      episodeInfo = InfoModel.fromJson(response['info']);
    } catch (e) {
      // Si hay un error, guarda el mensaje y usa datos de prueba
      error = 'Error loading episodes: $e';
      debugPrint(error); // Muestra el error en la consola
      episodes = _mockEpisodes(); // Carga datos de prueba
      episodeInfo = InfoModel(count: episodes.length, pages: 1); // Info de paginación falsa
    }
    isLoading = false; // Termina la carga
    notifyListeners(); // Notifica el cambio de estado
  }

  // Datos de prueba para personajes en caso de error
  List<CharacterModel> _mockCharacters() {
    return [
      CharacterModel(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        gender: 'Male',
        image: '',
        origin: 'Earth (C-137)',
        location: 'Earth (Replacement Dimension)',
      ),
    ];
  }

  // Datos de prueba para localizaciones en caso de error
  List<LocationModel> _mockLocations() {
    return [
      LocationModel(id: 1, name: 'Earth', type: 'Planet', dimension: 'Dimension C-137'),
    ];
  }

  // Datos de prueba para episodios en caso de error
  List<EpisodeModel> _mockEpisodes() {
    return [
      EpisodeModel(id: 1, name: 'Pilot', airDate: 'December 2, 2013', episode: 'S01E01'),
    ];
  }
}