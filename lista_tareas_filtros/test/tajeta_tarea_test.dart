import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_tareas_filtros/models/tarea.dart';
import 'package:lista_tareas_filtros/providers/tarea_provider.dart';
import 'package:lista_tareas_filtros/widgets/tarjeta_tarea.dart';
import 'package:provider/provider.dart';

void main() {
  // Agrupamos las pruebas relacionadas con el widget `TarjetaTarea`
  group('TarjetaTarea Widget Tests', () {
    // Configuración inicial antes de cada prueba
    setUp(() {
      // Inicializamos el entorno de pruebas de Flutter
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    // Prueba para verificar que el widget muestra correctamente los datos de la tarea
    testWidgets('Muestra título, descripción, iconos y checkbox', (WidgetTester tester) async {
      // Creamos una tarea de ejemplo
      final tarea = Tarea(titulo: 'Estudiar Flutter', descripcion: 'Aprender sobre widgets');
      final provider = TareaProvider();
      
      // Agregamos la tarea al provider para que esté disponible en el widget
      provider.agregarTarea(tarea);

      // Renderizamos el widget `TarjetaTarea` dentro de un `ChangeNotifierProvider`
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: MaterialApp(
            home: Scaffold(
              body: TarjetaTarea(tarea: tarea, indice: 0),
            ),
          ),
        ),
      );

      // Verificamos que los elementos esperados se muestran en pantalla
      expect(find.text('Estudiar Flutter'), findsOneWidget); // Título
      expect(find.text('Aprender sobre widgets'), findsOneWidget); // Descripción
      expect(find.byType(Checkbox), findsOneWidget); // Checkbox
      expect(find.byIcon(Icons.delete_forever), findsOneWidget); // Icono de eliminar
      expect(find.byIcon(Icons.task), findsOneWidget); // Icono de tarea
      expect(find.byIcon(Icons.description_outlined), findsOneWidget); // Icono de descripción
    });

    // Prueba para verificar que el título aparece tachado si la tarea está completada
    testWidgets('Título tachado si tarea completada', (WidgetTester tester) async {
      // Creamos una tarea marcada como completada
      final tarea = Tarea(titulo: 'Completada', descripcion: 'Desc', estaCompletada: true);
      final provider = TareaProvider();
      provider.agregarTarea(tarea);

      // Renderizamos el widget
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: MaterialApp(
            home: Scaffold(
              body: TarjetaTarea(tarea: tarea, indice: 0),
            ),
          ),
        ),
      );

      // Verificamos que el título tiene un estilo tachado
      final textWidget = tester.widget<Text>(find.text('Completada'));
      expect(textWidget.style?.decoration, TextDecoration.lineThrough);
      
      // Verificamos que el checkbox está marcado
      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, true);
    });

    // Prueba para verificar que el callback `cambiarEstadoTarea` se ejecuta al tocar el checkbox
    testWidgets('Callback cambiarEstadoTarea se ejecuta al tocar checkbox', (WidgetTester tester) async {
      // Creamos una tarea no completada
      final tarea = Tarea(titulo: 'Prueba', estaCompletada: false);
      final provider = TareaProvider();
      provider.agregarTarea(tarea);

      // Renderizamos el widget
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: MaterialApp(
            home: Scaffold(
              body: TarjetaTarea(tarea: tarea, indice: 0),
            ),
          ),
        ),
      );

      // Verificamos que inicialmente la tarea no está completada
      expect(provider.tareasFiltradas[0].estaCompletada, false);
      
      // Simulamos un toque en el checkbox
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      // Verificamos que el estado de la tarea cambió a completada
      expect(provider.tareasFiltradas[0].estaCompletada, true);
    });

    // Prueba para verificar que el callback `eliminarTarea` se ejecuta al tocar el botón de eliminar
    testWidgets('Callback eliminarTarea se ejecuta al tocar el botón eliminar', (WidgetTester tester) async {
      // Creamos una tarea de ejemplo
      final tarea = Tarea(titulo: 'Eliminar');
      final provider = TareaProvider();
      provider.agregarTarea(tarea);

      // Renderizamos el widget
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: MaterialApp(
            home: Scaffold(
              body: TarjetaTarea(tarea: tarea, indice: 0),
            ),
          ),
        ),
      );

      // Verificamos que inicialmente hay una tarea en la lista
      expect(provider.tareasFiltradas.length, 1);
      
      // Simulamos un toque en el icono de eliminar
      await tester.tap(find.byIcon(Icons.delete_forever));
      await tester.pump();

      // Verificamos que la tarea fue eliminada
      expect(provider.tareasFiltradas.isEmpty, true);
    });

    // Prueba adicional para verificar que el filtrado de tareas funciona correctamente
    testWidgets('Funciona correctamente con tareas filtradas', (WidgetTester tester) async {
      // Creamos dos tareas con diferentes categorías
      final tareaTrabajo = Tarea(titulo: 'Trabajo', categoria: 'Trabajo');
      final tareaPersonal = Tarea(titulo: 'Personal', categoria: 'Personal');
      final provider = TareaProvider();
      
      // Agregamos ambas tareas al provider
      provider.agregarTarea(tareaTrabajo);
      provider.agregarTarea(tareaPersonal);
      
      // Cambiamos el filtro del provider para mostrar solo tareas de la categoría "Trabajo"
      provider.cambiarFiltroCategoria('Trabajo');
      
      // Renderizamos el widget con la tarea filtrada
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: MaterialApp(
            home: Scaffold(
              body: TarjetaTarea(tarea: tareaTrabajo, indice: 0),
            ),
          ),
        ),
      );

      // Verificamos que solo se muestra la tarea de la categoría "Trabajo"
      expect(find.text('Trabajo'), findsOneWidget);
      expect(find.text('Personal'), findsNothing);
    });
  });
}