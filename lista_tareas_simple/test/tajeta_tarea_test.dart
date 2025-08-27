import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_tareas_simple/models/tarea.dart';
import 'package:lista_tareas_simple/widgets/tarjeta_tarea.dart';

// Función principal donde se definen las pruebas
void main() {
  // Grupo de pruebas para el widget TarjetaTarea
  group('Pruebas del widget TarjetaTarea', () {
    // Prueba 1: Verifica que el widget muestra el título y la descripción
    testWidgets('Debe mostrar el título y la descripción de la tarea', (WidgetTester tester) async {
      // Crea una tarea de prueba
      final tarea = Tarea(
        titulo: 'Estudiar Flutter',
        descripcion: 'Aprender sobre widgets',
      );

      // Construye el widget TarjetaTarea dentro de un entorno de prueba
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TarjetaTarea(
              tarea: tarea,
              onCambiarEstado: () {}, // Callback vacío para la prueba
              onEliminar: () {}, // Callback vacío para la prueba
            ),
          ),
        ),
      );

      // Verifica que el título se muestra en la pantalla
      expect(find.text('Estudiar Flutter'), findsOneWidget);
      // Verifica que la descripción se muestra en la pantalla
      expect(find.text('Aprender sobre widgets'), findsOneWidget);
      // Verifica que la casilla de verificación está presente
      expect(find.byType(Checkbox), findsOneWidget);
      // Verifica que el botón de eliminar (ícono) está presente
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    // Prueba 2: Verifica que el título se muestra tachado si la tarea está completada
    testWidgets('Debe mostrar el título tachado si la tarea está completada', (WidgetTester tester) async {
      // Crea una tarea completada
      final tarea = Tarea(
        titulo: 'Tarea completada',
        estaCompletada: true,
      );

      // Construye el widget TarjetaTarea
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TarjetaTarea(
              tarea: tarea,
              onCambiarEstado: () {},
              onEliminar: () {},
            ),
          ),
        ),
      );

      // Encuentra el widget Text que contiene el título
      final textWidget = tester.widget<Text>(find.text('Tarea completada'));

      // Verifica que el título tiene el estilo de tachado
      expect(textWidget.style?.decoration, TextDecoration.lineThrough);
      // Verifica que la casilla está marcada
      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, true);
    });

    // Prueba 3: Verifica que el callback onCambiarEstado se ejecuta al tocar la casilla
    testWidgets('Debe ejecutar el callback al tocar la casilla', (WidgetTester tester) async {
      // Variable para rastrear si el callback fue llamado
      bool callbackLlamado = false;

      // Crea una tarea de prueba
      final tarea = Tarea(titulo: 'Tarea de prueba');

      // Construye el widget TarjetaTarea
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TarjetaTarea(
              tarea: tarea,
              onCambiarEstado: () {
                callbackLlamado = true; // Marca que el callback fue llamado
              },
              onEliminar: () {},
            ),
          ),
        ),
      );

      // Simula un toque en la casilla de verificación
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      // Verifica que el callback fue llamado
      expect(callbackLlamado, true);
    });

    // Prueba 4: Verifica que el callback onEliminar se ejecuta al tocar el botón de eliminar
    testWidgets('Debe ejecutar el callback al tocar el botón de eliminar', (WidgetTester tester) async {
      // Variable para rastrear si el callback fue llamado
      bool callbackLlamado = false;

      // Crea una tarea de prueba
      final tarea = Tarea(titulo: 'Tarea de prueba');

      // Construye el widget TarjetaTarea
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TarjetaTarea(
              tarea: tarea,
              onCambiarEstado: () {},
              onEliminar: () {
                callbackLlamado = true; // Marca que el callback fue llamado
              },
            ),
          ),
        ),
      );

      // Simula un toque en el botón de eliminar
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      // Verifica que el callback fue llamado
      expect(callbackLlamado, true);
    });
  });
}