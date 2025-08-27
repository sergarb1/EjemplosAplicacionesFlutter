// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas

// Clase para mostrar una tarjeta de sección navegable
class SectionCard extends StatelessWidget {
  // Propiedades de la tarjeta
  final String title; // Título de la sección
  final IconData icon; // Icono representativo de la sección
  final VoidCallback onTap; // Función a ejecutar al tocar la tarjeta

  // Constructor: requiere título, icono y función onTap
  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tema de la app para usar estilos
    final theme = Theme.of(context);

    // Contenedor animado para transiciones suaves
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Duración de la animación
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Margen vertical y horizontal
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
        elevation: 4, // Sombra de la tarjeta
        child: InkWell(
          onTap: onTap, // Ejecuta la función al tocar
          borderRadius: BorderRadius.circular(12), // Bordes redondeados para el toque
          child: ListTile(
            leading: Icon(icon, color: theme.colorScheme.primary), // Icono a la izquierda
            title: Text(
              title, // Título de la sección
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold), // Estilo de fuente
            ),
            trailing: const Icon(Icons.arrow_forward_ios), // Icono de flecha a la derecha
          ),
        ),
      ),
    );
  }
}