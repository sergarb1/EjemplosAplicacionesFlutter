// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:curriculum/providers/cv_provider.dart'; // Proveedor de datos del CV
import 'package:curriculum/widgets/custom_scaffold.dart'; // Scaffold personalizado
import 'package:curriculum/widgets/skill_bubble.dart'; // Widget para mostrar habilidades
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas

// Clase para la pantalla de habilidades
class SkillsScreen extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor de datos del CV
    final cvProvider = context.watch<CvProvider>();
    // Obtenemos el tema de la app para usar estilos
    final theme = Theme.of(context);

    // Si los datos del CV no están disponibles, mostramos un indicador de carga
    if (cvProvider.cvData == null) {
      return const CustomScaffold(
        body: Center(child: CircularProgressIndicator()), // Indicador de carga
      );
    }

    // Obtenemos las listas de habilidades e idiomas del CV
    final technicalSkills = cvProvider.cvData!.technicalSkills;
    final softSkills = cvProvider.cvData!.softSkills;
    final languages = cvProvider.cvData!.languages;

    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      // Botón para regresar a la pantalla principal
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Icono de flecha atrás
        onPressed: () => context.go('/'), // Navega a la ruta principal
      ),
      // Cuerpo de la pantalla con desplazamiento
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor del contenido
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea contenido a la izquierda
          children: [
            // Título para habilidades técnicas
            Text(
              'Habilidades Técnicas', // Texto del título
              style: GoogleFonts.poppins(
                fontSize: 24, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: theme.colorScheme.primary, // Color del tema
              ),
            ),
            const SizedBox(height: 16), // Espacio vertical
            // Lista de habilidades técnicas en burbujas
            Wrap(
              spacing: 8.0, // Espacio horizontal entre burbujas
              runSpacing: 8.0, // Espacio vertical entre burbujas
              children: technicalSkills.map((skill) => SkillBubble(skill: skill)).toList(), // Convierte habilidades en widgets
            ),
            const SizedBox(height: 24), // Espacio vertical
            // Título para habilidades blandas
            Text(
              'Habilidades Blandas', // Texto del título
              style: GoogleFonts.poppins(
                fontSize: 24, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: theme.colorScheme.primary, // Color del tema
              ),
            ),
            const SizedBox(height: 16), // Espacio vertical
            // Lista de habilidades blandas en burbujas
            Wrap(
              spacing: 8.0, // Espacio horizontal entre burbujas
              runSpacing: 8.0, // Espacio vertical entre burbujas
              children: softSkills.map((skill) => SkillBubble(skill: skill)).toList(), // Convierte habilidades en widgets
            ),
            const SizedBox(height: 24), // Espacio vertical
            // Título para idiomas
            Text(
              'Idiomas', // Texto del título
              style: GoogleFonts.poppins(
                fontSize: 24, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: theme.colorScheme.primary, // Color del tema
              ),
            ),
            const SizedBox(height: 16), // Espacio vertical
            // Lista de idiomas en burbujas
            Wrap(
              spacing: 8.0, // Espacio horizontal entre burbujas
              runSpacing: 8.0, // Espacio vertical entre burbujas
              children: languages.map((lang) => SkillBubble(skill: '${lang.name}: ${lang.level}')).toList(), // Convierte idiomas en widgets
            ),
          ],
        ),
      ),
    );
  }
}