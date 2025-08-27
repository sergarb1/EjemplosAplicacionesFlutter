import 'package:flutter/material.dart';
import 'package:lista_tareas_firebase/models/tarea.dart';
import 'package:lista_tareas_firebase/providers/tarea_provider.dart';
import 'package:lista_tareas_firebase/widgets/custom_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Clase principal de la página para agregar una nueva tarea
class PaginaAgregarTarea extends StatefulWidget {
  const PaginaAgregarTarea({super.key});

  @override
  PaginaAgregarTareaState createState() => PaginaAgregarTareaState();
}

class PaginaAgregarTareaState extends State<PaginaAgregarTarea> {
  // Controladores para los campos de texto (título y descripción)
  final TextEditingController _controladorTitulo = TextEditingController();
  final TextEditingController _controladorDescripcion = TextEditingController();

  // Variable para almacenar la categoría seleccionada
  String _categoriaSeleccionada = 'General';

  @override
  void dispose() {
    // Liberar los recursos de los controladores cuando el widget se destruye
    _controladorTitulo.dispose();
    _controladorDescripcion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el proveedor de tareas para agregar nuevas tareas
    final tareaProvider = Provider.of<TareaProvider>(context, listen: false);

    // Obtener el tema actual (claro u oscuro)
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado que indica que se está creando una nueva tarea
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.grey[800]?.withValues(alpha:0.5) // Fondo semitransparente en modo oscuro
                    : Theme.of(context).colorScheme.primaryContainer.withValues(alpha:0.5), // Fondo semitransparente en modo claro
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
              ),
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Icono de agregar tarea
                      Icon(
                        Icons.add_circle_outline,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      // Título del encabezado
                      Text(
                        'Crear Nueva Tarea',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Subtítulo del encabezado
                  Text(
                    'Completa todos los campos para agregar una nueva tarea',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withValues(alpha:0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Campo de texto para el título de la tarea
            TextField(
              controller: _controladorTitulo, // Controlador para manejar el texto ingresado
              decoration: InputDecoration(
                labelText: 'Título de la tarea', // Etiqueta del campo
                hintText: 'Ej: Reunión con el equipo', // Texto de ejemplo
                prefixIcon: Icon(Icons.title, color: theme.colorScheme.secondary), // Icono al inicio del campo
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)), // Bordes redondeados
                ),
                filled: true,
                fillColor: theme.colorScheme.surface, // Fondo del campo
                labelStyle: TextStyle(color: theme.colorScheme.onSurface), // Estilo de la etiqueta
              ),
            ),
            const SizedBox(height: 16),

            // Campo de texto para la descripción de la tarea (opcional)
            TextField(
              controller: _controladorDescripcion, // Controlador para manejar el texto ingresado
              decoration: InputDecoration(
                labelText: 'Descripción (opcional)', // Etiqueta del campo
                hintText: 'Ej: Preparar presentación para la reunión', // Texto de ejemplo
                prefixIcon: Icon(Icons.description, color: theme.colorScheme.secondary), // Icono al inicio del campo
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)), // Bordes redondeados
                ),
                filled: true,
                fillColor: theme.colorScheme.surface, // Fondo del campo
                labelStyle: TextStyle(color: theme.colorScheme.onSurface), // Estilo de la etiqueta
              ),
              maxLines: 3, // Permitir varias líneas para la descripción
            ),
            const SizedBox(height: 16),

            // Menú desplegable para seleccionar la categoría de la tarea
            DropdownButtonFormField<String>(
              initialValue: _categoriaSeleccionada, // Valor inicial del menú desplegable
              decoration: InputDecoration(
                labelText: 'Categoría', // Etiqueta del menú
                prefixIcon: Icon(Icons.category, color: theme.colorScheme.secondary), // Icono al inicio del menú
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)), // Bordes redondeados
                ),
                filled: true,
                fillColor: theme.colorScheme.surface, // Fondo del menú
              ),
              items: const [
                // Opciones del menú desplegable
                DropdownMenuItem(value: 'General', child: Text('General')),
                DropdownMenuItem(value: 'Trabajo', child: Text('Trabajo')),
                DropdownMenuItem(value: 'Personal', child: Text('Personal')),
                DropdownMenuItem(value: 'Estudio', child: Text('Estudio')),
                DropdownMenuItem(value: 'Otro', child: Text('Otro')),
              ],
              onChanged: (value) {
                // Actualizar la categoría seleccionada
                setState(() {
                  _categoriaSeleccionada = value!;
                });
              },
            ),
            const SizedBox(height: 24),

            // Botón para crear la tarea
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Validar que el título no esté vacío
                  if (_controladorTitulo.text.isNotEmpty) {
                    final nuevaTarea = Tarea(
                      titulo: _controladorTitulo.text, // Título ingresado
                      descripcion: _controladorDescripcion.text, // Descripción ingresada
                      categoria: _categoriaSeleccionada, // Categoría seleccionada
                    );
                    try {
                      // Intentar agregar la tarea usando el proveedor
                      await tareaProvider.agregarTarea(nuevaTarea);
                      // Mostrar mensaje de éxito
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.check, color: theme.colorScheme.onSurface),
                              const SizedBox(width: 8),
                              const Text('Tarea creada exitosamente'),
                            ],
                          ),
                          backgroundColor: theme.colorScheme.primary,
                        ),
                      );
                      context.pop(); // Volver a la pantalla anterior
                    } catch (e) {
                      // Mostrar mensaje de error si ocurre un problema
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.error, color: theme.colorScheme.onError),
                              const SizedBox(width: 8),
                              Text('Error al crear tarea: $e'),
                            ],
                          ),
                          backgroundColor: theme.colorScheme.error,
                        ),
                      );
                    }
                  } else {
                    // Mostrar mensaje de advertencia si el título está vacío
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.warning, color: theme.colorScheme.onError),
                            const SizedBox(width: 8),
                            const Text('El título es obligatorio'),
                          ],
                        ),
                        backgroundColor: theme.colorScheme.error,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.add_task), // Icono del botón
                label: const Text('Crear Tarea'), // Texto del botón
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary, // Color de fondo del botón
                  foregroundColor: theme.colorScheme.onSecondary, // Color del texto del botón
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Espaciado interno
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Estilo del texto
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}