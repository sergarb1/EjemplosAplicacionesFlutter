import 'package:flutter/material.dart';
import 'package:lista_tareas_simple/models/tarea.dart';
import 'package:lista_tareas_simple/widgets/logo.dart';

// Clase para la página donde se agrega una nueva tarea
class PaginaAgregarTarea extends StatelessWidget {
  // Controladores para capturar el texto ingresado por el usuario
  final TextEditingController _controladorTitulo = TextEditingController();
  final TextEditingController _controladorDescripcion = TextEditingController();

  PaginaAgregarTarea({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior de la página
      appBar: AppBar(
        title: const Logo(), // Usa el widget Logo como título
        centerTitle: true, // Centra el logo en el AppBar
        backgroundColor: const Color(0xFF4A90E2), // Color principal azul
      ),
      // Cuerpo de la página
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Margen interno
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de texto para el título con ícono
            TextField(
              controller: _controladorTitulo,
              decoration: const InputDecoration(
                labelText: 'Título',
                prefixIcon: Icon(Icons.task_alt, color: Color(0xFFF5A623)), // Ícono amarillo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)), // Bordes redondeados
                ),
                filled: true,
                fillColor: Color(0xFFFFFFFF), // Fondo blanco
                labelStyle: TextStyle(color: Color(0xFF2D3748)), // Texto oscuro
              ),
            ),
            const SizedBox(height: 16), // Espacio vertical
            // Campo de texto para la descripción con ícono
            TextField(
              controller: _controladorDescripcion,
              decoration: const InputDecoration(
                labelText: 'Descripción (opcional)',
                prefixIcon: Icon(Icons.description, color: Color(0xFFF5A623)), // Ícono amarillo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)), // Bordes redondeados
                ),
                filled: true,
                fillColor: Color(0xFFFFFFFF), // Fondo blanco
                labelStyle: TextStyle(color: Color(0xFF2D3748)), // Texto oscuro
              ),
              maxLines: 3, // Permite varias líneas
            ),
            const SizedBox(height: 20), // Espacio vertical
            // Botón centrado para agregar la tarea
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Verifica que el título no esté vacío
                  if (_controladorTitulo.text.isNotEmpty) {
                    // Retorna una nueva tarea al cerrar la página
                    Navigator.pop(
                      context,
                      Tarea(
                        titulo: _controladorTitulo.text,
                        descripcion: _controladorDescripcion.text,
                      ),
                    );
                  } else {
                    // Muestra un mensaje de error si el título está vacío
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: const [
                            Icon(Icons.warning, color: Color(0xFF2D3748)),
                            SizedBox(width: 8),
                            Text('El título es obligatorio'),
                          ],
                        ),
                        backgroundColor: const Color(0xFFE53E3E), // Color rojo suave
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.add_task), // Ícono para el botón
                label: const Text('Agregar Tarea'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5A623), // Color secundario amarillo
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}