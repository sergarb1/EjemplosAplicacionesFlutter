import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget personalizado que representa una "burbuja" o "chips" para mostrar habilidades
class SkillBubble extends StatelessWidget {
  final String skill; // Texto de la habilidad que se mostrará

  // Constructor: Requiere una clave (key) y el texto de la habilidad (skill)
  const SkillBubble({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tema actual de la aplicación para mantener la consistencia de colores
    final theme = Theme.of(context);

    return AnimatedContainer(
      // Duración de la animación si las propiedades del contenedor cambian
      duration: const Duration(milliseconds: 300),
      // Espaciado interno (padding) dentro de la burbuja
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      // Decoración del contenedor (fondo y bordes redondeados)
      decoration: BoxDecoration(
        // Color de fondo: usa el color primario del tema con un 20% de opacidad
        color: theme.colorScheme.primary.withValues(alpha:0.2),
        // Bordes completamente redondeados (forma de cápsula/píldora)
        borderRadius: BorderRadius.circular(16),
      ),
      // Texto que muestra la habilidad
      child: Text(
        skill,
        // Estilo de texto: usa la fuente Poppins con tamaño 14
        style: GoogleFonts.poppins(fontSize: 14),
      ),
    );
  }
}
