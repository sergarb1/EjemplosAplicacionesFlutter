// lib/providers/recipe_provider.dart
import 'dart:convert'; // Biblioteca para convertir objetos Dart a JSON y viceversa.
import 'package:flutter/material.dart'; // Biblioteca de Flutter para widgets y ChangeNotifier.
import 'package:shared_preferences/shared_preferences.dart'; // Paquete para almacenar datos persistentes.
import '../models/recipe.dart'; // Importa el modelo Recipe que define la estructura de una receta.

// Clase RecipeProvider: Gestiona la lista de recetas, las guarda en almacenamiento persistente
// y notifica a la interfaz de usuario (UI) cuando hay cambios. Usa el patrón Provider para
// la gestión de estado en Flutter, permitiendo que los widgets se actualicen automáticamente.
class RecipeProvider with ChangeNotifier {
  // Lista privada que almacena todas las recetas en memoria durante la ejecución de la app.
  // 'final' asegura que no se reasigne la referencia de la lista, pero su contenido sí puede modificarse.
  final List<Recipe> _recipes = [];

  // Clave constante para identificar las recetas en SharedPreferences.
  // 'static const' significa que es una constante compartida por todas las instancias de la clase.
  static const String _recipesKey = 'recipes';

  // Constructor de la clase. Se ejecuta cuando se crea una instancia de RecipeProvider.
  // Llama a _loadRecipes() para cargar las recetas guardadas al iniciar la app.
  RecipeProvider() {
    _loadRecipes();
  }

  // Getter público para acceder a la lista de recetas desde fuera de la clase.
  // Devuelve una referencia de solo lectura a _recipes, evitando modificaciones directas.
  // Los widgets (como HomePage) usan este getter para mostrar las recetas.
  List<Recipe> get recipes => _recipes;

  // Método asíncrono para cargar recetas desde SharedPreferences.
  // Lee el JSON almacenado, lo convierte en objetos Recipe y actualiza la lista _recipes.
  Future<void> _loadRecipes() async {
    // Obtiene una instancia de SharedPreferences para acceder al almacenamiento persistente.
    final prefs = await SharedPreferences.getInstance();
    // Lee la cadena JSON almacenada bajo la clave 'recipes'. Puede ser null si no hay datos.
    final String? recipesJson = prefs.getString(_recipesKey);
    // Verifica si hay datos guardados para procesarlos.
    if (recipesJson != null) {
      // Convierte la cadena JSON en una lista de objetos dinámicos.
      final List<dynamic> decoded = jsonDecode(recipesJson) as List<dynamic>;
      // Limpia la lista actual para evitar duplicados.
      _recipes.clear();
      // Convierte cada elemento JSON en un objeto Recipe usando el método fromJson.
      // Añade todos los objetos Recipe a _recipes.
      _recipes.addAll(decoded.map((item) => Recipe.fromJson(item as Map<String, dynamic>)));
      // Notifica a los widgets que escuchan (como HomePage) para que se actualicen con las recetas cargadas.
      notifyListeners();
    }
  }

  // Método asíncrono para guardar la lista de recetas en SharedPreferences.
  // Convierte las recetas a JSON y las almacena para que persistan al cerrar la app.
  Future<void> _saveRecipes() async {
    // Obtiene una instancia de SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    // Convierte la lista _recipes a una lista de mapas JSON usando el método toJson de Recipe.
    // Luego, convierte la lista a una cadena JSON.
    final String recipesJson = jsonEncode(_recipes.map((recipe) => recipe.toJson()).toList());
    // Guarda la cadena JSON en SharedPreferences bajo la clave 'recipes'.
    await prefs.setString(_recipesKey, recipesJson);
  }

  // Método para agregar una nueva receta a la lista.
  // Asigna un ID único, guarda la lista y notifica a la UI.
  void addRecipe(Recipe recipe) {
    // Genera un ID único basado en la marca de tiempo actual (en milisegundos).
    recipe.id = DateTime.now().millisecondsSinceEpoch.toString();
    // Añade la receta a la lista _recipes.
    _recipes.add(recipe);
    // Guarda la lista actualizada en SharedPreferences.
    _saveRecipes();
    // Notifica a los widgets que escuchan para que actualicen la UI (ej. mostrar la nueva receta en HomePage).
    notifyListeners();
  }

  // Método para actualizar una receta existente en la lista.
  // Reemplaza la receta antigua con la nueva, guarda los cambios y notifica a la UI.
  void updateRecipe(Recipe updatedRecipe) {
    // Busca el índice de la receta con el mismo ID en la lista _recipes.
    final index = _recipes.indexWhere((recipe) => recipe.id == updatedRecipe.id);
    // Si se encuentra la receta (índice no es -1), la reemplaza.
    if (index != -1) {
      _recipes[index] = updatedRecipe;
      // Guarda la lista actualizada en SharedPreferences.
      _saveRecipes();
      // Notifica a los widgets para que actualicen la UI con la receta modificada.
      notifyListeners();
    }
  }

  // Método para obtener una receta por su ID.
  // Devuelve la receta si se encuentra, o null si no existe.
  Recipe? getRecipeById(String id) {
    try {
      // Busca la primera receta cuyo ID coincida con el proporcionado.
      return _recipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      // Si no se encuentra la receta, devuelve null para evitar errores.
      return null;
    }
  }

  // Método para eliminar una receta por su ID.
  // Elimina la receta de la lista, guarda los cambios y notifica a la UI.
  void deleteRecipe(String id) {
    // Elimina la receta cuyo ID coincida con el proporcionado.
    _recipes.removeWhere((recipe) => recipe.id == id);
    // Guarda la lista actualizada en SharedPreferences.
    _saveRecipes();
    // Notifica a los widgets para que actualicen la UI (ej. quitar la receta de HomePage).
    notifyListeners();
  }
}
