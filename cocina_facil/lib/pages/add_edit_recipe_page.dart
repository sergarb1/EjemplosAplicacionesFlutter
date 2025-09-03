// lib/pages/add_edit_recipe_page.dart
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List; // Para detectar plataforma web y manejar bytes.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Para navegación con GoRouter.
import 'package:image_picker/image_picker.dart'; // Para seleccionar imágenes.
import 'package:image/image.dart' as img; // Para redimensionar imágenes.
import 'package:path_provider/path_provider.dart'; // Para directorios temporales (nativo).
import 'package:provider/provider.dart'; // Para gestión de estado.
import '../models/recipe.dart'; // Modelo de datos para recetas.
import '../providers/recipe_provider.dart'; // Proveedor para gestionar recetas.
import '../widgets/custom_scaffold.dart'; // Scaffold personalizado con logo.

// Página para agregar o editar una receta con un diseño moderno y responsivo.
// Soporta título, tiempo, ingredientes, instrucciones y foto.
class AddEditRecipePage extends StatefulWidget {
  final String? recipeId; // ID opcional para modo edición (null para nueva receta).

  const AddEditRecipePage({super.key, this.recipeId});

  @override
  AddEditRecipePageState createState() => AddEditRecipePageState();
}

class AddEditRecipePageState extends State<AddEditRecipePage> {
  // Clave para validar el formulario de la receta.
  final _formKey = GlobalKey<FormState>();
  // Controladores para los campos de texto del título, tiempo e instrucciones.
  late TextEditingController _titleController;
  late TextEditingController _timeController;
  late TextEditingController _instructionsController;
  // Lista de controladores para los campos de ingredientes (nombre y gramos).
  final List<Map<String, TextEditingController>> _ingredientControllers = [];
  // Imagen seleccionada (File para nativo, simulado para web).
  File? _selectedImage;
  // Bytes de la imagen para visualización y almacenamiento.
  Uint8List? _imageBytes;
  // Unidad de tiempo seleccionada (Minutos o Horas).
  String _timeUnit = 'Minutos';

  @override
  void initState() {
    super.initState();
    // Obtener el proveedor de recetas para acceder a los datos.
    final provider = Provider.of<RecipeProvider>(context, listen: false);
    // Cargar la receta si está en modo edición.
    final recipe = widget.recipeId != null ? provider.getRecipeById(widget.recipeId!) : null;

    // Inicializar controladores con valores de la receta o vacíos.
    _titleController = TextEditingController(text: recipe?.title ?? '');
    _instructionsController = TextEditingController(text: recipe?.instructions ?? '');
    // Configurar el tiempo de preparación: usar horas si es divisible por 60, sino minutos.
    if (recipe != null && recipe.preparationTime >= 60 && recipe.preparationTime % 60 == 0) {
      _timeController = TextEditingController(text: (recipe.preparationTime ~/ 60).toString());
      _timeUnit = 'Horas';
    } else {
      _timeController = TextEditingController(text: recipe?.preparationTime.toString() ?? '');
      _timeUnit = 'Minutos';
    }
    // Cargar ingredientes existentes o inicializar con un campo vacío.
    if (recipe != null) {
      for (var ing in recipe.ingredients) {
        _ingredientControllers.add({
          'name': TextEditingController(text: ing.name),
          'grams': TextEditingController(text: ing.grams.toString()),
        });
      }
      // Cargar la imagen desde photoBytes.
      if (recipe.photoBytes != null) {
        _imageBytes = recipe.photoBytes;
      }
      // En nativo, intentar cargar photoPath si existe.
      if (!kIsWeb && recipe.photoPath != null && File(recipe.photoPath!).existsSync()) {
        _selectedImage = File(recipe.photoPath!);
      }
    } else {
      _ingredientControllers.add({
        'name': TextEditingController(),
        'grams': TextEditingController(),
      });
    }
  }

  // Método para agregar un nuevo campo de ingrediente dinámicamente.
  void _addIngredientField() {
    setState(() {
      _ingredientControllers.add({
        'name': TextEditingController(), // Controlador para el nombre del ingrediente.
        'grams': TextEditingController(), // Controlador para la cantidad en gramos.
      });
    });
  }

  // Método para remover un campo de ingrediente por su índice.
  void _removeIngredientField(int index) {
    setState(() {
      // Liberar controladores para evitar fugas de memoria.
      _ingredientControllers[index]['name']?.dispose();
      _ingredientControllers[index]['grams']?.dispose();
      _ingredientControllers.removeAt(index);
    });
  }

  // Método para seleccionar y redimensionar una imagen.
  Future<void> _pickImage() async {
    try {
      // Inicializar el picker de imágenes.
      final picker = ImagePicker();
      // Seleccionar una imagen desde la galería.
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      // Verificar si se seleccionó una imagen.
      if (pickedFile != null) {
        Uint8List? imageBytes;
        String? path;

        // Diferenciar entre web y plataformas nativas.
        if (kIsWeb) {
          // En web, obtener los bytes directamente.
          imageBytes = await pickedFile.readAsBytes();
        } else {
          // En nativo, obtener la ruta del archivo y leer bytes.
          path = pickedFile.path;
          imageBytes = await File(path).readAsBytes();
        }

        // Verificar que los bytes de la imagen no sean nulos.
        // Decodificar la imagen usando el paquete image.
        final image = img.decodeImage(imageBytes);
        if (image != null) {
          // Redimensionar la imagen a un ancho máximo de 800px.
          final resizedImage = img.copyResize(image, width: 800);
          // Generar bytes para la imagen redimensionada (JPG, calidad 85).
          final resizedBytes = img.encodeJpg(resizedImage, quality: 85);

          setState(() {
            _imageBytes = resizedBytes; // Guardar bytes para persistencia.
            if (!kIsWeb) {
              // En nativo, guardar la imagen redimensionada en un archivo temporal.
              final directory = getTemporaryDirectory();
              directory.then((dir) {
                final resizedPath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
                File(resizedPath).writeAsBytesSync(resizedBytes);
                setState(() {
                  _selectedImage = File(resizedPath);
                });
              });
            } else {
              _selectedImage = null; // No usar File en web.
            }
          });
        } else {
          _showErrorSnackBar('No se pudo decodificar la imagen.');
        }
            } else {
        _showErrorSnackBar('No se seleccionó ninguna imagen.');
      }
    } catch (e) {
      // Mostrar cualquier error durante la selección o procesamiento.
      _showErrorSnackBar('Error al seleccionar la imagen: $e');
    }
  }

  // Método para mostrar mensajes de error en un SnackBar.
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[400], // Color de fondo para errores.
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Método para guardar o actualizar la receta.
  void _saveRecipe() {
    // Validar el formulario antes de guardar.
    if (_formKey.currentState!.validate()) {
      // Mapear los controladores a objetos Ingredient, excluyendo nombres vacíos.
      final ingredients = _ingredientControllers
          .map((ctrl) => Ingredient(
                name: ctrl['name']!.text.trim(),
                grams: int.parse(ctrl['grams']!.text.trim()),
              ))
          .where((ing) => ing.name.isNotEmpty)
          .toList();

      // Asegurar que haya al menos un ingrediente válido.
      if (ingredients.isEmpty) {
        _showErrorSnackBar('Agrega al menos un ingrediente con nombre y cantidad');
        return;
      }

      // Convertir el tiempo a minutos (si está en horas, multiplicar por 60).
      final timeValue = int.parse(_timeController.text);
      final preparationTime = _timeUnit == 'Horas' ? timeValue * 60 : timeValue;

      // Obtener el proveedor de recetas.
      final provider = Provider.of<RecipeProvider>(context, listen: false);
      // Crear o actualizar la receta.
      final recipe = Recipe(
        title: _titleController.text,
        preparationTime: preparationTime,
        ingredients: ingredients,
        instructions: _instructionsController.text.trim().isNotEmpty ? _instructionsController.text.trim() : null,
        photoPath: !kIsWeb ? _selectedImage?.path : null, // Usar path solo en nativo.
        photoBytes: _imageBytes, // Usar bytes para persistencia.
      );

      // Modo agregar o editar según recipeId.
      if (widget.recipeId == null) {
        provider.addRecipe(recipe);
      } else {
        recipe.id = widget.recipeId!;
        provider.updateRecipe(recipe);
      }

      // Navegar a la página principal después de guardar.
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título de la página dentro del formulario.
                  Text(
                    widget.recipeId == null ? 'Agregar Receta' : 'Editar Receta',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                  // Campo para el título de la receta.
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Título de la Receta',
                      prefixIcon: Icon(Icons.restaurant_menu, color: Colors.orange[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) => value!.isEmpty ? 'Ingresa un título' : null,
                  ),
                  const SizedBox(height: 20),
                  // Campo para el tiempo de preparación con selector de unidad.
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _timeController,
                          decoration: InputDecoration(
                            labelText: 'Tiempo de Preparación',
                            prefixIcon: Icon(Icons.timer, color: Colors.orange[700]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) return 'Ingresa el tiempo';
                            final numValue = int.tryParse(value);
                            if (numValue == null || numValue <= 0) return 'Debe ser un número positivo';
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _timeUnit,
                        items: ['Minutos', 'Horas'].map((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Text(
                              unit,
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _timeUnit = value!;
                          });
                        },
                        style: TextStyle(color: Colors.orange[800]),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        underline: Container(
                          height: 2,
                          color: Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Sección para gestionar ingredientes.
                  Text(
                    'Ingredientes',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  // Lista dinámica de campos para ingredientes.
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _ingredientControllers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _ingredientControllers[index]['name'],
                                decoration: InputDecoration(
                                  labelText: 'Ingrediente ${index + 1}',
                                  prefixIcon: Icon(Icons.local_dining, color: Colors.orange[700]),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) => value!.isEmpty ? 'Ingresa el nombre' : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _ingredientControllers[index]['grams'],
                                decoration: InputDecoration(
                                  labelText: 'Gramos',
                                  prefixIcon: Icon(Icons.scale, color: Colors.orange[700]),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) return 'Ingresa la cantidad';
                                  final numValue = int.tryParse(value);
                                  if (numValue == null || numValue <= 0) return 'Debe ser un número positivo';
                                  return null;
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red[400]),
                              onPressed: () => _removeIngredientField(index),
                              tooltip: 'Eliminar ingrediente',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Botón para agregar un nuevo ingrediente.
                  TextButton.icon(
                    onPressed: _addIngredientField,
                    icon: Icon(Icons.add_circle, color: Colors.orange[700]),
                    label: Text(
                      'Agregar Ingrediente',
                      style: TextStyle(color: Colors.orange[700], fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Sección para instrucciones de elaboración.
                  Text(
                    'Instrucciones de Elaboración (Opcional)',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _instructionsController,
                    decoration: InputDecoration(
                      labelText: 'Instrucciones',
                      prefixIcon: Icon(Icons.description, color: Colors.orange[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    maxLines: 5,
                    minLines: 3,
                  ),
                  const SizedBox(height: 24),
                  // Sección para subir una foto opcional.
                  Text(
                    'Foto (Opcional)',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  // Vista previa de la imagen seleccionada con animación, tamaño reducido.
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _imageBytes != null
                        ? ClipRRect(
                            key: ValueKey(_imageBytes),
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              _imageBytes!,
                              height: 120, // Reducido de 200px a 120px.
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                            ),
                          )
                        : _buildPlaceholder(),
                  ),
                  const SizedBox(height: 12),
                  // Botón para seleccionar o cambiar la foto.
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: _pickImage,
                      icon: Icon(Icons.image, color: Colors.orange[700]),
                      label: Text(
                        _imageBytes == null ? 'Seleccionar Foto' : 'Cambiar Foto',
                        style: TextStyle(color: Colors.orange[700], fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.orange[700]!, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Botón para guardar la receta.
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveRecipe,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                      ),
                      child: Text(
                        widget.recipeId == null ? 'Agregar Receta' : 'Actualizar Receta',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget para mostrar un placeholder si no hay imagen o hay error.
  Widget _buildPlaceholder() {
    return Container(
      key: const ValueKey('no_image'),
      height: 120, // Reducido de 200px a 120px.
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.image, size: 40, color: Colors.grey[600]), // Icono más pequeño.
    );
  }

  @override
  void dispose() {
    // Liberar recursos para evitar fugas de memoria.
    _titleController.dispose();
    _timeController.dispose();
    _instructionsController.dispose();
    for (var ctrl in _ingredientControllers) {
      ctrl['name']?.dispose();
      ctrl['grams']?.dispose();
    }
    super.dispose();
  }
}
