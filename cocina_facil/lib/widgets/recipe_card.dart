// lib/widgets/recipe_card.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

// Widget que muestra una tarjeta de receta compacta con título, tiempo, instrucciones y foto.
class RecipeCard extends StatelessWidget {
  final Recipe recipe; // Receta a mostrar.

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => context.go('/edit-recipe/${recipe.id}'), // Navega a la página de edición.
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la receta o placeholder, con tamaño reducido.
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 120, // Reducido de 120px a 80px para tarjetas más pequeñas.
                width: double.infinity,
                child: recipe.photoBytes != null
                    ? Image.memory(
                        recipe.photoBytes!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0), // Reducido de 8px para mayor compacidad.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título de la receta.
                  Text(
                    recipe.title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Tiempo de preparación.
                  Text(
                    'Tiempo: ${recipe.preparationTime >= 60 && recipe.preparationTime % 60 == 0 ? "${recipe.preparationTime ~/ 60} h" : "${recipe.preparationTime} min"}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  // Instrucciones de elaboración (truncadas).
                  Text(
                    recipe.instructions?.isNotEmpty == true ? recipe.instructions! : 'Sin instrucciones',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // Botón para eliminar la receta.
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red[400], size: 20),
                      onPressed: () {
                        Provider.of<RecipeProvider>(context, listen: false).deleteRecipe(recipe.id!);
                      },
                      tooltip: 'Eliminar receta',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar un placeholder si no hay imagen o hay error.
  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Icon(Icons.image, size: 40, color: Colors.grey[600]),
    );
  }
}
