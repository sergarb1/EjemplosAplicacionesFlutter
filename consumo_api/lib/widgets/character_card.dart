// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:consumo_api/models/character_model.dart'; // Modelo para personajes

// Clase para mostrar una tarjeta de personaje
class CharacterCard extends StatelessWidget {
  // Propiedad para el personaje que se mostrará
  final CharacterModel character;

  // Constructor: requiere un objeto CharacterModel
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    // Contenedor animado para transiciones suaves
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Duración de la animación
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Margen vertical
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
        elevation: 4, // Sombra de la tarjeta
        child: InkWell(
          onTap: () => context.go('/character/${character.id}'), // Navega a detalles del personaje
          borderRadius: BorderRadius.circular(12), // Bordes redondeados para el toque
          child: Row(
            children: [
              // Imagen del personaje
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)), // Bordes redondeados a la izquierda
                child: Image.network(
                  character.image, // URL de la imagen
                  width: 100, // Ancho fijo
                  height: 100, // Altura fija
                  fit: BoxFit.cover, // Ajusta la imagen al espacio
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('Error loading image: ${character.image}, error: $error'); // Log del error
                    return const Icon(Icons.person, size: 100, color: Colors.grey); // Icono por defecto si falla
                  },
                ),
              ),
              // Contenido de texto de la tarjeta
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Espacio interno
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
                    children: [
                      // Nombre del personaje
                      Text(
                        character.name,
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold), // Estilo de fuente
                      ),
                      // Estado del personaje
                      Text(
                        'Estado: ${character.status}',
                        style: GoogleFonts.poppins(fontSize: 14), // Estilo de fuente
                      ),
                      // Especie del personaje
                      Text(
                        'Especie: ${character.species}',
                        style: GoogleFonts.poppins(fontSize: 14), // Estilo de fuente
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}