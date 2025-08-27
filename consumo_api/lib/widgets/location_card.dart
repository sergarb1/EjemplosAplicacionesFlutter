// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:consumo_api/models/location_model.dart'; // Modelo para localizaciones

// Clase para mostrar una tarjeta de localización
class LocationCard extends StatelessWidget {
  // Propiedad para la localización que se mostrará
  final LocationModel location;

  // Constructor: requiere un objeto LocationModel
  const LocationCard({super.key, required this.location});

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
          // Título de la tarjeta: nombre de la localización
          title: Text(
            location.name,
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold), // Estilo de fuente
          ),
          // Subtítulo: tipo y dimensión de la localización
          subtitle: Text(
            'Tipo: ${location.type}\nDimensión: ${location.dimension}', // Muestra tipo y dimensión
            style: GoogleFonts.poppins(fontSize: 14), // Estilo de fuente
          ),
        ),
      ),
    );
  }
}