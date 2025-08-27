// Importa el framework de pruebas de Flutter
import 'package:flutter_test/flutter_test.dart';
// Importa el modelo Tarea que vamos a probar
import 'package:lista_tareas_filtros/models/tarea.dart';

// Función principal donde se definen las pruebas
void main() {
  // Grupo de pruebas para la clase Tarea
  group('Pruebas de la clase Tarea', () {
    // Prueba 1: Verifica la creación de una tarea con título
    test('Debe crear una tarea con título y valores por defecto', () {
      // Crea una nueva tarea con solo el título
      final tarea = Tarea(titulo: 'Estudiar Flutter');

      // Verifica que el título sea correcto
      expect(tarea.titulo, 'Estudiar Flutter');
      // Verifica que la descripción sea vacía por defecto
      expect(tarea.descripcion, '');
      // Verifica que estaCompletada sea false por defecto
      expect(tarea.estaCompletada, false);
    });

    // Prueba 2: Verifica la creación de una tarea con título y descripción
    test('Debe crear una tarea con título y descripción', () {
      // Crea una tarea con título y descripción
      final tarea = Tarea(
        titulo: 'Hacer tarea',
        descripcion: 'Completar ejercicios de matemáticas',
      );

      // Verifica que el título sea correcto
      expect(tarea.titulo, 'Hacer tarea');
      // Verifica que la descripción sea correcta
      expect(tarea.descripcion, 'Completar ejercicios de matemáticas');
      // Verifica que estaCompletada sea false por defecto
      expect(tarea.estaCompletada, false);
    });

    // Prueba 3: Verifica la creación de una tarea completada
    test('Debe crear una tarea con estado completada', () {
      // Crea una tarea con estaCompletada en true
      final tarea = Tarea(
        titulo: 'Comprar víveres',
        estaCompletada: true,
      );

      // Verifica que el título sea correcto
      expect(tarea.titulo, 'Comprar víveres');
      // Verifica que estaCompletada sea true
      expect(tarea.estaCompletada, true);
      // Verifica que la descripción sea vacía por defecto
      expect(tarea.descripcion, '');
    });
  });
}