// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas
import 'package:google_fonts/google_fonts.dart'; // Para usar fuentes personalizadas
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:consumo_api/providers/api_provider.dart'; // Proveedor con datos de la API
import 'package:consumo_api/widgets/custom_scaffold.dart'; // Widget personalizado

// Clase para la pantalla de detalles de un personaje
class CharacterDetailPage extends StatelessWidget {
  // Propiedad para identificar el personaje por su ID
  final int id;

  // Constructor: requiere un ID para mostrar los detalles del personaje
  const CharacterDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor de datos para acceder a la lista de personajes
    final apiProvider = context.watch<ApiProvider>();
    // Obtenemos el tema de la app para usar colores y estilos
    final theme = Theme.of(context);
    // Buscamos el personaje por su ID, si no se encuentra, usamos el primero
    final character = apiProvider.characters.firstWhere((c) => c.id == id, orElse: () => apiProvider.characters[0]);

    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      // Botón para regresar a la pantalla de personajes
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Icono de flecha atrás
        onPressed: () => context.go('/characters'), // Navega a la ruta /characters
      ),
      // Cuerpo de la pantalla con desplazamiento
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor del contenido
        child: Column(
          children: [
            // Imagen del personaje con accesibilidad
            Semantics(
              label: 'Imagen de ${character.name}', // Etiqueta para lectores de pantalla
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
                child: Image.network(
                  character.image, // URL de la imagen
                  height: 200, // Altura fija
                  width: 200, // Ancho fijo
                  fit: BoxFit.cover, // Ajusta la imagen al espacio
                  // Maneja errores al cargar la imagen
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('Error loading image: ${character.image}, error: $error'); // Log del error
                    return const Icon(Icons.person, size: 200, color: Colors.grey); // Icono por defecto
                  },
                ),
              ),
            ),
            const SizedBox(height: 16), // Espacio vertical
            // Nombre del personaje con estilo personalizado
            Text(
              character.name,
              style: GoogleFonts.poppins(
                fontSize: 24, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: theme.colorScheme.primary, // Color del tema
              ),
            ),
            const SizedBox(height: 8), // Espacio vertical
            // Estado del personaje
            Text(
              'Estado: ${character.status}',
              style: GoogleFonts.poppins(fontSize: 16), // Estilo de fuente
            ),
            // Especie del personaje
            Text(
              'Especie: ${character.species}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            // Género del personaje
            Text(
              'Género: ${character.gender}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            // Origen del personaje
            Text(
              'Origen: ${character.origin}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            // Ubicación actual del personaje
            Text(
              'Ubicación: ${character.location}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}