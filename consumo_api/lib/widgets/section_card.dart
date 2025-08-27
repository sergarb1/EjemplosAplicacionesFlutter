import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// SectionCard es un widget reutilizable que muestra una tarjeta interactiva con un título y un ícono.
// Se usa en HomePage para navegar a las secciones de personajes, localizaciones y episodios.
// Soporta animaciones, accesibilidad y diseño responsivo.
class SectionCard extends StatelessWidget {
  // Propiedades parametrizables para personalizar la tarjeta
  final String title; // Título de la tarjeta (e.g., "Personajes")
  final IconData icon; // Ícono asociado a la tarjeta
  final VoidCallback onTap; // Función que se ejecuta al tocar la tarjeta

  // Constructor con parámetros requeridos
  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Obtiene el tema actual para aplicar colores de Material 3
    final theme = Theme.of(context);

    return Padding(
      // Espaciado vertical para separar las tarjetas
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        // Animación suave al interactuar (cambio de sombra o tamaño)
        duration: const Duration(milliseconds: 300),
        child: Card(
          // Forma de la tarjeta con esquinas redondeadas (Material 3)
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // Sombra para dar profundidad
          elevation: 4,
          child: InkWell(
            // Habilita la interacción táctil con efecto de ripple
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              // Espaciado interno para un diseño limpio
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Ícono de la sección con color del tema
                  Icon(
                    icon,
                    size: 32,
                    color: theme.colorScheme.primary,
                    semanticLabel: 'Ícono de $title', // Accesibilidad para lectores de pantalla
                  ),
                  const SizedBox(width: 16), // Espacio entre ícono y texto
                  // Título de la sección
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600, // Negrita ligera para énfasis
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  // Ícono de flecha para indicar navegabilidad
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    semanticLabel: 'Navegar a $title', // Accesibilidad
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}