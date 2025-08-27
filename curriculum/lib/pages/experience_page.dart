// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:curriculum/providers/cv_provider.dart'; // Proveedor de datos del CV
import 'package:curriculum/widgets/custom_scaffold.dart'; // Scaffold personalizado
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas

// Clase para la pantalla de experiencia laboral
class ExperienceScreen extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const ExperienceScreen({super.key});

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

    // Obtenemos la lista de experiencias laborales del CV
    final experience = cvProvider.cvData!.experience;

    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      // Botón para regresar a la pantalla principal
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Icono de flecha atrás
        onPressed: () => context.go('/'), // Navega a la ruta principal
      ),
      // Cuerpo de la pantalla con una columna
      body: Column(
        children: [
          // Título de la pantalla
          Padding(
            padding: const EdgeInsets.all(16.0), // Espacio alrededor
            child: Text(
              'Experiencia Laboral', // Texto del título
              style: GoogleFonts.poppins(
                fontSize: 24, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: theme.colorScheme.primary, // Color del tema
              ),
            ),
          ),
          // Lista de experiencias laborales
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0), // Espacio alrededor
              itemCount: experience.length, // Número de experiencias
              itemBuilder: (context, index) {
                // Obtenemos la experiencia en el índice actual
                final exp = experience[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0), // Margen vertical
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
                  elevation: 4, // Sombra de la tarjeta
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0), // Espacio interno
                    // Título: puesto de trabajo
                    title: Text(
                      exp.position,
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold), // Estilo de fuente
                    ),
                    // Subtítulo: empresa, período y descripción
                    subtitle: Text(
                      '${exp.company}\n${exp.period}\n${exp.description}', // Muestra empresa, período y descripción
                      style: GoogleFonts.poppins(fontSize: 14), // Estilo de fuente
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}