// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:consumo_api/widgets/custom_scaffold.dart'; // Widget personalizado
import 'package:consumo_api/widgets/section_card.dart'; // Widget para tarjetas de secciones

// Clase para la pantalla principal de la app
class HomePage extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tema de la app para usar colores y estilos
    final theme = Theme.of(context);

    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      // Cuerpo de la pantalla con desplazamiento
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor del contenido
        child: Column(
          children: [
            // Título principal de la pantalla
            Text(
              'Rick and Morty API', // Texto del título
              style: GoogleFonts.poppins(
                fontSize: 28, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: theme.colorScheme.primary, // Color del tema
              ),
            ),
            const SizedBox(height: 16), // Espacio vertical
            // Descripción de la app
            Text(
              'Explora personajes, localizaciones y episodios del universo de Rick and Morty.', // Texto descriptivo
              style: GoogleFonts.poppins(fontSize: 16, height: 1.5), // Estilo de fuente
              textAlign: TextAlign.center, // Centra el texto
            ),
            const SizedBox(height: 32), // Espacio vertical
            // Tarjeta para navegar a la sección de personajes
            SectionCard(
              title: 'Personajes', // Título de la tarjeta
              icon: Icons.person, // Icono de personaje
              onTap: () => context.go('/characters'), // Navega a la ruta de personajes
            ),
            // Tarjeta para navegar a la sección de localizaciones
            SectionCard(
              title: 'Localizaciones', // Título de la tarjeta
              icon: Icons.location_on, // Icono de ubicación
              onTap: () => context.go('/locations'), // Navega a la ruta de localizaciones
            ),
            // Tarjeta para navegar a la sección de episodios
            SectionCard(
              title: 'Episodios', // Título de la tarjeta
              icon: Icons.tv, // Icono de episodio
              onTap: () => context.go('/episodes'), // Navega a la ruta de episodios
            ),
          ],
        ),
      ),
    );
  }
}