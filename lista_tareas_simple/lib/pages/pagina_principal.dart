import 'package:flutter/material.dart';
import 'package:lista_tareas_simple/models/tarea.dart';
import 'package:lista_tareas_simple/routes/rutas.dart';
import 'package:lista_tareas_simple/widgets/tarjeta_tarea.dart';
import 'package:lista_tareas_simple/widgets/logo.dart';

// Clase principal para la página inicial de la aplicación
class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  PaginaPrincipalState createState() => PaginaPrincipalState();
}

// Estado de la página principal, donde se gestiona la lógica
class PaginaPrincipalState extends State<PaginaPrincipal> {
  // Lista que almacena todas las tareas
  final List<Tarea> _tareas = [];

  // Método para agregar una nueva tarea a la lista
  void _agregarTarea(Tarea tarea) {
    setState(() {
      // Actualiza el estado para añadir la tarea a la lista
      _tareas.add(tarea);
    });
  }

  // Método para cambiar el estado de una tarea (completada/no completada)
  void _cambiarEstadoTarea(int indice) {
    setState(() {
      // Cambia el valor de estaCompletada de la tarea seleccionada
      _tareas[indice].estaCompletada = !_tareas[indice].estaCompletada;
    });
  }

  // Método para eliminar una tarea de la lista
  void _eliminarTarea(int indice) {
    setState(() {
      // Elimina la tarea en la posición indicada
      _tareas.removeAt(indice);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold proporciona la estructura básica de la página
    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        title: const Logo(), // Usa el widget Logo como título
        centerTitle: true, // Centra el logo en el AppBar
        backgroundColor: const Color(0xFF4A90E2), // Color principal azul
        elevation: 0, // Sin sombra para un diseño limpio
      ),
      // Cuerpo de la página
      body: _tareas.isEmpty
          ? Center(
              // Muestra un mensaje con ícono si no hay tareas
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.task_alt,
                    color: Color(0xFFF5A623), // Color secundario amarillo
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '¡No hay tareas! Agrega una nueva.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF2D3748), // Texto oscuro
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              // Construye una lista dinámica de tareas
              padding: const EdgeInsets.all(16.0), // Margen interno
              itemCount: _tareas.length, // Número total de tareas
              itemBuilder: (context, indice) {
                // Crea un widget TarjetaTarea para cada tarea
                return TarjetaTarea(
                  tarea: _tareas[indice],
                  onCambiarEstado: () => _cambiarEstadoTarea(indice),
                  onEliminar: () => _eliminarTarea(indice),
                );
              },
            ),
      // Botón flotante para agregar una nueva tarea
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navega a la página de agregar tareas usando la ruta definida
          final nuevaTarea = await Navigator.pushNamed(
            context,
            Rutas.paginaAgregarTareas, // Ruta definida en rutas.dart
          );
          // Si se retorna una tarea válida, la agrega
          if (nuevaTarea != null) {
            _agregarTarea(nuevaTarea as Tarea);
          }
        },
        backgroundColor: const Color(0xFFF5A623), // Color secundario amarillo
        child: const Icon(Icons.add_circle), // Ícono moderno
      ),
    );
  }
}