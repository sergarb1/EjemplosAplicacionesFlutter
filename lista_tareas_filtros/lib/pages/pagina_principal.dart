import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lista_tareas_filtros/providers/tarea_provider.dart';
import 'package:lista_tareas_filtros/widgets/tarjeta_tarea.dart';
import 'package:lista_tareas_filtros/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

// Clase principal para la página inicial de la aplicación
class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  PaginaPrincipalState createState() => PaginaPrincipalState();
}

// Estado de la página principal, donde se gestiona la lógica
class PaginaPrincipalState extends State<PaginaPrincipal> {
  // Método que se ejecuta cuando las dependencias cambian
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Carga los datos iniciales desde el proveedor de tareas
    Provider.of<TareaProvider>(context, listen: false).cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene el proveedor de tareas y el tema actual
    final tareaProvider = Provider.of<TareaProvider>(context);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return CustomScaffold(
      // Barra de acciones en la parte superior
      actions: [
        // Interruptor para alternar entre tema claro y oscuro
        Switch(
          value: tareaProvider.isDarkTheme,
          onChanged: (value) {
            tareaProvider.alternarTema(value);
          },
          activeThumbColor: Theme.of(context).colorScheme.secondary,
        ),
      ],
      // Cuerpo principal de la página
      body: Column(
        children: [
          // Contenedor para los filtros de tareas
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Colors.grey[800]?.withValues(alpha:0.5) // Fondo semitransparente en modo oscuro
                : Theme.of(context).colorScheme.primaryContainer.withValues(alpha:0.5), // Fondo semitransparente en modo claro
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título de la sección de filtros
                Text(
                  'Filtrar Tareas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                // Filtro por categoría
                _buildFilterDropdown(
                  context: context,
                  value: tareaProvider.filtroCategoria,
                  items: const [
                    DropdownMenuItem(value: 'Todas', child: Text('Todas las categorías')),
                    DropdownMenuItem(value: 'General', child: Text('General')),
                    DropdownMenuItem(value: 'Trabajo', child: Text('Trabajo')),
                    DropdownMenuItem(value: 'Personal', child: Text('Personal')),
                    DropdownMenuItem(value: 'Estudio', child: Text('Estudio')),
                    DropdownMenuItem(value: 'Otro', child: Text('Otro')),
                  ],
                  hint: 'Seleccionar categoría',
                  icon: Icons.category,
                  onChanged: (value) {
                    tareaProvider.cambiarFiltroCategoria(value!);
                  },
                ),
                const SizedBox(height: 12),
                // Filtro por estado (Pendientes o Completadas)
                _buildFilterDropdown(
                  context: context,
                  value: tareaProvider.filtroEstado,
                  items: const [
                    DropdownMenuItem(value: 'Todas', child: Text('Todas las tareas')),
                    DropdownMenuItem(value: 'Pendientes', child: Text('Pendientes')),
                    DropdownMenuItem(value: 'Completadas', child: Text('Completadas')),
                  ],
                  hint: 'Seleccionar estado',
                  icon: Icons.task,
                  onChanged: (value) {
                    tareaProvider.cambiarFiltroEstado(value!);
                  },
                ),
              ],
            ),
          ),
          // Lista de tareas filtradas o mensaje si no hay tareas
          Expanded(
            child: tareaProvider.tareasFiltradas.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icono y mensaje cuando no hay tareas
                        Icon(
                          Icons.task_alt,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '¡No hay tareas! Agrega una nueva.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: tareaProvider.tareasFiltradas.length,
                    itemBuilder: (context, indice) {
                      // Construye una tarjeta para cada tarea filtrada
                      return TarjetaTarea(
                        tarea: tareaProvider.tareasFiltradas[indice],
                        indice: indice,
                      );
                    },
                  ),
          ),
        ],
      ),
      // Botón flotante para agregar nuevas tareas
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega a la página de agregar tarea
          context.push('/agregar');
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add_circle),
      ),
    );
  }

  // Widget personalizado para los dropdowns de filtro
  Widget _buildFilterDropdown({
    required BuildContext context,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required String hint,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor, // Fondo del dropdown
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha:0.3), // Borde semitransparente
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          // Icono del filtro
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true, // Ocupa todo el ancho disponible
              underline: const SizedBox(), // Elimina la línea por defecto
              borderRadius: BorderRadius.circular(12),
              dropdownColor: theme.cardColor, // Color del menú desplegable
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 14,
              ),
              items: items, // Opciones del dropdown
              onChanged: onChanged, // Acción al seleccionar una opción
              hint: Text(
                hint,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha:0.6), // Texto semitransparente
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}