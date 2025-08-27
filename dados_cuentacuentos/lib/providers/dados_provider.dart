// lib/providers/dados_provider.dart
// Provider para gestionar el estado de los dados.
// Soporta hasta 20 dados (icon1.png a icon20.png), número seleccionable (1 a 20, default 4).

import 'dart:math'; // Para generar aleatoriedad
import 'package:flutter/material.dart'; // Para ChangeNotifier
import 'package:shared_preferences/shared_preferences.dart'; // Para persistencia de datos
import 'package:vibration/vibration.dart'; // Para vibración en dispositivos móviles

import '../models/dado.dart'; // Modelo para los dados

// Clase para manejar el estado de los dados en la app
class DadosProvider extends ChangeNotifier {
  // Lista de los 20 dados disponibles, cada uno con su imagen (PNG 50x50)
  final List<Dado> _allDados = List.generate(
    20,
    (index) => Dado(assetPath: 'assets/images/icon${index + 1}.png'),
  );

  // Lista de dados que han sido tirados (secuencia aleatoria sin repetir)
  List<Dado> dadosTirados = [];

  // Número de dados a tirar (1 a 20, por defecto 4)
  int _numberOfDados = 4;

  // Getter para obtener el número de dados
  int get numberOfDados => _numberOfDados;

  // Instancia de SharedPreferences para persistencia
  final SharedPreferences prefs;

  // Constructor: inicializa con SharedPreferences y carga la última tirada
  DadosProvider(this.prefs) {
    _loadLastRoll(); // Carga la tirada y número de dados guardados
  }

  // Actualiza el número de dados y notifica cambios
  void setNumberOfDados(int value) {
    if (value >= 1 && value <= 20) { // Verifica que el valor esté en el rango permitido
      _numberOfDados = value;
      notifyListeners(); // Notifica a los widgets que el estado cambió
      _saveNumberOfDados(); // Guarda el número de dados
      // Si hay más dados tirados que el nuevo número, recorta la lista
      if (dadosTirados.length > _numberOfDados) {
        dadosTirados = dadosTirados.sublist(0, _numberOfDados);
        _saveLastRoll(); // Guarda la nueva lista
        notifyListeners();
      }
    }
  }

  // Tira los dados generando una secuencia aleatoria sin repetir
  Future<void> rollDados() async {
    // Verifica si el dispositivo soporta vibración
    bool? hasVibration = await Vibration.hasVibrator();
    if (hasVibration == true) {
      Vibration.vibrate(duration: 200); // Vibración corta de 200ms
    }

    // Baraja los dados y toma solo el número especificado
    final shuffled = List<Dado>.from(_allDados);
    shuffled.shuffle(Random()); // Mezcla aleatoriamente
    dadosTirados = shuffled.sublist(0, _numberOfDados); // Selecciona los primeros N dados
    notifyListeners(); // Notifica cambios
    _saveLastRoll(); // Guarda la tirada
  }

  // Carga la última tirada y número de dados desde SharedPreferences
  void _loadLastRoll() {
    final saved = prefs.getStringList('last_roll'); // Obtiene la lista de rutas guardadas
    if (saved != null) {
      // Convierte las rutas en objetos Dado y filtra los válidos
      dadosTirados = saved
          .map((path) => Dado.fromString(path))
          .where((dado) => _allDados.any((d) => d.assetPath == dado.assetPath))
          .toList();
    }
    final savedNumber = prefs.getInt('number_of_dados'); // Obtiene el número de dados
    if (savedNumber != null && savedNumber >= 1 && savedNumber <= 20) {
      _numberOfDados = savedNumber; // Actualiza si está en el rango permitido
    }
  }

  // Guarda la tirada actual en SharedPreferences
  void _saveLastRoll() {
    final paths = dadosTirados.map((dado) => dado.toString()).toList(); // Convierte dados a rutas
    prefs.setStringList('last_roll', paths); // Guarda la lista
  }

  // Guarda el número de dados en SharedPreferences
  void _saveNumberOfDados() {
    prefs.setInt('number_of_dados', _numberOfDados); // Guarda el número
  }
}