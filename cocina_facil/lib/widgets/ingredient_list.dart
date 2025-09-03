// lib/widgets/ingredient_list.dart
import 'package:flutter/material.dart'; // Biblioteca principal de Flutter para widgets y temas de Material Design.

// Widget reutilizable para gestionar una lista editable de ingredientes.
// Muestra los ingredientes como "chips" (etiquetas) y permite agregar nuevos ingredientes mediante un campo de texto.
// Es un StatefulWidget porque necesita manejar cambios en la lista (estado) dinámicamente.
class IngredientList extends StatefulWidget {
  // Lista inicial de ingredientes pasada al widget. Puede ser vacía o contener ingredientes existentes.
  final List<String> initialIngredients;
  // Función callback que se ejecuta cuando la lista de ingredientes cambia.
  // Recibe la lista actualizada como parámetro para notificar a los widgets padres.
  final Function(List<String>) onChanged;

  // Constructor del widget con parámetros requeridos y una key opcional.
  const IngredientList({
    super.key, // Clave para identificar el widget en el árbol de widgets.
    required this.initialIngredients, // Lista inicial de ingredientes.
    required this.onChanged, // Callback para notificar cambios.
  });

  // Crea el estado asociado al widget. Devuelve una instancia de IngredientListState.
  @override
  IngredientListState createState() => IngredientListState();
}

// Clase de estado para IngredientList. Maneja la lógica de la lista editable y la UI.
class IngredientListState extends State<IngredientList> {
  // Lista local de ingredientes. Es una copia de initialIngredients para evitar modificar la lista original directamente.
  late List<String> _ingredients;
  // Controlador para el campo de texto donde el usuario escribe nuevos ingredientes.
  // Permite leer y limpiar el texto ingresado.
  final TextEditingController _controller = TextEditingController();

  // Método del ciclo de vida que se ejecuta al inicializar el estado del widget.
  // Configura el estado inicial antes de que el widget se muestre en pantalla.
  @override
  void initState() {
    super.initState(); // Llama al initState de la clase base.
    // Crea una copia de la lista initialIngredients para trabajar localmente.
    // Esto evita modificar la lista original pasada por el widget padre.
    _ingredients = List.from(widget.initialIngredients);
  }

  // Método para agregar un nuevo ingrediente a la lista.
  // Valida que el campo de texto no esté vacío antes de agregar.
  void _addIngredient() {
    // Verifica que el texto ingresado no esté vacío.
    if (_controller.text.isNotEmpty) {
      // setState actualiza el estado y fuerza la reconstrucción de la UI.
      setState(() {
        // Añade el texto del controlador a la lista de ingredientes.
        _ingredients.add(_controller.text);
        // Limpia el campo de texto para permitir un nuevo ingreso.
        _controller.clear();
      });
      // Llama al callback onChanged para notificar al widget padre (ej. AddEditRecipePage)
      // con la lista actualizada de ingredientes.
      widget.onChanged(_ingredients);
    }
  }

  // Método para eliminar un ingrediente de la lista según su índice.
  void _removeIngredient(int index) {
    // setState actualiza el estado y reconstruye la UI.
    setState(() {
      // Elimina el ingrediente en la posición indicada.
      _ingredients.removeAt(index);
    });
    // Notifica al widget padre con la lista actualizada.
    widget.onChanged(_ingredients);
  }

  // Método que construye la interfaz de usuario del widget.
  // Devuelve una columna con un título, chips para los ingredientes y un campo de texto con botón.
  @override
  Widget build(BuildContext context) {
    return Column(
      // Alinea los elementos a la izquierda para un diseño claro.
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título estático para la sección de ingredientes.
        const Text(
          'Ingredientes:', // Texto fijo que indica la sección.
          style: TextStyle(fontWeight: FontWeight.bold), // Estilo en negrita para destacar.
        ),
        // Wrap organiza los chips en filas, ajustándose al espacio disponible.
        // Es ideal para listas dinámicas de elementos pequeños como chips.
        Wrap(
          spacing: 8.0, // Espaciado horizontal entre chips para un diseño responsivo.
          children: _ingredients.asMap().entries.map((entry) {
            // Convierte la lista en un mapa para obtener el índice y el valor de cada ingrediente.
            int index = entry.key; // Índice del ingrediente.
            String ingredient = entry.value; // Nombre del ingrediente.
            // Crea un chip para cada ingrediente.
            return Chip(
              label: Text(ingredient), // Muestra el nombre del ingrediente.
              onDeleted: () => _removeIngredient(index), // Llama a _removeIngredient al pulsar la "X".
            );
          }).toList(), // Convierte el iterable de chips a una lista.
        ),
        // Fila que contiene el campo de texto y el botón para agregar ingredientes.
        Row(
          children: [
            // Campo de texto que ocupa el espacio disponible.
            Expanded(
              child: TextField(
                controller: _controller, // Vincula el controlador para leer el texto ingresado.
                decoration: const InputDecoration(hintText: 'Nuevo ingrediente'), // Texto de ayuda.
              ),
            ),
            // Botón de acción para agregar el ingrediente.
            IconButton(
              icon: const Icon(Icons.add), // Icono de "+" para agregar.
              onPressed: _addIngredient, // Llama a _addIngredient al pulsar.
              tooltip: 'Agregar ingrediente', // Texto para accesibilidad (lectores de pantalla).
            ),
          ],
        ),
      ],
    );
  }
}
