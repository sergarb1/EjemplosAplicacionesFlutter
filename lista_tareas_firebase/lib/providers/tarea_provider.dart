import 'package:flutter/material.dart';
import 'package:lista_tareas_firebase/models/tarea.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Proveedor para gestionar el estado de las tareas y el tema
class TareaProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instancia de Firestore para interactuar con la base de datos
  List<Tarea> _tareas = []; // Lista de tareas que incluye el documentId de Firestore
  bool _isDarkTheme = false; // Variable para controlar si el tema es oscuro o claro
  String _filtroCategoria = 'Todas'; // Filtro para la categoría de las tareas
  String _filtroEstado = 'Todas'; // Filtro para el estado de las tareas (Completadas o Pendientes)

  // Getter para obtener las tareas filtradas según los filtros aplicados
  List<Tarea> get tareasFiltradas {
    var filtered = _tareas;

    // Filtrar por categoría si no es "Todas"
    if (_filtroCategoria != 'Todas') {
      filtered = filtered.where((tarea) => tarea.categoria == _filtroCategoria).toList();
    }

    // Filtrar por estado (Completadas o Pendientes)
    if (_filtroEstado == 'Completadas') {
      filtered = filtered.where((tarea) => tarea.estaCompletada).toList();
    } else if (_filtroEstado == 'Pendientes') {
      filtered = filtered.where((tarea) => !tarea.estaCompletada).toList();
    }

    return filtered; // Retorna la lista filtrada
  }

  // Getters para acceder a las variables privadas
  bool get isDarkTheme => _isDarkTheme;
  String get filtroCategoria => _filtroCategoria;
  String get filtroEstado => _filtroEstado;

  // Método para cargar todas las tareas desde Firestore
  Future<void> cargarDatos() async {
    try {
      // Obtener todas las tareas de la colección "tareas"
      final snapshot = await _firestore.collection('tareas').get();
      // Mapear los documentos a objetos Tarea y asignar el documentId
      _tareas = snapshot.docs.map((doc) {
        final data = doc.data()['tarea'] as Map<String, dynamic>;
        return Tarea.fromJson(data)..documentId = doc.id;
      }).toList();
      debugPrint('Tareas cargadas: ${_tareas.length}'); // Imprimir la cantidad de tareas cargadas
      notifyListeners(); // Notificar a los widgets que escuchan cambios
    } catch (e) {
      debugPrint('Error al cargar datos: $e'); // Manejo de errores
    }
  }

  // Método para agregar una nueva tarea a Firestore
  Future<void> agregarTarea(Tarea tarea) async {
    try {
      // Crear un nuevo documento en la colección "tareas"
      final docRef = _firestore.collection('tareas').doc();
      tarea.documentId = docRef.id; // Asignar el ID del documento a la tarea
      debugPrint('Guardando tarea con ID: ${tarea.documentId}, Título: ${tarea.titulo}');
      await docRef.set({'tarea': tarea.toJson()}); // Guardar la tarea en Firestore
      _tareas.add(tarea); // Agregar la tarea a la lista local
      notifyListeners(); // Notificar cambios
    } catch (e) {
      debugPrint('Error al agregar tarea: $e'); // Manejo de errores
    }
  }

  // Método para cambiar el estado de una tarea (completada o pendiente)
  Future<void> cambiarEstadoTarea(int indice) async {
    try {
      // Verificar que el índice esté dentro del rango de la lista
      if (indice >= 0 && indice < _tareas.length) {
        final tarea = _tareas[indice];
        if (tarea.documentId == null) {
          debugPrint('Error: documentId es nulo para la tarea en índice $indice');
          return;
        }
        // Cambiar el estado de la tarea
        tarea.estaCompletada = !tarea.estaCompletada;
        debugPrint('Cambiando estado de tarea ID: ${tarea.documentId}, Nuevo estado: ${tarea.estaCompletada}');
        // Actualizar la tarea en Firestore
        await _firestore.collection('tareas').doc(tarea.documentId).set({'tarea': tarea.toJson()});
        notifyListeners(); // Notificar cambios
      } else {
        debugPrint('Índice fuera de rango: $indice'); // Manejo de errores
      }
    } catch (e) {
      debugPrint('Error al cambiar estado: $e'); // Manejo de errores
    }
  }

  // Método para eliminar una tarea de Firestore y de la lista local
  Future<void> eliminarTarea(int indice) async {
    try {
      // Verificar que el índice esté dentro del rango de la lista
      if (indice >= 0 && indice < _tareas.length) {
        final tarea = _tareas[indice];
        if (tarea.documentId == null) {
          debugPrint('Error: documentId es nulo para la tarea en índice $indice');
          return;
        }
        debugPrint('Eliminando tarea ID: ${tarea.documentId}, Título: ${tarea.titulo}');
        // Eliminar la tarea de Firestore
        await _firestore.collection('tareas').doc(tarea.documentId).delete();
        _tareas.removeAt(indice); // Eliminar la tarea de la lista local
        notifyListeners(); // Notificar cambios
      } else {
        debugPrint('Índice fuera de rango: $indice'); // Manejo de errores
      }
    } catch (e) {
      debugPrint('Error al eliminar tarea: $e'); // Manejo de errores
    }
  }

  // Método para alternar entre tema oscuro y claro
  void alternarTema(bool value) {
    _isDarkTheme = value; // Cambiar el valor del tema
    notifyListeners(); // Notificar cambios
  }

  // Método para cambiar el filtro por categoría
  void cambiarFiltroCategoria(String categoria) {
    _filtroCategoria = categoria; // Cambiar el filtro de categoría
    notifyListeners(); // Notificar cambios
  }

  // Método para cambiar el filtro por estado
  void cambiarFiltroEstado(String estado) {
    _filtroEstado = estado; // Cambiar el filtro de estado
    notifyListeners(); // Notificar cambios
  }
}