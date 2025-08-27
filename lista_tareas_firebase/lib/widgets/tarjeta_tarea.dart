import 'package:flutter/material.dart';
import 'package:lista_tareas_firebase/models/tarea.dart';
import 'package:lista_tareas_firebase/providers/tarea_provider.dart';
import 'package:provider/provider.dart';

// Widget reutilizable para mostrar una tarea en la lista
class TarjetaTarea extends StatelessWidget {
  final Tarea tarea; // Objeto que representa la tarea
  final int indice; // Índice de la tarea en la lista

  const TarjetaTarea({
    super.key,
    required this.tarea,
    required this.indice,
  });

  @override
  Widget build(BuildContext context) {
    // Accedemos al proveedor de tareas para manejar el estado
    final tareaProvider = Provider.of<TareaProvider>(context, listen: false);

    return Card(
      elevation: 4, // Sombra del card
      margin: const EdgeInsets.symmetric(vertical: 8), // Margen vertical
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bordes redondeados
      ),
      child: ListTile(
        // Checkbox animado para marcar como completada o no
        leading: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200), // Duración de la animación
          child: Checkbox(
            key: ValueKey<bool>(tarea.estaCompletada), // Clave para animación
            value: tarea.estaCompletada, // Estado del checkbox
            onChanged: (value) => tareaProvider.cambiarEstadoTarea(indice), // Cambiar estado
            activeColor: Theme.of(context).colorScheme.secondary, // Color activo
            checkColor: Theme.of(context).colorScheme.onSecondary, // Color del check
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4), // Bordes redondeados del checkbox
            ),
          ),
        ),
        // Título de la tarea con un ícono
        title: Row(
          children: [
            Icon(
              Icons.task, // Ícono de tarea
              color: tarea.estaCompletada
                  ? Theme.of(context).colorScheme.onSurface.withAlpha(128) // Color atenuado si está completada
                  : Theme.of(context).colorScheme.onSurface, // Color normal si no está completada
              size: 20, // Tamaño del ícono
            ),
            const SizedBox(width: 8), // Espaciado entre ícono y texto
            Expanded(
              child: Text(
                tarea.titulo, // Título de la tarea
                style: TextStyle(
                  decoration: tarea.estaCompletada ? TextDecoration.lineThrough : null, // Línea si está completada
                  color: tarea.estaCompletada
                      ? Theme.of(context).colorScheme.onSurface.withAlpha(128) // Color atenuado si está completada
                      : Theme.of(context).colorScheme.onSurface, // Color normal si no está completada
                  fontSize: 16, // Tamaño de fuente
                ),
              ),
            ),
          ],
        ),
        // Descripción de la tarea (opcional)
        subtitle: tarea.descripcion.isNotEmpty
            ? Row(
                children: [
                  Icon(
                    Icons.description_outlined, // Ícono de descripción
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(128), // Color atenuado
                    size: 20, // Tamaño del ícono
                  ),
                  const SizedBox(width: 8), // Espaciado entre ícono y texto
                  Expanded(
                    child: Text(
                      tarea.descripcion, // Descripción de la tarea
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withAlpha(128), // Color atenuado
                        fontSize: 14, // Tamaño de fuente
                      ),
                    ),
                  ),
                ],
              )
            : null, // Si no hay descripción, no se muestra nada
        // Botón para eliminar la tarea
        trailing: IconButton(
          icon: Icon(
            Icons.delete_forever, // Ícono de eliminar
            color: Theme.of(context).colorScheme.error, // Color de error
          ),
          onPressed: () => tareaProvider.eliminarTarea(indice), // Acción para eliminar la tarea
        ),
      ),
    );
  }
}