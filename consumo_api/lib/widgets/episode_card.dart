// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:consumo_api/models/episode_model.dart'; // Modelo para episodios

// Clase para mostrar una tarjeta de episodio
class EpisodeCard extends StatelessWidget {
  // Propiedad para el episodio que se mostrará
  final EpisodeModel episode;

  // Constructor: requiere un objeto EpisodeModel
  const EpisodeCard({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    // Contenedor animado para transiciones suaves
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Duración de la animación
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Margen vertical
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
        elevation: 4, // Sombra de la tarjeta
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0), // Espacio interno
          // Título de la tarjeta: nombre del episodio
          title: Text(
            episode.name,
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold), // Estilo de fuente
          ),
          // Subtítulo: código del episodio y fecha de emisión
          subtitle: Text(
            'Código: ${episode.episode}\nFecha: ${episode.airDate}', // Muestra código y fecha
            style: GoogleFonts.poppins(fontSize: 14), // Estilo de fuente
          ),
        ),
      ),
    );
  }
}