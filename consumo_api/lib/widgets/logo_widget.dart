import 'package:flutter/material.dart';

// LogoWidget muestra el logo de la aplicación en la AppBar con bordes redondeados y un borde decorativo.
// Está diseñado para un logo de 240x70 píxeles, ocupando más espacio en la AppBar.
// Incluye accesibilidad y manejo de errores para una experiencia robusta.
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtiene el tema actual para usar colores de Material 3
    final theme = Theme.of(context);

    return Semantics(
      // Etiqueta para lectores de pantalla, mejora la accesibilidad
      label: 'Logo de Rick and Morty API',
      child: Container(
        // Añade un borde decorativo alrededor de la imagen
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.onPrimary.withOpacity(0.8), // Borde claro, acorde con el tema
            width: 2, // Grosor del borde
          ),
          borderRadius: BorderRadius.circular(16), // Bordes redondeados más pronunciados
        ),
        // ClipRRect redondea los bordes de la imagen
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14), // Ligeramente menor que el contenedor para un borde visible
          child: Image.asset(
            'assets/images/logo.png',
            // Dimensiones para ocupar más espacio (mantiene proporción 240x70)
            height: 50, // Aumenta el alto para mayor presencia en la AppBar
            width: 180, // Ajustado para mantener la proporción del logo
            fit: BoxFit.contain, // Asegura que el logo no se distorsione
            errorBuilder: (context, error, stackTrace) {
              // Maneja errores si el logo no carga
              debugPrint('Error loading logo: $error');
              return Container(
                height: 50,
                width: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.error,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.error,
                  size: 40,
                  color: theme.colorScheme.error,
                  semanticLabel: 'Error al cargar el logo',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}