
// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/recipe_card.dart';

// Página principal que muestra la lista de recetas con un diseño moderno.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Calcular el número de columnas según el ancho de pantalla para responsividad.
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : (screenWidth > 400 ? 2 : 1));

    return CustomScaffold(
      // Mostrar botón de volver solo si es necesario (aquí no).
      showBackButton: false,
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.recipes.isEmpty) {
            // Mostrar un mensaje y botón cuando no hay recetas.
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    child: Icon(
                      Icons.restaurant_menu,
                      size: 80, // Reducido para mantener proporciones.
                      color: Colors.orange[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '¡Agrega tu primera receta!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/add-recipe'),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Crear Receta',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            );
          }
          // Usar GridView para mostrar recetas.
          return GridView.custom(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1.0, // Ajustado para tarjetas más pequeñas.
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
                return RecipeCard(recipe: provider.recipes[index]);
              },
              childCount: provider.recipes.length,
              addAutomaticKeepAlives: true,
            ),
          );
        },
      ),
      // Botón flotante con animación para agregar recetas.
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add-recipe'),
        tooltip: 'Agregar Receta',
        backgroundColor: Colors.orange[600],
        elevation: 6,
        hoverElevation: 12,
        focusElevation: 12,
        child: const AnimatedScale(
          duration: Duration(milliseconds: 200),
          scale: 1.0,
          child: Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}