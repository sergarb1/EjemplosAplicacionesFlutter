import 'package:flutter/material.dart';
import 'package:lista_tareas_simple/models/tarea.dart';

// Widget reutilizable para mostrar una tarea en la lista
class TarjetaTarea extends StatelessWidget {
  final Tarea tarea; // La tarea a mostrar
  final VoidCallback onCambiarEstado; // Función para cambiar el estado
  final VoidCallback onEliminar; // Función para eliminar la tarea

  const TarjetaTarea({
    super.key,
    required this.tarea,
    required this.onCambiarEstado,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Sombra para profundidad
      margin: const EdgeInsets.symmetric(vertical: 8), // Margen vertical
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bordes redondeados
      ),
      child: ListTile(
        // Animación para la casilla de verificación
        leading: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Checkbox(
            key: ValueKey<bool>(tarea.estaCompletada),
            value: tarea.estaCompletada,
            onChanged: (valor) => onCambiarEstado(),
            activeColor: const Color(0xFFF5A623), // Color secundario amarillo
            checkColor: const Color(0xFFF5F7FA), // Color del check
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        // Título con ícono
        title: Row(
          children: [
            Icon(
              Icons.task,
              color: tarea.estaCompletada
                  ? const Color(0xFFA0AEC0) // Gris medio para completadas
                  : const Color(0xFF2D3748), // Texto oscuro
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                tarea.titulo,
                style: TextStyle(
                  decoration:
                      tarea.estaCompletada ? TextDecoration.lineThrough : null,
                  color: tarea.estaCompletada
                      ? const Color(0xFFA0AEC0) // Gris medio
                      : const Color(0xFF2D3748), // Texto oscuro
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        // Descripción con ícono, si existe
        subtitle: tarea.descripcion.isNotEmpty
            ? Row(
                children: [
                  const Icon(
                    Icons.description_outlined,
                    color: Color(0xFFA0AEC0), // Gris medio
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tarea.descripcion,
                      style: const TextStyle(
                        color: Color(0xFFA0AEC0), // Gris medio
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )
            : null,
        // Botón para eliminar con ícono animado
        trailing: IconButton(
          icon: const Icon(
            Icons.delete_forever,
            color: Color(0xFFE53E3E), // Rojo suave para eliminar
          ),
          onPressed: onEliminar,
        ),
      ),
    );
  }
}