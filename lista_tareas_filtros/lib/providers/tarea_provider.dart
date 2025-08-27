import 'package:flutter/material.dart';
import 'package:lista_tareas_filtros/models/tarea.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Proveedor para gestionar el estado de las tareas y el tema
class TareaProvider with ChangeNotifier {
  // Lista de tareas
  List<Tarea> _tareas = [];
  
  // Variable para almacenar si el tema oscuro está activado
  bool _isDarkTheme = false;
  
  // Filtro por categoría, por defecto 'Todas'
  String _filtroCategoria = 'Todas';
  
  // Filtro por estado (Completadas o Pendientes), por defecto 'Todas'
  String _filtroEstado = 'Todas';

  // Getter que devuelve las tareas filtradas según los filtros aplicados
  List<Tarea> get tareasFiltradas {
    // Primero se filtran las tareas por categoría
    List<Tarea> tareasFiltradas = _tareas;
    
    if (_filtroCategoria != 'Todas') {
      tareasFiltradas = tareasFiltradas.where((tarea) => tarea.categoria == _filtroCategoria).toList();
    }
    
    // Luego se filtran las tareas por estado (Completadas o Pendientes)
    if (_filtroEstado != 'Todas') {
      if (_filtroEstado == 'Completadas') {
        tareasFiltradas = tareasFiltradas.where((tarea) => tarea.estaCompletada).toList();
      } else if (_filtroEstado == 'Pendientes') {
        tareasFiltradas = tareasFiltradas.where((tarea) => !tarea.estaCompletada).toList();
      }
    }
    
    return tareasFiltradas;
  }

  // Getter para saber si el tema oscuro está activado
  bool get isDarkTheme => _isDarkTheme;

  // Getter para obtener el filtro de categoría actual
  String get filtroCategoria => _filtroCategoria;

  // Getter para obtener el filtro de estado actual
  String get filtroEstado => _filtroEstado;

  // Método para cargar las tareas y el tema desde SharedPreferences
  Future<void> cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Cargar las tareas desde SharedPreferences
    _tareas = (prefs.getStringList('tareas') ?? [])
        .map((json) => Tarea.fromJson(json))
        .toList();
    
    // Cargar el estado del tema oscuro desde SharedPreferences
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    
    // Notificar a los widgets que dependen de este proveedor
    notifyListeners();
  }

  // Método para guardar las tareas y el tema en SharedPreferences
  Future<void> guardarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Guardar las tareas en SharedPreferences
    await prefs.setStringList(
      'tareas',
      _tareas.map((tarea) => tarea.toJson()).toList(),
    );
    
    // Guardar el estado del tema oscuro en SharedPreferences
    await prefs.setBool('isDarkTheme', _isDarkTheme);
  }

  // Método para agregar una nueva tarea
  void agregarTarea(Tarea tarea) {
    _tareas.add(tarea); // Añadir la tarea a la lista
    guardarDatos(); // Guardar los cambios en SharedPreferences
    notifyListeners(); // Notificar a los widgets que dependen de este proveedor
  }

  // Método para cambiar el estado de una tarea (completada o pendiente)
  void cambiarEstadoTarea(int indice) {
    _tareas[indice].estaCompletada = !_tareas[indice].estaCompletada; // Alternar el estado
    guardarDatos(); // Guardar los cambios en SharedPreferences
    notifyListeners(); // Notificar a los widgets que dependen de este proveedor
  }

  // Método para eliminar una tarea
  void eliminarTarea(int indice) {
    _tareas.removeAt(indice); // Eliminar la tarea de la lista
    guardarDatos(); // Guardar los cambios en SharedPreferences
    notifyListeners(); // Notificar a los widgets que dependen de este proveedor
  }

  // Método para alternar entre tema claro y oscuro
  void alternarTema(bool value) {
    _isDarkTheme = value; // Cambiar el estado del tema
    guardarDatos(); // Guardar los cambios en SharedPreferences
    notifyListeners(); // Notificar a los widgets que dependen de este proveedor
  }

  // Método para cambiar el filtro por categoría
  void cambiarFiltroCategoria(String categoria) {
    _filtroCategoria = categoria; // Cambiar el filtro de categoría
    notifyListeners(); // Notificar a los widgets que dependen de este proveedor
  }

  // Método para cambiar el filtro por estado (Completadas o Pendientes)
  void cambiarFiltroEstado(String estado) {
    _filtroEstado = estado; // Cambiar el filtro de estado
    notifyListeners(); // Notificar a los widgets que dependen de este proveedor
  }
}