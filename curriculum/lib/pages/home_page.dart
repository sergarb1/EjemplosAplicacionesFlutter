// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:curriculum/providers/cv_provider.dart'; // Proveedor de datos del CV
import 'package:curriculum/widgets/custom_scaffold.dart'; // Scaffold personalizado
import 'package:curriculum/widgets/section_card.dart'; // Widget para tarjetas de secciones
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas

// Clase para la pantalla principal del currículum
class HomeScreen extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const HomeScreen({super.key});

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

    // Obtenemos los datos del CV
    final cv = cvProvider.cvData!;

    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      // Cuerpo de la pantalla con desplazamiento
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor del contenido
        child: Column(
          children: [
            // Imagen de perfil con accesibilidad
            Semantics(
              label: 'Foto de perfil de ${cv.name}', // Etiqueta para lectores de pantalla
              child: CircleAvatar(
                radius: 60, // Tamaño del avatar
                backgroundImage: AssetImage(cv.profileImage), // Imagen de perfil
                onBackgroundImageError: (error, stackTrace) => Container(
                  color: theme.colorScheme.error.withValues(alpha:0.2), // Fondo en caso de error
                  child: const Icon(Icons.person, size: 60), // Icono por defecto
                ),
              ),
            ),
            const SizedBox(height: 16), // Espacio vertical
            // Nombre completo
            Text(
              cv.name,
              style: GoogleFonts.poppins(
                fontSize: 28, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: theme.colorScheme.primary, // Color del tema
              ),
            ),
            // Título profesional
            Text(
              cv.title,
              style: GoogleFonts.poppins(fontSize: 18, color: theme.colorScheme.onSurface), // Estilo de fuente
            ),
            const SizedBox(height: 16), // Espacio vertical
            // Resumen profesional
            Text(
              cv.summary,
              style: GoogleFonts.poppins(fontSize: 16, height: 1.5), // Estilo de fuente con interlineado
              textAlign: TextAlign.center, // Centra el texto
            ),
            const SizedBox(height: 32), // Espacio vertical
            // Tarjeta para navegar a la sección de formación
            SectionCard(
              title: 'Formación', // Título de la tarjeta
              icon: Icons.school, // Icono de educación
              onTap: () => context.go('/education'), // Navega a la ruta de formación
            ),
            // Tarjeta para navegar a la sección de experiencia
            SectionCard(
              title: 'Experiencia', // Título de la tarjeta
              icon: Icons.work, // Icono de trabajo
              onTap: () => context.go('/experience'), // Navega a la ruta de experiencia
            ),
            // Tarjeta para navegar a la sección de habilidades
            SectionCard(
              title: 'Habilidades', // Título de la tarjeta
              icon: Icons.build, // Icono de habilidades
              onTap: () => context.go('/skills'), // Navega a la ruta de habilidades
            ),
            // Tarjeta para navegar a la sección de contacto
            SectionCard(
              title: 'Contacto', // Título de la tarjeta
              icon: Icons.contact_mail, // Icono de contacto
              onTap: () => context.go('/contact'), // Navega a la ruta de contacto
            ),
          ],
        ),
      ),
    );
  }
}